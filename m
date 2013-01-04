From: Gary Thomas <samoht.yrag-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Does USB isochronous mode work on EHCI port?
Date: Fri, 4 Jan 2013 08:46:40 -0800 (PST)
Message-ID: <8a112bcf-ccee-4e10-93a1-3705e60c8d56@googlegroups.com>
References: <32bbff70-2fcd-4993-92ea-385ab02f735a@googlegroups.com> <eb7a9da0-7556-4d8f-b7b4-bf29768082df@googlegroups.com> <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com> <50E6D710.4060409@ti.com>
 <50E70444.7090407@googlemail.com>
Reply-To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_35_25191295.1357318000606"
Return-path: <pandaboard+bncBCOJLZ4VRAEBB4MOTSDQKGQEHUWRBII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <50E70444.7090407-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/pandaboard/post?hl=en_US>, <mailto:pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:pandaboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/pandaboard?hl=en_US>
Sender: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:pandaboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+575825281776+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Gary Thomas <samoht.yrag-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rogerq-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_35_25191295.1357318000606
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On Friday, January 4, 2013 9:33:08 AM UTC-7, Frank Sch=C3=A4fer wrote:
>
> Am 04.01.2013 14:20, schrieb Roger Quadros:=20
> > Hi Gary,=20
> >=20
> > On 01/04/2013 02:20 PM, Gary Thomas wrote:=20
> >>=20
> >> On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:=20
> >>=20
> >>     Hi,=20
> >>=20
> >>     On Wednesday, January 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote=
:=20
> >>=20
> >>         I have a video adapter attached to my EHCI port which runs ful=
l=20
> >>         speed (480Mb/s) isochronous mode.  Sadly, I never get any data=
=20
> >>         from the device (it uses the EM28xx driver).=20
> >>         This same device + driver works fine on my laptop and from wha=
t=20
> >>         I can tell looking at the module debug, it's failing when=20
> >>         waiting for the ISOC frame data to arrive.=20
> >>=20
> >>         Should this work?  I recall lots of discussion in the past=20
> about=20
> >>         ISOC transfers not working on certain OMAP devices...=20
> >>=20
> >>=20
> >>     which kernel are you using ? Have you tested mainline kernel ?=20
> >>=20
> >>=20
> >> I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)=20
> >>=20
> >> Using the mainline would be hard as there is a lot in this kernel that=
=20
> >> isn't in the mainline.=20
>
> I have added support for USB bulk transfers to the em28xx driver=20
> recently. It will be include in kernels 3.9+.=20
> Maybe it can be used to work around hardware problems with ISOC transfers=
.=20
>
> So if your device has bulk endpoints for video (see lsusb -v), it's=20
> probably worth testing the latest code from the media tree=20
> (http://git.linuxtv.org/media_tree.git).=20
> You will have to load the module with parameter usb_xfer_mode=3D1,=20
> otherwise the driver selects ISOC transfers for TV devices by default.=20
>

Thanks, I'll give this a try.
=20

>
> Regards,=20
> Frank=20
>

------=_Part_35_25191295.1357318000606
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 4, 2013 9:33:08 AM UTC-7, Frank Sch=C3=A4fer wro=
te:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;=
border-left: 1px #ccc solid;padding-left: 1ex;">Am 04.01.2013 14:20, schrie=
b Roger Quadros:
<br>&gt; Hi Gary,
<br>&gt;
<br>&gt; On 01/04/2013 02:20 PM, Gary Thomas wrote:
<br>&gt;&gt;
<br>&gt;&gt; On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wr=
ote:
<br>&gt;&gt;
<br>&gt;&gt; &nbsp; &nbsp; Hi,
<br>&gt;&gt;
<br>&gt;&gt; &nbsp; &nbsp; On Wednesday, January 2, 2013 10:44:50 PM UTC+2,=
 Gary Thomas wrote:
<br>&gt;&gt;
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; I have a video adapter attached to=
 my EHCI port which runs full
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; speed (480Mb/s) isochronous mode. =
&nbsp;Sadly, I never get any data
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; from the device (it uses the EM28x=
x driver).
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; This same device + driver works fi=
ne on my laptop and from what
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; I can tell looking at the module d=
ebug, it's failing when
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; waiting for the ISOC frame data to=
 arrive.
<br>&gt;&gt;
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; Should this work? &nbsp;I recall l=
ots of discussion in the past about
<br>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; ISOC transfers not working on cert=
ain OMAP devices...
<br>&gt;&gt;
<br>&gt;&gt;
<br>&gt;&gt; &nbsp; &nbsp; which kernel are you using ? Have you tested mai=
nline kernel ?
<br>&gt;&gt;
<br>&gt;&gt;
<br>&gt;&gt; I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)
<br>&gt;&gt;
<br>&gt;&gt; Using the mainline would be hard as there is a lot in this ker=
nel that
<br>&gt;&gt; isn't in the mainline.
<br>
<br>I have added support for USB bulk transfers to the em28xx driver
<br>recently. It will be include in kernels 3.9+.
<br>Maybe it can be used to work around hardware problems with ISOC transfe=
rs.
<br>
<br>So if your device has bulk endpoints for video (see lsusb -v), it's
<br>probably worth testing the latest code from the media tree
<br>(<a href=3D"http://git.linuxtv.org/media_tree.git" target=3D"_blank">ht=
tp://git.linuxtv.org/media_<wbr>tree.git</a>).
<br>You will have to load the module with parameter usb_xfer_mode=3D1,
<br>otherwise the driver selects ISOC transfers for TV devices by default.
<br></blockquote><div><br></div><div>Thanks, I'll give this a try.</div><di=
v>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-l=
eft: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">
<br>Regards,
<br>Frank
<br></blockquote>
------=_Part_35_25191295.1357318000606--
