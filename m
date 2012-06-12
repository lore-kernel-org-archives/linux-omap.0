From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Wed, 13 Jun 2012 00:37:17 +0800
Message-ID: <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <20120612064757.GE12766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3890356730236273438=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120612064757.GE12766@atomide.com>
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

--===============3890356730236273438==
Content-Type: multipart/alternative; boundary=14dae93403e16d352404c24914ee

--14dae93403e16d352404c24914ee
Content-Type: text/plain; charset=ISO-8859-1

2012/6/12 Tony Lindgren <tony@atomide.com>

> * Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> > If we don't set proper debouce time for ads7846, then there are
> > flooded interrupt counters of ads7846 responding to one time
> > touch on screen, so the driver couldn't work well.
> >
> > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > to omap_ads7846_init, so it's more proper to set it in driver level
> > after having gpio_request done.
> >
> > This patch has been validated on 3530evm.
> >
> > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Please remove my Signed-off-by, where does that come from?
>
HI Tony,

This comes from git://arago-project.org/git/projects/linux-omap3.git
The commit ID is 53c5ec31, we set gpio_debounce in arch/board
level.

+static void ads7846_dev_init(void)
+{
+       if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
+               printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
+
+       gpio_direction_input(OMAP3_EVM_TS_GPIO);
+
+       omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
+       omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
+}

in 3.4 kernel, I think we can set pendown in driver level. this is the
story.

Regards,
Zumeng

>
> Tony
>
>
> >  drivers/input/touchscreen/ads7846.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
> > index f02028e..a82a5fb 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -61,6 +61,7 @@
> >
> >  /* this driver doesn't aim at the peak continuous sample rate */
> >  #define      SAMPLE_BITS     (8 /*cmd*/ + 16 /*sample*/ + 2 /* before,
> after */)
> > +#define      DEBOUNCE_TIME   310 /* About 10 ms */
> >
> >  struct ts_event {
> >       /*
> > @@ -980,6 +981,7 @@ static int __devinit ads7846_setup_pendown(struct
> spi_device *spi, struct ads784
> >               }
> >
> >               ts->gpio_pendown = pdata->gpio_pendown;
> > +             gpio_set_debounce(pdata->gpio_pendown, DEBOUNCE_TIME);
> >
> >       } else {
> >               dev_err(&spi->dev, "no get_pendown_state nor
> gpio_pendown?\n");
> > --
> > 1.7.5.4
> >
>

--14dae93403e16d352404c24914ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/12 Tony Lindgren <span dir=3D"ltr=
">&lt;<a href=3D"mailto:tony@atomide.com" target=3D"_blank">tony@atomide.co=
m</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0=
pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
* Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com">zumeng.chen@gmai=
l.com</a>&gt; [120611 07:05]:<br>
<div class=3D"im">&gt; If we don&#39;t set proper debouce time for ads7846,=
 then there are<br>
&gt; flooded interrupt counters of ads7846 responding to one time<br>
&gt; touch on screen, so the driver couldn&#39;t work well.<br>
&gt;<br>
&gt; And since most OMAP3 series boards pass NULL pointer of board_pdata<br=
>
&gt; to omap_ads7846_init, so it&#39;s more proper to set it in driver leve=
l<br>
&gt; after having gpio_request done.<br>
&gt;<br>
&gt; This patch has been validated on 3530evm.<br>
&gt;<br>
&gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com=
">zumeng.chen@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Syed Mohammed Khasim &lt;<a href=3D"mailto:khasim@ti.co=
m">khasim@ti.com</a>&gt;<br>
&gt; Signed-off-by: Tony Lindgren &lt;<a href=3D"mailto:tony@atomide.com">t=
ony@atomide.com</a>&gt;<br>
<br>
</div>Please remove my Signed-off-by, where does that come from?<br></block=
quote><div>HI Tony,<br><br>This comes from git://<a href=3D"http://arago-pr=
oject.org/git/projects/linux-omap3.git">arago-project.org/git/projects/linu=
x-omap3.git</a><br>
The commit ID is 53c5ec31, we set gpio_debounce in arch/board <br>level.<br=
><br>+static void ads7846_dev_init(void)<br>+{<br>+=A0=A0=A0=A0=A0=A0 if (g=
pio_request(OMAP3_EVM_TS_GPIO, &quot;ADS7846 pendown&quot;) &lt; 0)<br>+=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR &quot;can&#39;t get=
 ads7846 pen down GPIO\n&quot;);<br>
+<br>+=A0=A0=A0=A0=A0=A0 gpio_direction_input(OMAP3_EVM_TS_GPIO);<br>+<br>+=
=A0=A0=A0=A0=A0=A0 omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);<br>+=A0=A0=
=A0=A0=A0=A0 omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);<br>+}<br>=
<br>in 3.4 kernel, I think we can set pendown in driver level. this is the =
story.<br>
<br>Regards,<br>Zumeng<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Tony<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; =A0drivers/input/touchscreen/ads7846.c | =A0 =A02 ++<br>
&gt; =A01 files changed, 2 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touch=
screen/ads7846.c<br>
&gt; index f02028e..a82a5fb 100644<br>
&gt; --- a/drivers/input/touchscreen/ads7846.c<br>
&gt; +++ b/drivers/input/touchscreen/ads7846.c<br>
&gt; @@ -61,6 +61,7 @@<br>
&gt;<br>
&gt; =A0/* this driver doesn&#39;t aim at the peak continuous sample rate *=
/<br>
&gt; =A0#define =A0 =A0 =A0SAMPLE_BITS =A0 =A0 (8 /*cmd*/ + 16 /*sample*/ +=
 2 /* before, after */)<br>
&gt; +#define =A0 =A0 =A0DEBOUNCE_TIME =A0 310 /* About 10 ms */<br>
&gt;<br>
&gt; =A0struct ts_event {<br>
&gt; =A0 =A0 =A0 /*<br>
&gt; @@ -980,6 +981,7 @@ static int __devinit ads7846_setup_pendown(struct =
spi_device *spi, struct ads784<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts-&gt;gpio_pendown =3D pdata-&gt;gpio_pen=
down;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_debounce(pdata-&gt;gpio_pendown, DE=
BOUNCE_TIME);<br>
&gt;<br>
&gt; =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;no get_pen=
down_state nor gpio_pendown?\n&quot;);<br>
&gt; --<br>
&gt; 1.7.5.4<br>
&gt;<br>
</div></div></blockquote></div><br>

--14dae93403e16d352404c24914ee--


--===============3890356730236273438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3890356730236273438==--
