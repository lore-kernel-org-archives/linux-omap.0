From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: Fix gadget pullup in SS mode
Date: Wed, 19 Sep 2012 10:02:48 -0500
Message-ID: <CAEgRx2zOVn0zV39-cuPuj4n4HRgQmywy_NY4KTe0qEgeC+NEkw@mail.gmail.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-3-git-send-email-kishon@ti.com>
 <20120919115306.GG3772@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0446849236211630062=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120919115306.GG3772@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: linux@arm.linux.org.uk, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, Kishon Vijay Abraham I <kishon@ti.com>, grant.likely@secretlab.ca, rob@landley.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0446849236211630062==
Content-Type: multipart/alternative; boundary=bcaec51b1bb9ceaeb604ca0f4c68

--bcaec51b1bb9ceaeb604ca0f4c68
Content-Type: text/plain; charset=ISO-8859-1

Felipe,

On Wed, Sep 19, 2012 at 6:53 AM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I wrote:
> > From: Moiz Sonasath <m-sonasath@ti.com>
> >
> > For the gadget pullup functionality to work in
> > SS mode it requires a particular sequence of
> > toggling the run-stop bit. Here is the required
> > sequence:
> >
> > - Set DCTL[31]
> > - Clear DCTL[31]
> > - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > - Clear DCTL[8:5] = 0x00
> > - Set DCTL[8:5] = 0x05
> > - Wait 25 Ms
> > - Set DCTL[31]
> > - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> >
> > Tested rigourously the gadget pull-up functionality
> > in bot HS and SS modes.
> >
> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> this needs to split into three patches:
>
> add new poweron field, implement it on omap-usb3, use it on
> dwc3/gadget.c
>
> btw, I don't think the changes to run_stop bit are necessary and if they
> are, that'd either be a silicon errata or it would've been mentioned on
> the databook. I don't remember seeing that on the databook so I'm
> assuming that this is caused by a bad use of the PHY.
>
> Why that mdelay(25) ? why 25 ms ? That's quite a long time, actually.
>

Felipe, This is infact a HW bug that the Si-Val team did accept and gave us
this workaround sequence with the precise delay :-)

Supposedly this will be fixed in ES 2.0.


>
> > ---
> >  drivers/usb/dwc3/gadget.c   |   21 +++++++++++++++------
> >  drivers/usb/phy/omap-usb3.c |   16 ++++++++++++++++
> >  include/linux/usb/phy.h     |   10 +++++++++-
> >  3 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 58fdfad..bcc0102 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -49,6 +49,7 @@
> >
> >  #include <linux/usb/ch9.h>
> >  #include <linux/usb/gadget.h>
> > +#include <linux/usb/otg.h>
> >
> >  #include "core.h"
> >  #include "gadget.h"
> > @@ -1417,19 +1418,27 @@ static int dwc3_gadget_run_stop(struct dwc3
> *dwc, int is_on)
> >       reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> >       if (is_on) {
> >               if (dwc->revision <= DWC3_REVISION_187A) {
> > -                     reg &= ~DWC3_DCTL_TRGTULST_MASK;
> > -                     reg |= DWC3_DCTL_TRGTULST_RX_DET;
> > +                     reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     reg |= DWC3_DCTL_ULSTCHNG_RX_DETECT;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     mdelay(25);
> > +                     reg |= DWC3_DCTL_RUN_STOP;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     usb_phy_poweron(dwc->usb3_phy);
> >               }
> >
> > -             if (dwc->revision >= DWC3_REVISION_194A)
> > +             if (dwc->revision >= DWC3_REVISION_194A) {
> >                       reg &= ~DWC3_DCTL_KEEP_CONNECT;
> > -             reg |= DWC3_DCTL_RUN_STOP;
> > +                     reg |= DWC3_DCTL_RUN_STOP;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +             }
> >       } else {
> >               reg &= ~DWC3_DCTL_RUN_STOP;
> > +             dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +             usb_phy_shutdown(dwc->usb3_phy);
> >       }
> >
> > -     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
>
> I'd prefer to hold all values on the variable and write only one.
>
> --
> balbi
>



-- 
Regards
Moiz Sonasath
Android Kernel Team

