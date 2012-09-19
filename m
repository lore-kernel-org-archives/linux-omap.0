From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: Fix gadget pullup in SS mode
Date: Wed, 19 Sep 2012 11:50:53 -0500
Message-ID: <CAEgRx2yXStORBknr2hoMcobMO8wFGuKr4bvzZwEQHQQcHVH76Q@mail.gmail.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-3-git-send-email-kishon@ti.com>
 <20120919115306.GG3772@arwen.pp.htv.fi>
 <CAEgRx2zOVn0zV39-cuPuj4n4HRgQmywy_NY4KTe0qEgeC+NEkw@mail.gmail.com>
 <20120919160450.GA7510@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5350560649947102770=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120919160450.GA7510@arwen.pp.htv.fi>
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

--===============5350560649947102770==
Content-Type: multipart/alternative; boundary=f46d043c82224d0da904ca10cf49

--f46d043c82224d0da904ca10cf49
Content-Type: text/plain; charset=ISO-8859-1

Felipe,

On Wed, Sep 19, 2012 at 11:04 AM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Wed, Sep 19, 2012 at 10:02:48AM -0500, Sonasath, Moiz wrote:
> > Felipe,
> >
> > On Wed, Sep 19, 2012 at 6:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> >
> > > Hi,
> > >
> > > On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I wrote:
> > > > From: Moiz Sonasath <m-sonasath@ti.com>
> > > >
> > > > For the gadget pullup functionality to work in
> > > > SS mode it requires a particular sequence of
> > > > toggling the run-stop bit. Here is the required
> > > > sequence:
> > > >
> > > > - Set DCTL[31]
> > > > - Clear DCTL[31]
> > > > - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > > > - Clear DCTL[8:5] = 0x00
> > > > - Set DCTL[8:5] = 0x05
> > > > - Wait 25 Ms
> > > > - Set DCTL[31]
> > > > - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > > >
> > > > Tested rigourously the gadget pull-up functionality
> > > > in bot HS and SS modes.
> > > >
> > > > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> > > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > >
> > > this needs to split into three patches:
> > >
> > > add new poweron field, implement it on omap-usb3, use it on
> > > dwc3/gadget.c
> > >
> > > btw, I don't think the changes to run_stop bit are necessary and if
> they
> > > are, that'd either be a silicon errata or it would've been mentioned on
> > > the databook. I don't remember seeing that on the databook so I'm
> > > assuming that this is caused by a bad use of the PHY.
> > >
> > > Why that mdelay(25) ? why 25 ms ? That's quite a long time, actually.
> > >
> >
> > Felipe, This is infact a HW bug that the Si-Val team did accept and gave
> us
> > this workaround sequence with the precise delay :-)
> >
> > Supposedly this will be fixed in ES 2.0.
>
> in that case this doesn't have to go to mainline since we're not
> supporting ES1.0 in mainline :-)
>
> at minimum this should've come with a proper revision check anyway.
>

Actually most of it is under a rev check :)

Perhaps the last: usb_phy_shutdown(dwc->usb3_phy);
in the else part should be in
if (dwc->revision <= DWC3_REVISION_187A) check

Kishon, can you resend please?

>
> --
> balbi
>



-- 
Regards
Moiz Sonasath
Android Kernel Team

--f46d043c82224d0da904ca10cf49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Felipe,<br><br><div class=3D"gmail_quote">On Wed, Sep 19, 2012 at 11:04 AM,=
 Felipe Balbi <span dir=3D"ltr">&lt;<a href=3D"mailto:balbi@ti.com" target=
=3D"_blank">balbi@ti.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
Hi,<br>
<div><div class=3D"h5"><br>
On Wed, Sep 19, 2012 at 10:02:48AM -0500, Sonasath, Moiz wrote:<br>
&gt; Felipe,<br>
&gt;<br>
&gt; On Wed, Sep 19, 2012 at 6:53 AM, Felipe Balbi &lt;<a href=3D"mailto:ba=
lbi@ti.com">balbi@ti.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I =
wrote:<br>
&gt; &gt; &gt; From: Moiz Sonasath &lt;<a href=3D"mailto:m-sonasath@ti.com"=
>m-sonasath@ti.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; For the gadget pullup functionality to work in<br>
&gt; &gt; &gt; SS mode it requires a particular sequence of<br>
&gt; &gt; &gt; toggling the run-stop bit. Here is the required<br>
&gt; &gt; &gt; sequence:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - Set DCTL[31]<br>
&gt; &gt; &gt; - Clear DCTL[31]<br>
&gt; &gt; &gt; - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]<br>
&gt; &gt; &gt; - Clear DCTL[8:5] =3D 0x00<br>
&gt; &gt; &gt; - Set DCTL[8:5] =3D 0x05<br>
&gt; &gt; &gt; - Wait 25 Ms<br>
&gt; &gt; &gt; - Set DCTL[31]<br>
&gt; &gt; &gt; - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Tested rigourously the gadget pull-up functionality<br>
&gt; &gt; &gt; in bot HS and SS modes.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Moiz Sonasath &lt;<a href=3D"mailto:m-sonasat=
h@ti.com">m-sonasath@ti.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Kishon Vijay Abraham I &lt;<a href=3D"mailto:=
kishon@ti.com">kishon@ti.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; this needs to split into three patches:<br>
&gt; &gt;<br>
&gt; &gt; add new poweron field, implement it on omap-usb3, use it on<br>
&gt; &gt; dwc3/gadget.c<br>
&gt; &gt;<br>
&gt; &gt; btw, I don&#39;t think the changes to run_stop bit are necessary =
and if they<br>
&gt; &gt; are, that&#39;d either be a silicon errata or it would&#39;ve bee=
n mentioned on<br>
&gt; &gt; the databook. I don&#39;t remember seeing that on the databook so=
 I&#39;m<br>
&gt; &gt; assuming that this is caused by a bad use of the PHY.<br>
&gt; &gt;<br>
&gt; &gt; Why that mdelay(25) ? why 25 ms ? That&#39;s quite a long time, a=
ctually.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Felipe, This is infact a HW bug that the Si-Val team did accept and ga=
ve us<br>
&gt; this workaround sequence with the precise delay :-)<br>
&gt;<br>
&gt; Supposedly this will be fixed in ES 2.0.<br>
<br>
</div></div>in that case this doesn&#39;t have to go to mainline since we&#=
39;re not<br>
supporting ES1.0 in mainline :-)<br>
<br>
at minimum this should&#39;ve come with a proper revision check anyway.<br>=
</blockquote><div><br>Actually most of it is under a rev check :) <br><br>P=
erhaps the last: usb_phy_shutdown(dwc-&gt;usb3_phy); <br>in the else part s=
hould be in <br>
if (dwc-&gt;revision &lt;=3D DWC3_REVISION_187A) check<br><br>Kishon, can y=
ou resend please?<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">

<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
balbi<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards<b=
r>Moiz Sonasath<br>Android Kernel Team<br><br>

--f46d043c82224d0da904ca10cf49--


--===============5350560649947102770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5350560649947102770==--
