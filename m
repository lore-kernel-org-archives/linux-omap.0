From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 11:29:45 +0800
Message-ID: <CA+Y31weR6dFSn9zWZrS1On+Ngq0zzfLS=OUpdmhUteuXpHpSmw@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <20120612064757.GE12766@atomide.com>
 <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
 <20120613125543.GU12766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8423457725414940268=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120613125543.GU12766@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8423457725414940268==
Content-Type: multipart/alternative; boundary=14dae93408b1aa92c504c2664fda

--14dae93408b1aa92c504c2664fda
Content-Type: text/plain; charset=ISO-8859-1

2012/6/13 Tony Lindgren <tony@atomide.com>

> * Zumeng Chen <zumeng.chen@gmail.com> [120612 09:41]:
> > 2012/6/12 Tony Lindgren <tony@atomide.com>
> >
> > > * Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> > > > If we don't set proper debouce time for ads7846, then there are
> > > > flooded interrupt counters of ads7846 responding to one time
> > > > touch on screen, so the driver couldn't work well.
> > > >
> > > > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > > > to omap_ads7846_init, so it's more proper to set it in driver level
> > > > after having gpio_request done.
> > > >
> > > > This patch has been validated on 3530evm.
> > > >
> > > > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > > > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >
> > > Please remove my Signed-off-by, where does that come from?
> > >
> > HI Tony,
> >
> > This comes from git://arago-project.org/git/projects/linux-omap3.git
> > The commit ID is 53c5ec31, we set gpio_debounce in arch/board
> > level.
>
> Weird, I have no recollection of doing anything with that file..
> Just remove my Signed-off-by please.
>
NP, Tony, done on V2.

Regards,
Zumeng

>
> Tony
>

--14dae93408b1aa92c504c2664fda
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/13 Tony Lindgren <span dir=3D"ltr=
">&lt;<a href=3D"mailto:tony@atomide.com" target=3D"_blank">tony@atomide.co=
m</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
* Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com">zumeng.chen@gmai=
l.com</a>&gt; [120612 09:41]:<br>
<div class=3D"im">&gt; 2012/6/12 Tony Lindgren &lt;<a href=3D"mailto:tony@a=
tomide.com">tony@atomide.com</a>&gt;<br>
&gt;<br>
&gt; &gt; * Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com">zumeng=
.chen@gmail.com</a>&gt; [120611 07:05]:<br>
&gt; &gt; &gt; If we don&#39;t set proper debouce time for ads7846, then th=
ere are<br>
&gt; &gt; &gt; flooded interrupt counters of ads7846 responding to one time=
<br>
&gt; &gt; &gt; touch on screen, so the driver couldn&#39;t work well.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; And since most OMAP3 series boards pass NULL pointer of boar=
d_pdata<br>
&gt; &gt; &gt; to omap_ads7846_init, so it&#39;s more proper to set it in d=
river level<br>
&gt; &gt; &gt; after having gpio_request done.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This patch has been validated on 3530evm.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen=
@gmail.com">zumeng.chen@gmail.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Syed Mohammed Khasim &lt;<a href=3D"mailto:kh=
asim@ti.com">khasim@ti.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Tony Lindgren &lt;<a href=3D"mailto:tony@atom=
ide.com">tony@atomide.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Please remove my Signed-off-by, where does that come from?<br>
&gt; &gt;<br>
&gt; HI Tony,<br>
&gt;<br>
&gt; This comes from git://<a href=3D"http://arago-project.org/git/projects=
/linux-omap3.git" target=3D"_blank">arago-project.org/git/projects/linux-om=
ap3.git</a><br>
&gt; The commit ID is 53c5ec31, we set gpio_debounce in arch/board<br>
&gt; level.<br>
<br>
</div>Weird, I have no recollection of doing anything with that file..<br>
Just remove my Signed-off-by please.<br></blockquote><div>NP, Tony, done on=
 V2.<br><br>Regards,<br>Zumeng <br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">

<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Tony<br>
</font></span></blockquote></div><br>

--14dae93408b1aa92c504c2664fda--


--===============8423457725414940268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8423457725414940268==--
