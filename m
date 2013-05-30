From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] palmas usb driver
Date: Thu, 30 May 2013 11:17:49 +0900
Message-ID: <CAGTfZH32UZbnqN=dZcA_cWy+wiV1y6K3bw8qJf-uptsw3FFCLw@mail.gmail.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
 <20130528173554.GD15794@arwen.pp.htv.fi> <51A59AC9.9000908@ti.com>
 <20130529173851.GC21290@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5524638744528228549=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130529173851.GC21290-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5524638744528228549==
Content-Type: multipart/alternative; boundary=089e013c6ee4d5b14a04dde61a68

--089e013c6ee4d5b14a04dde61a68
Content-Type: text/plain; charset=ISO-8859-1

On Thu, May 30, 2013 at 2:38 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:

> Hi,
>
> On Wed, May 29, 2013 at 11:36:01AM +0530, Kishon Vijay Abraham I wrote:
> > Hi Felipe,
> >
> > On Tuesday 28 May 2013 11:05 PM, Felipe Balbi wrote:
> > >On Fri, May 24, 2013 at 08:01:33PM +0530, Kishon Vijay Abraham I wrote:
> > >>This patch series adds driver for palmas usb which is used to detect
> > >>attach/detach events of usb device and usb host.
> > >>
> > >>[PATCH v5 2/3] extcon: Palmas Extcon Driver which was sent previously
> > >>is added in this patch series itself. The revision history is added
> > >>in the patch comments section.
> > >>
> > >>A checkpatch warning "WARNING: static const char * array should
> > >>probably be static const char * const"is ignored since it introduces a
> > >>compilation warning.
> > >>
> > >>Graeme Gregory (2):
> > >>   drivers: regulator: palmas: add an API to set/clear the switch bit
> on
> > >>     SMPS10
> > >>   extcon: Palmas Extcon Driver
> > >>
> > >>Kishon Vijay Abraham I (1):
> > >>   usb: dwc3: use extcon fwrk to receive connect/disconnect
> notification
> > >
> > >
> > >There were some comments to this series, what will happen with it ? Any
> > >new versions coming ?
> >
> > I've already sent new versions. Palmas Extcon Driver is already
> > queued in extcon-next.
> > Chanwoo can take this patch in his tree after your ACK. [PATCH v2]
> > usb: dwc3: use extcon fwrk to receive connect/disconnect
> > notification.
>
> alright, thanks for the note, here it is:
>
>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>
>
OK, I applied this patchset on extcon-next branch
and I will send pull-request to GregKH.

You can check on following git repository:
http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next

Thanks,
Chanwoo Choi

--089e013c6ee4d5b14a04dde61a68
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, May 30, 2013 at 2:38 AM, Felipe Balbi <span dir=3D"ltr">&lt;<a href=3D"=
mailto:balbi-l0cyMroinI0@public.gmane.org" target=3D"_blank">balbi-l0cyMroinI0@public.gmane.org</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
Hi,<br>
<div><div class=3D"h5"><br>
On Wed, May 29, 2013 at 11:36:01AM +0530, Kishon Vijay Abraham I wrote:<br>
&gt; Hi Felipe,<br>
&gt;<br>
&gt; On Tuesday 28 May 2013 11:05 PM, Felipe Balbi wrote:<br>
&gt; &gt;On Fri, May 24, 2013 at 08:01:33PM +0530, Kishon Vijay Abraham I w=
rote:<br>
&gt; &gt;&gt;This patch series adds driver for palmas usb which is used to =
detect<br>
&gt; &gt;&gt;attach/detach events of usb device and usb host.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;[PATCH v5 2/3] extcon: Palmas Extcon Driver which was sent pre=
viously<br>
&gt; &gt;&gt;is added in this patch series itself. The revision history is =
added<br>
&gt; &gt;&gt;in the patch comments section.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;A checkpatch warning &quot;WARNING: static const char * array =
should<br>
&gt; &gt;&gt;probably be static const char * const&quot;is ignored since it=
 introduces a<br>
&gt; &gt;&gt;compilation warning.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;Graeme Gregory (2):<br>
&gt; &gt;&gt; =A0 drivers: regulator: palmas: add an API to set/clear the s=
witch bit on<br>
&gt; &gt;&gt; =A0 =A0 SMPS10<br>
&gt; &gt;&gt; =A0 extcon: Palmas Extcon Driver<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;Kishon Vijay Abraham I (1):<br>
&gt; &gt;&gt; =A0 usb: dwc3: use extcon fwrk to receive connect/disconnect =
notification<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;There were some comments to this series, what will happen with it =
? Any<br>
&gt; &gt;new versions coming ?<br>
&gt;<br>
&gt; I&#39;ve already sent new versions. Palmas Extcon Driver is already<br=
>
&gt; queued in extcon-next.<br>
&gt; Chanwoo can take this patch in his tree after your ACK. [PATCH v2]<br>
&gt; usb: dwc3: use extcon fwrk to receive connect/disconnect<br>
&gt; notification.<br>
<br>
</div></div>alright, thanks for the note, here it is:<br>
<br>
<br>
Acked-by: Felipe Balbi &lt;<a href=3D"mailto:balbi-l0cyMroinI0@public.gmane.org">balbi-l0cyMroinI0@public.gmane.org</a>=
&gt;<br>
<span class=3D""><font color=3D"#888888"><br>
</font></span></blockquote></div><br>OK, I applied this patchset on extcon-=
next branch<br>and I will send pull-request to GregKH.<br><br>You can check=
 on following git repository:<br><a href=3D"http://git.kernel.org/cgit/linu=
x/kernel/git/chanwoo/extcon.git/log/?h=3Dextcon-next">http://git.kernel.org=
/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=3Dextcon-next</a><br>
<br></div><div class=3D"gmail_extra">Thanks,<br>Chanwoo Choi<br></div><div =
class=3D"gmail_extra"><br></div></div>

--089e013c6ee4d5b14a04dde61a68--

--===============5524638744528228549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5524638744528228549==--
