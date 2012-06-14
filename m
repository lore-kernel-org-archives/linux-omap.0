From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 11:29:11 +0800
Message-ID: <CA+Y31wd10rbSVyM5tEDkSNtBuoLn-19vo5hLwcTYiZh-mGq-4Q@mail.gmail.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8405506296927615855=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, mike@compulab.co.il
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "Gupta,
 Ajay Kumar" <ajay.gupta@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

--===============8405506296927615855==
Content-Type: multipart/alternative; boundary=14dae934076797ab0804c2664d05

--14dae934076797ab0804c2664d05
Content-Type: text/plain; charset=ISO-8859-1

2012/6/13 Hiremath, Vaibhav <hvaibhav@ti.com>

> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
> > From: Zumeng Chen <zumeng.chen@windriver.com>
> >
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
> > Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > ---
> >  drivers/input/touchscreen/ads7846.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
> > index f02028e..459ff29 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct
> spi_device *spi, struct ads784
> >               }
> >
> >               ts->gpio_pendown = pdata->gpio_pendown;
> > +#ifdef CONFIG_ARCH_OMAP3
> > +             /* 310 means about 10 microsecond for omap3 */
> > +             gpio_set_debounce(pdata->gpio_pendown, 310);
> > +#endif
> >
>
> Zumeng,
>
> With my sign-off you are changing the original code, that too
> without my sign-off and ack.
> I wouldn't mind you to submit patches from my tree, but the expectation is
> if you are changing the original code, it should be under your sign-off.
>
Many thanks for your information, good to learn. I'll remove too. Sorry for
inconvenience.

>
> Coming to the patch, #ifdef in driver is not recommended, and this 10msec
> delay is specific to OMAP GPIO and driver should not be aware of this,
> that's where you will find the original patch handling it in board file.
>
Yes, I just went through again the board related codes, there is a commit
from
Mike, I think that's the basic thoughts for me to do this patch for all
omap3 about
ads7846 :-)

Regards,
Zumeng


>
> Thanks,
> Vaibhav
> >       } else {
> >               dev_err(&spi->dev, "no get_pendown_state nor
> gpio_pendown?\n");
> > --
> > 1.7.5.4
> >
> >
>
>

--14dae934076797ab0804c2664d05
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/13 Hiremath, Vaibhav <span dir=3D=
"ltr">&lt;<a href=3D"mailto:hvaibhav@ti.com" target=3D"_blank">hvaibhav@ti.=
com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:<br>
&gt; From: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@windriver.com">zum=
eng.chen@windriver.com</a>&gt;<br>
&gt;<br>
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
&gt;<br>
&gt; This patch has been validated on 3530evm.<br>
&gt;<br>
&gt; Signed-off-by: Zumeng Chen &lt;<a href=3D"mailto:zumeng.chen@windriver=
.com">zumeng.chen@windriver.com</a>&gt;<br>
&gt; Signed-off-by: Syed Mohammed Khasim &lt;<a href=3D"mailto:khasim@ti.co=
m">khasim@ti.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/input/touchscreen/ads7846.c | =A0 =A04 ++++<br>
&gt; =A01 files changed, 4 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touch=
screen/ads7846.c<br>
&gt; index f02028e..459ff29 100644<br>
&gt; --- a/drivers/input/touchscreen/ads7846.c<br>
&gt; +++ b/drivers/input/touchscreen/ads7846.c<br>
&gt; @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct=
 spi_device *spi, struct ads784<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts-&gt;gpio_pendown =3D pdata-&gt;gpio_pen=
down;<br>
&gt; +#ifdef CONFIG_ARCH_OMAP3<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* 310 means about 10 microsecond for omap3 =
*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_debounce(pdata-&gt;gpio_pendown, 31=
0);<br>
&gt; +#endif<br>
&gt;<br>
<br>
</div>Zumeng,<br>
<br>
With my sign-off you are changing the original code, that too<br>
without my sign-off and ack.<br>
I wouldn&#39;t mind you to submit patches from my tree, but the expectation=
 is<br>
if you are changing the original code, it should be under your sign-off.<br=
></blockquote><div>Many thanks for your information, good to learn. I&#39;l=
l remove too. Sorry for<br>inconvenience.<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">

<br>
Coming to the patch, #ifdef in driver is not recommended, and this 10msec<b=
r>
delay is specific to OMAP GPIO and driver should not be aware of this,<br>
that&#39;s where you will find the original patch handling it in board file=
.<br></blockquote><div>Yes, I just went through again the board related cod=
es, there is a commit from<br>Mike, I think that&#39;s the basic thoughts f=
or me to do this patch for all omap3 about<br>
ads7846 :-)<br><br>Regards,<br>Zumeng <br></div><div>=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Vaibhav<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;no get_pen=
down_state nor gpio_pendown?\n&quot;);<br>
&gt; --<br>
&gt; 1.7.5.4<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br>

--14dae934076797ab0804c2664d05--


--===============8405506296927615855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8405506296927615855==--
