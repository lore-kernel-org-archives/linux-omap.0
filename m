From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Mon, 12 Sep 2011 17:14:29 +0530
Message-ID: <CAC83ZvLkM+=SmcC-p0Yjmni00wug4XLGQ=HP0+-VZPsx7b1uMQ@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87bouxz21m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36544 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147Ab1ILLob convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:44:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2506357bkb.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:44:29 -0700 (PDT)
In-Reply-To: <87bouxz21m.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

[...]
> I tested this series on top of v3.1-rc4 using a 3430/n900 platform.
>
> During suspend the PER powerdomain does not hit the targetted power
> state. =A0Also, in idle PER never hits retention.
>
> As with previous versions of this series, it appears to be related to
> debounce clocks being left enabled. =A0On my n900, I removed debounce=
 from
> all the GPIO keys pads and PER was then able to hit retention during
> suspend and idle.
>
> Please be sure to test on a platform that is using debounce, or modif=
y
> the board file for one of the platforms your testing so that at least
> one of the GPIOs has debounce enabled so you are verifying the deboun=
ce
> clock gating during suspend and idle.
I was able to re-produce the problem by making explicit call to
_set_gpio_debounce() in *_mod_init().
Prior to calling this I initialized: bank->dbck =3D clk_get(bank->dev,
"dbclk"); as in the function below.
Later I realized that there is no alias associated with "dbclk" for GPI=
O[2-6].

static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
                unsigned debounce)
{
=2E..
        if (!bank->dbck) {
                bank->dbck =3D clk_get(bank->dev, "dbclk");
=2E..
        }

After incorporating the following alias I was able to put system to OFF=
=2E

static struct omap_clk omap3xxx_clks[] =3D {
=2E..
        CLK("omap_gpio.6",       "dbclk",   &gpio6_dbck,    CK_3XXX),
        CLK("omap_gpio.5",       "dbclk",   &gpio5_dbck,    CK_3XXX),
        CLK("omap_gpio.4",       "dbclk",   &gpio4_dbck,    CK_3XXX),
        CLK("omap_gpio.3",       "dbclk",   &gpio3_dbck,    CK_3XXX),
        CLK("omap_gpio.2",       "dbclk",   &gpio2_dbck,    CK_3XXX),

--
Tarun
>
> Thanks,
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
