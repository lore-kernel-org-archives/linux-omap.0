From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Tue, 12 Jun 2012 10:49:00 +0800
Message-ID: <CA+Y31weKZTY5RM+i_6c=DaY6WCdai7HcSzJkytWJO9cDeyKVcQ@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <4FD602AD.1060304@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2635770331379588392=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FD602AD.1060304@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: khilman@ti.com, zumeng.chen@gmail.com, tony@atomide.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, ajay.gupta@ti.com, khasim@ti.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2635770331379588392==
Content-Type: multipart/alternative; boundary=14dae934071b39247804c23d8243

--14dae934071b39247804c23d8243
Content-Type: text/plain; charset=ISO-8859-1

2012/6/11 Igor Grinberg <grinberg@compulab.co.il>

> Hi,
>
> This is input subsystem, add Dmitry and linux-input.
>
> On 06/11/12 17:00, Zumeng Chen wrote:
> > If we don't set proper debouce time for ads7846, then there are
> > flooded interrupt counters of ads7846 responding to one time
> > touch on screen, so the driver couldn't work well.
> >
> > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > to omap_ads7846_init, so it's more proper to set it in driver level
> > after having gpio_request done.
>
> What about other non-OMAP platforms?
>
Good point, I thought it should be the same situation, and I have no other
boards
to validate it :) Then I'll fall back on my original patch to bracket them
with OMAP3EVM

>
> NULL pointer for board_pdata, only means that the default pdata is used.
> Please, see the common-board-devices.c file more closely.
>
Yes,  I just went through again, two points:

1 )  get_pendown_state is not set for OMAP3 boards, and the state
      will be get by gpio_get_value(gpio-omap.c)
      The second path will be available in the ads7846_setup_pendown
      if (pdata->get_pendown_state) {
                ts->get_pendown_state = pdata->get_pendown_state;
      } else if (gpio_is_valid(pdata->gpio_pendown)) {

2 )  All omap3 boards set gpio_pendown for pdata.
      So it had better we set_debounce in driver level after
gpio_request_one
      having done
      I'll remove DEBOUNCE_TIME in V2 and change into like following:

+#ifdef CONFIG_MACH_OMAP3EVM
+               /* 310 means 10 microsecond for omap3 */
+               gpio_set_debounce(pdata->gpio_pendown, 310);
+#endif


> >
> > This patch has been validated on 3530evm.
> >
> > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
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
>
> I think hard coding this value is wrong.
>
Yes, me too.

> Can't it be derived from the pdata->debounce_* fields?
>
Yes, I agreed this way, and to be honest, my first choice
is to find if there is a member for debounce, but no. And
there is no more sense to derive it from debounce_max,
although which is the right value for us.

So I have to use the hardcode here.

Regards,
Zumeng


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
>
> --
> Regards,
> Igor.
>

--14dae934071b39247804c23d8243
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/11 Igor Grinberg <span dir=3D"ltr=
">&lt;<a href=3D"mailto:grinberg@compulab.co.il" target=3D"_blank">grinberg=
@compulab.co.il</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Hi,<br>
<br>
This is input subsystem, add Dmitry and linux-input.<br>
<div class=3D"im"><br>
On 06/11/12 17:00, Zumeng Chen wrote:<br>
&gt; If we don&#39;t set proper debouce time for ads7846, then there are<br=
>
&gt; flooded interrupt counters of ads7846 responding to one time<br>
&gt; touch on screen, so the driver couldn&#39;t work well.<br>
&gt;<br>
&gt; And since most OMAP3 series boards pass NULL pointer of board_pdata<br=
>
&gt; to omap_ads7846_init, so it&#39;s more proper to set it in driver leve=
l<br>
&gt; after having gpio_request done.<br>
<br>
</div>What about other non-OMAP platforms?<br></blockquote><div>Good point,=
 I thought it should be the same situation, and I have no other boards<br>t=
o validate it :) Then I&#39;ll fall back on my original patch to bracket th=
em with OMAP3EVM<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
NULL pointer for board_pdata, only means that the default pdata is used.<br=
>
Please, see the common-board-devices.c file more closely.<br></blockquote><=
div>Yes,=A0 I just went through again, two points:<br><br>1 )=A0 get_pendow=
n_state is not set for OMAP3 boards, and the state<br>=A0=A0=A0=A0=A0 will =
be get by gpio_get_value(gpio-omap.c)<br>
=A0=A0=A0=A0=A0 The second path will be available in the ads7846_setup_pend=
own<br>=A0=A0=A0=A0=A0 if (pdata-&gt;get_pendown_state) {<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts-&gt;get_pendown_state =3D pdata-&gt;ge=
t_pendown_state;<br>=A0=A0=A0=A0=A0 } else if (gpio_is_valid(pdata-&gt;gpio=
_pendown)) {<br>
<br>2 )=A0 All omap3 boards set gpio_pendown for pdata.<br>=A0=A0=A0=A0=A0 =
So it had better we set_debounce in driver level after gpio_request_one<br>=
=A0=A0=A0=A0=A0 having done<br>=A0=A0=A0=A0=A0 I&#39;ll remove DEBOUNCE_TIM=
E in V2 and change into like following:<br>
<br>+#ifdef CONFIG_MACH_OMAP3EVM<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 /* 310 means 10 microsecond for omap3 */<br>+=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 gpio_set_debounce(pdata-&gt;gpio_pendown, 310);<br>+#=
endif<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0p=
t 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

<div class=3D"im"><br>
&gt;<br>
&gt; This patch has been validated on 3530evm.<br>
&gt;<br>
&gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@gmail.com=
">zumeng.chen@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Syed Mohammed Khasim &lt;<a href=3D"mailto:khasim@ti.co=
m">khasim@ti.com</a>&gt;<br>
&gt; Signed-off-by: Tony Lindgren &lt;<a href=3D"mailto:tony@atomide.com">t=
ony@atomide.com</a>&gt;<br>
&gt; ---<br>
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
<br>
</div>I think hard coding this value is wrong.<br></blockquote><div>Yes, me=
 too. <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0=
pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Can&#39;t it be derived from the pdata-&gt;debounce_* fields?<br></blockquo=
te><div>Yes, I agreed this way, and to be honest, my first choice<br>is to =
find if there is a member for debounce, but no. And<br>there is no more sen=
se to derive it from debounce_max,<br>
although which is the right value for us.<br><br>So I have to use the hardc=
ode here.<br><br>Regards,<br>Zumeng<br><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">

<div class=3D"im"><br>
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
<br>
--<br>
</div>Regards,<br>
Igor.<br>
</blockquote></div><br>

--14dae934071b39247804c23d8243--


--===============2635770331379588392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2635770331379588392==--
