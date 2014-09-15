From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: ti: dra7-atl-clock: fix a memory leak
Date: Mon, 15 Sep 2014 12:05:28 +0300
Message-ID: <5416ABD8.4040906@ti.com>
References: <1410529147-19950-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45320 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaIOJFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 05:05:55 -0400
In-Reply-To: <1410529147-19950-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

On 09/12/2014 04:39 PM, Tero Kristo wrote:
> of_clk_add_provider makes an internal copy of the parent_names proper=
ty
> while its called, thus it is no longer needed after this call and can
> be freed.

Thanks Tero, indeed this was overlooked in the original driver.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/clk/ti/clk-dra7-atl.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-=
atl.c
> index 4a65b41..3f9308a 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -199,6 +199,7 @@ static void __init of_dra7_atl_clock_setup(struct=
 device_node *node)
> =20
>  	if (!IS_ERR(clk)) {
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		kfree(parent_names);
>  		return;
>  	}
>  cleanup:
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
