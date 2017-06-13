From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] regulator: tps65910: check TPS65910_NUM_REGS at build
 time
Date: Tue, 13 Jun 2017 19:31:21 +0530
Message-ID: <8d9e234b-8963-8ee8-8330-cfbe04f4a119@ti.com>
References: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 13 June 2017 07:28 PM, Michał Mirosław wrote:

Missing commit log?

> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/tps65910-regulator.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
> index 696116ebdf50a..81672a58fcc23 100644
> --- a/drivers/regulator/tps65910-regulator.c
> +++ b/drivers/regulator/tps65910-regulator.c
> @@ -1107,6 +1107,7 @@ static int tps65910_probe(struct platform_device *pdev)
>  
>  	switch (tps65910_chip_id(tps65910)) {
>  	case TPS65910:
> +		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65910_regs));
>  		pmic->get_ctrl_reg = &tps65910_get_ctrl_register;
>  		pmic->num_regulators = ARRAY_SIZE(tps65910_regs);
>  		pmic->ext_sleep_control = tps65910_ext_sleep_control;
> @@ -1119,6 +1120,7 @@ static int tps65910_probe(struct platform_device *pdev)
>  					DCDCCTRL_DCDCCKSYNC_MASK);
>  		break;
>  	case TPS65911:
> +		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65911_regs));
>  		pmic->get_ctrl_reg = &tps65911_get_ctrl_register;
>  		pmic->num_regulators = ARRAY_SIZE(tps65911_regs);
>  		pmic->ext_sleep_control = tps65911_ext_sleep_control;
> @@ -1144,8 +1146,7 @@ static int tps65910_probe(struct platform_device *pdev)
>  	if (!pmic->rdev)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < pmic->num_regulators && i < TPS65910_NUM_REGS;
> -			i++, info++) {
> +	for (i = 0; i < pmic->num_regulators; i++, info++) {
>  		/* Register the regulators */
>  		pmic->info[i] = info;
>  
> 