--bcaec51b1bb9ceaeb604ca0f4c68
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Felipe,<br><br><div class=3D"gmail_quote">On Wed, Sep 19, 2012 at 6:53 AM, =
Felipe Balbi <span dir=3D"ltr">&lt;<a href=3D"mailto:balbi@ti.com" target=
=3D"_blank">balbi@ti.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
Hi,<br>
<div class=3D"im"><br>
On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I wrote:<br>
&gt; From: Moiz Sonasath &lt;<a href=3D"mailto:m-sonasath@ti.com">m-sonasat=
h@ti.com</a>&gt;<br>
&gt;<br>
&gt; For the gadget pullup functionality to work in<br>
&gt; SS mode it requires a particular sequence of<br>
&gt; toggling the run-stop bit. Here is the required<br>
&gt; sequence:<br>
&gt;<br>
&gt; - Set DCTL[31]<br>
&gt; - Clear DCTL[31]<br>
&gt; - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]<br>
&gt; - Clear DCTL[8:5] =3D 0x00<br>
&gt; - Set DCTL[8:5] =3D 0x05<br>
&gt; - Wait 25 Ms<br>
&gt; - Set DCTL[31]<br>
&gt; - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]<br>
&gt;<br>
&gt; Tested rigourously the gadget pull-up functionality<br>
&gt; in bot HS and SS modes.<br>
&gt;<br>
&gt; Signed-off-by: Moiz Sonasath &lt;<a href=3D"mailto:m-sonasath@ti.com">=
m-sonasath@ti.com</a>&gt;<br>
&gt; Signed-off-by: Kishon Vijay Abraham I &lt;<a href=3D"mailto:kishon@ti.=
com">kishon@ti.com</a>&gt;<br>
<br>
</div>this needs to split into three patches:<br>
<br>
add new poweron field, implement it on omap-usb3, use it on<br>
dwc3/gadget.c<br>
<br>
btw, I don&#39;t think the changes to run_stop bit are necessary and if the=
y<br>
are, that&#39;d either be a silicon errata or it would&#39;ve been mentione=
d on<br>
the databook. I don&#39;t remember seeing that on the databook so I&#39;m<b=
r>
assuming that this is caused by a bad use of the PHY.<br>
<br>
Why that mdelay(25) ? why 25 ms ? That&#39;s quite a long time, actually.<b=
r></blockquote><div><br>Felipe, This is infact a HW bug that the Si-Val tea=
m did accept and gave us this workaround sequence with the precise delay :-=
)<br>
<br>Supposedly this will be fixed in ES 2.0.<br>=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0drivers/usb/dwc3/gadget.c =A0 | =A0 21 +++++++++++++++------<br>
&gt; =A0drivers/usb/phy/omap-usb3.c | =A0 16 ++++++++++++++++<br>
&gt; =A0include/linux/usb/phy.h =A0 =A0 | =A0 10 +++++++++-<br>
&gt; =A03 files changed, 40 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c<br>
&gt; index 58fdfad..bcc0102 100644<br>
&gt; --- a/drivers/usb/dwc3/gadget.c<br>
&gt; +++ b/drivers/usb/dwc3/gadget.c<br>
&gt; @@ -49,6 +49,7 @@<br>
&gt;<br>
&gt; =A0#include &lt;linux/usb/ch9.h&gt;<br>
&gt; =A0#include &lt;linux/usb/gadget.h&gt;<br>
&gt; +#include &lt;linux/usb/otg.h&gt;<br>
&gt;<br>
&gt; =A0#include &quot;core.h&quot;<br>
&gt; =A0#include &quot;gadget.h&quot;<br>
&gt; @@ -1417,19 +1418,27 @@ static int dwc3_gadget_run_stop(struct dwc3 *d=
wc, int is_on)<br>
&gt; =A0 =A0 =A0 reg =3D dwc3_readl(dwc-&gt;regs, DWC3_DCTL);<br>
&gt; =A0 =A0 =A0 if (is_on) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc-&gt;revision &lt;=3D DWC3_REVISION=
_187A) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &amp;=3D ~DWC3_DCTL_TRGT=
ULST_MASK;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DWC3_DCTL_TRGTULST_=
RX_DET;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &amp;=3D ~DWC3_DCTL_ULST=
CHNGREQ_MASK;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc3_writel(dwc-&gt;regs, DW=
C3_DCTL, reg);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DWC3_DCTL_ULSTCHNG_=
RX_DETECT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc3_writel(dwc-&gt;regs, DW=
C3_DCTL, reg);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(25);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DWC3_DCTL_RUN_STOP;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc3_writel(dwc-&gt;regs, DW=
C3_DCTL, reg);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_phy_poweron(dwc-&gt;usb3=
_phy);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 if (dwc-&gt;revision &gt;=3D DWC3_REVISION_1=
94A)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (dwc-&gt;revision &gt;=3D DWC3_REVISION_1=
94A) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &amp;=3D ~DWC3_DCTL_KE=
EP_CONNECT;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DWC3_DCTL_RUN_STOP;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DWC3_DCTL_RUN_STOP;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc3_writel(dwc-&gt;regs, DW=
C3_DCTL, reg);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &amp;=3D ~DWC3_DCTL_RUN_STOP;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dwc3_writel(dwc-&gt;regs, DWC3_DCTL, reg);<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 usb_phy_shutdown(dwc-&gt;usb3_phy);<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 dwc3_writel(dwc-&gt;regs, DWC3_DCTL, reg);<br>
<br>
</div></div>I&#39;d prefer to hold all values on the variable and write onl=
y one.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
balbi<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards<b=
r>Moiz Sonasath<br>Android Kernel Team<br><br>

--bcaec51b1bb9ceaeb604ca0f4c68--


--===============0446849236211630062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0446849236211630062==--
