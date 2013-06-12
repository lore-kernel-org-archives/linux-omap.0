From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/5] dwc3: omap: adapt dwc3 to use extcon framework
Date: Wed, 12 Jun 2013 09:58:27 +0900
Message-ID: <CAGTfZH25uPJAkm0Nv4SP=LRVE3GWqncEmMFuGSWuMuBp1kigaA@mail.gmail.com>
References: <1370276020-17446-1-git-send-email-kishon@ti.com>
 <51B7C6E0.3000603@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5238615566093843807=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51B7C6E0.3000603-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5238615566093843807==
Content-Type: multipart/alternative; boundary=089e0149c0f0f6c3b004deea82d9

--089e0149c0f0f6c3b004deea82d9
Content-Type: text/plain; charset=ISO-8859-1

Hi Kishon,

I confused patch number. I applied patch2,3 on extcon-linus branch.

  extcon: Kconfig: Make extcon config type as bool
  extcon: add EXPORT_SYMBOL_GPL for exported functions


And I will reply comment about patch1 soon.

  extcon: Add an API to get extcon device from dt node


Thanks,
Chanwoo Choi



On Wed, Jun 12, 2013 at 9:54 AM, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi Kishon,
>
> Sorry for late reply.
>
> I applied patch1,2 on extcon-linus branch.
> -
> http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-linus
>
> But, I have comment of patch 3 about dt API. I send comment on patch 3
> mailing thread.
>
> Thanks,
> Chanwoo Choi
>
> On 06/04/2013 01:13 AM, Kishon Vijay Abraham I wrote:
> > The first three patches deals with cleanup of extcon inorder to get
> > through compilation without any issues. It also adds an API to get
> > extcon device from dt node which I felt was missing.
> >
> > The next two patches deals with adapt dwc3 to use extcon framework.
> > The 4th patch (usb: dwc3: omap: improve error handling of
> dwc3_omap_probe)
> > should have ideally been sent to Felipe, however since
> > there will be merge conflicts with the 5th patch
> > (usb: dwc3: use extcon fwrk to receive connect/disconnect)
> > in this series, I've sent in the same series.
> >
> > Once this patch series get merged, dwc3 in omap would be functional
> > in device mode. However there is still some discussion on modelling
> > SMPS10 regulator. Once that gets finalized, dwc3 should be functional
> > in host mode as well.
> >
> > Kishon Vijay Abraham I (5):
> >   extcon: Add an API to get extcon device from dt node
> >   extcon: Kconfig: Make extcon config type as bool
> >   extcon: add EXPORT_SYMBOL_GPL for exported functions
> >   usb: dwc3: omap: improve error handling of dwc3_omap_probe
> >   usb: dwc3: use extcon fwrk to receive connect/disconnect
> >
> >  Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
> >  drivers/extcon/Kconfig                             |    2 +-
> >  drivers/extcon/extcon-class.c                      |   42 +++++++
> >  drivers/usb/dwc3/dwc3-omap.c                       |  133
> ++++++++++++++++----
> >  include/linux/extcon.h                             |    8 ++
> >  include/linux/usb/dwc3-omap.h                      |   30 -----
> >  6 files changed, 168 insertions(+), 52 deletions(-)
> >  delete mode 100644 include/linux/usb/dwc3-omap.h
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--089e0149c0f0f6c3b004deea82d9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Kishon,<br><br>I confused patch number. I applied =
patch2,3 on extcon-linus branch.<br><pre>  extcon: Kconfig: Make extcon con=
fig type as bool
  extcon: add EXPORT_SYMBOL_GPL for exported functions</pre><br></div>And I=
 will reply comment about patch1 soon.<br><div><div><pre>  extcon: Add an A=
PI to get extcon device from dt node</pre><br></div><div>Thanks,<br>Chanwoo=
 Choi<br>
</div><div><br></div></div></div><div class=3D"gmail_extra"><br><br><div cl=
ass=3D"gmail_quote">On Wed, Jun 12, 2013 at 9:54 AM, Chanwoo Choi <span dir=
=3D"ltr">&lt;<a href=3D"mailto:cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">cw0=
0.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Kishon,<br>
<br>
Sorry for late reply.<br>
<br>
I applied patch1,2 on extcon-linus branch.<br>
- <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git=
/log/?h=3Dextcon-linus" target=3D"_blank">http://git.kernel.org/cgit/linux/=
kernel/git/chanwoo/extcon.git/log/?h=3Dextcon-linus</a><br>
<br>
But, I have comment of patch 3 about dt API. I send comment on patch 3 mail=
ing thread.<br>
<br>
Thanks,<br>
Chanwoo Choi<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On 06/04/2013 01:13 AM, Kishon Vijay Abraham I wrote:<br>
&gt; The first three patches deals with cleanup of extcon inorder to get<br=
>
&gt; through compilation without any issues. It also adds an API to get<br>
&gt; extcon device from dt node which I felt was missing.<br>
&gt;<br>
&gt; The next two patches deals with adapt dwc3 to use extcon framework.<br=
>
&gt; The 4th patch (usb: dwc3: omap: improve error handling of dwc3_omap_pr=
obe)<br>
&gt; should have ideally been sent to Felipe, however since<br>
&gt; there will be merge conflicts with the 5th patch<br>
&gt; (usb: dwc3: use extcon fwrk to receive connect/disconnect)<br>
&gt; in this series, I&#39;ve sent in the same series.<br>
&gt;<br>
&gt; Once this patch series get merged, dwc3 in omap would be functional<br=
>
&gt; in device mode. However there is still some discussion on modelling<br=
>
&gt; SMPS10 regulator. Once that gets finalized, dwc3 should be functional<=
br>
&gt; in host mode as well.<br>
&gt;<br>
&gt; Kishon Vijay Abraham I (5):<br>
&gt; =A0 extcon: Add an API to get extcon device from dt node<br>
&gt; =A0 extcon: Kconfig: Make extcon config type as bool<br>
&gt; =A0 extcon: add EXPORT_SYMBOL_GPL for exported functions<br>
&gt; =A0 usb: dwc3: omap: improve error handling of dwc3_omap_probe<br>
&gt; =A0 usb: dwc3: use extcon fwrk to receive connect/disconnect<br>
&gt;<br>
&gt; =A0Documentation/devicetree/bindings/usb/omap-usb.txt | =A0 =A05 +<br>
&gt; =A0drivers/extcon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A02 +-<br>
&gt; =A0drivers/extcon/extcon-class.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 42 +++++++<br>
&gt; =A0drivers/usb/dwc3/dwc3-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0133 ++++++++++++++++----<br>
&gt; =A0include/linux/extcon.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A08 ++<br>
&gt; =A0include/linux/usb/dwc3-omap.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 30 -----<br>
&gt; =A06 files changed, 168 insertions(+), 52 deletions(-)<br>
&gt; =A0delete mode 100644 include/linux/usb/dwc3-omap.h<br>
&gt;<br>
<br>
--<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">To unsubscribe from thi=
s list: send the line &quot;unsubscribe linux-kernel&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br></div>

--089e0149c0f0f6c3b004deea82d9--

--===============5238615566093843807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5238615566093843807==--
