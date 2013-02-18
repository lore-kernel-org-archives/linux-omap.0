From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
Date: Mon, 18 Feb 2013 13:17:28 +0100
Message-ID: <201302181317.28645.marex@denx.de>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Doug Anderson <dianders@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@avionic-design.de>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Kevin Hilman <khilman@ti.com>, Sonic Zhang <sonic.zhang@analog.com>, Vitaly Wool <vitalywool@gmail.com>, Jochen Friedrich <jochen@scram.de>, linux-arm-kernel@lists.infradead.org, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Havard Skinnemoen <hskinnemoen@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, uclinux-dist-devel@blackfin.ucl
List-Id: linux-omap@vger.kernel.org

Dear Doug Anderson,

> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.
> * I verified that there were no cases where xxx_get_drvdata() was
>   being called in these drivers and checking for / relying on the NULL
>   return value.
> 
> This could be cleaned up kernel-wide but for now just take the baby
> step and remove from the i2c subsystem.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

For

>  drivers/i2c/busses/i2c-mxs.c                | 2 --

[...]

> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 22d8ad3..120f246 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -697,8 +697,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
> 
>  	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
> 
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }

[...]

Add my:
Reviewed-by: Marek Vasut <marex@denx.de>
