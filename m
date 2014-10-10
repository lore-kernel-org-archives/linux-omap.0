From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/2] regulator: twl: use platform data in the DT based
 boot also
Date: Fri, 10 Oct 2014 16:43:42 +0300
Message-ID: <5437E28E.8020500@ti.com>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com> <1412948442-19896-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbaJJNnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 09:43:53 -0400
In-Reply-To: <1412948442-19896-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org

On 10/10/2014 04:40 PM, Tero Kristo wrote:
> This allows to pass platform information during a DT boot also, currently
> this is completely ignored. Needed for supporting the platform specific
> regulator set_voltage / get_voltage ops for the SMPS regulators.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>

Ok that "To:" didn't really work too well, added manually. Can repost if 
needed.

-Tero

> ---
>   drivers/regulator/twl-regulator.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 0b4f866..2c4fa06 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -1103,9 +1103,9 @@ static int twlreg_probe(struct platform_device *pdev)
>   	if (match) {
>   		template = match->data;
>   		id = template->desc.id;
> +		drvdata = dev_get_platdata(&pdev->dev);
>   		initdata = of_get_regulator_init_data(&pdev->dev,
>   						      pdev->dev.of_node);
> -		drvdata = NULL;
>   	} else {
>   		id = pdev->id;
>   		initdata = dev_get_platdata(&pdev->dev);
>

