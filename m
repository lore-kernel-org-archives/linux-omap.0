From: Deva R <r.devaraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [android-kernel] Android bootup process from
	linux-omap-pm branch
Date: Tue, 9 Mar 2010 15:58:59 +0530
Message-ID: <e9bb0a641003090228u284891b9o105933563f9c9e93@mail.gmail.com>
References: <2cd4ff051003090200i4e29c84dr7634f11fd9b032eb@mail.gmail.com>
Reply-To: r.devaraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=00504501607253c1b704815ba6cd
Return-path: <39CKWSwkJD_gw.ij0fwfolrfnq.htrfsiwtni-utwynsllttlqjlwtzux.htr-WNnxsJb2WYALHLMFiseIBxPsWskHk0ljAL8bYrjMMd8@public.gmane.org>
In-Reply-To: <2cd4ff051003090200i4e29c84dr7634f11fd9b032eb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/android-porting/post?hl=en_US>,
	<mailto:android-porting-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:android-porting+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/android-porting?hl=en_US>
Sender: android-porting-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/android-porting/subscribe?hl=en_US>,
	<mailto:android-porting+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/android-porting/subscribe?hl=en_US>,
	<mailto:android-porting+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: android-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: android-porting <android-porting-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Mai Daftedar <mai.daftedar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rowboat-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--00504501607253c1b704815ba6cd
Content-Type: text/plain; charset=ISO-8859-1

Hi Mai,
You can keep android FS in ext3 partition, and invoke its init as usual via
kernel arguments..

for eg, in rowboat env,
uImage -> will be the linux-omap-pm kernel image
init =/init -> in bootargs will load android init from mmc partition 2.

Beagleboard# setenv bootcmd 'mmc init; fatload mmc 0 84000000
*uImage;* bootm 84000000'
Beagleboard# setenv bootargs 'mem=128M androidboot.console=ttyS2
console=tty0 console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw
*init=/**init *rootwait omapfb.video_mode=640x480MR-16@60'
Beagleboard# saveenv
Beagleboard# reset




On Tue, Mar 9, 2010 at 3:30 PM, Mai Daftedar <mai.daftedar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi All,
>  I'm working on android ported on a beagleboard.using the rowboat version.
>  I was faced with some errors related to the smart reflex VDD
> autocompansation and as a resolution I wanted to change the current
> linux kernel to the linux-omap-pm latest branches with smart reflex
> patches.
> My question now is how can I start the android init from the
> linux-omap kernel?..
>
>
> Any help would be appreciate
> Thanks in Advance
> Best Regards
> Mai
>
> --
> unsubscribe: android-kernel+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org<android-kernel%2Bunsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
> website: http://groups.google.com/group/android-kernel

-- 
unsubscribe: android-porting+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
website: http://groups.google.com/group/android-porting

--00504501607253c1b704815ba6cd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mai,<br>You can keep android FS in ext3 partition, and invoke its init a=
s usual via kernel arguments..<br><br>for eg, in rowboat env,<br>uImage -&g=
t; will be the linux-omap-pm kernel image<br>init =3D/init -&gt; in bootarg=
s will load android init from mmc partition 2.<br>
<pre class=3D"prettyprint"><a name=3D"Beagleboard"><font style=3D"font-fami=
ly: tahoma,sans-serif;" size=3D"2"><span class=3D"typ">Beagleboard</span><s=
pan class=3D"com"># setenv bootcmd &#39;mmc init; fatload mmc 0 84000000 <b=
><u>uImage;</u></b> bootm 84000000&#39;</span><span class=3D"pln"><br>
</span><span class=3D"typ">Beagleboard</span><span class=3D"com"># setenv b=
ootargs &#39;mem=3D128M androidboot.console=3DttyS2 console=3Dtty0 console=
=3DttyS2,115200n8 root=3D/dev/mmcblk0p2 rw </span><u><b><span class=3D"pln"=
>init</span><span class=3D"pun">=3D/</span></b></u><span class=3D"pln"><u><=
b>init </b></u>rootwait omapfb</span><span class=3D"pun">.</span><span clas=
s=3D"pln">video_mode</span><span class=3D"pun">=3D</span><span class=3D"lit=
">640x480MR</span><span class=3D"pun">-</span><span class=3D"lit">16</span>=
<span class=3D"pun">@</span><span class=3D"lit">60</span></font><span class=
=3D"str"><font style=3D"font-family: tahoma,sans-serif;" size=3D"2">&#39;<b=
r>
Beagleboard# saveenv<br>Beagleboard# reset <br></font><br></span></a></pre>=
<br><br><br><div class=3D"gmail_quote">On Tue, Mar 9, 2010 at 3:30 PM, Mai =
Daftedar <span dir=3D"ltr">&lt;<a href=3D"mailto:mai.daftedar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ma=
i.daftedar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi All,<br>
 =A0I&#39;m working on android ported on a beagleboard.using the rowboat ve=
rsion.<br>
 =A0I was faced with some errors related to the smart reflex VDD<br>
autocompansation and as a resolution I wanted to change the current<br>
linux kernel to the linux-omap-pm latest branches with smart reflex<br>
patches.<br>
My question now is how can I start the android init from the<br>
linux-omap kernel?..<br>
<br>
<br>
Any help would be appreciate<br>
Thanks in Advance<br>
Best Regards<br>
Mai<br>
<font color=3D"#888888"><br>
--<br>
unsubscribe: <a href=3D"mailto:android-kernel%2Bunsubscribe-/JYPxA39Uh4Ykp1iOSErHA@public.gmane.org=
m">android-kernel+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a><br>
website: <a href=3D"http://groups.google.com/group/android-kernel" target=
=3D"_blank">http://groups.google.com/group/android-kernel</a></font></block=
quote></div><br>

<p></p>

-- <br />
unsubscribe: android-porting+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org<br />
website: <a href=3D"http://groups.google.com/group/android-porting">http://=
groups.google.com/group/android-porting</a><br />

--00504501607253c1b704815ba6cd--
