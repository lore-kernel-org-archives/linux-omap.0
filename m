From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] CLK: TI: consider the fact that of_clk_get() might
 return an error
Date: Wed, 17 Sep 2014 11:35:59 -0500
Message-ID: <20140917163559.GA25790@kahuna>
References: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
 <54198411.1080706@ti.com>
 <20140917155623.GA28043@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbaIQQgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 12:36:08 -0400
Content-Disposition: inline
In-Reply-To: <20140917155623.GA28043@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org

On 17:56-20140917, Sebastian Andrzej Siewior wrote:
> I "forgot" to update the dtb and the kernel crashed:
> |Unable to handle kernel NULL pointer dereference at virtual address =
0000002e
> |PC is at __clk_get_flags+0x4/0xc
> |LR is at ti_dt_clockdomains_setup+0x70/0xe8
>=20
> because I did not have the clock nodes. of_clk_get() returns an error
> pointer which is not checked here.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2:
>     add "%s __func__" to the added pr_err
>=20
> * Nishanth Menon | 2014-09-17 07:52:33 [-0500]:
> >
> >Could you add %s: __func__ as well - it kinda helps understand this
> >is part of clockdomain setup and not some driver cribbing that it di=
d
> >not get some clock.
>=20
> As you wish.
>=20
>  drivers/clk/ti/clockdomain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomai=
n.c
> index f1e0038d76ac..446481166ce9 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -36,6 +36,12 @@ static void __init of_ti_clockdomain_setup(struct =
device_node *node)
> =20
>  	for (i =3D 0; i < num_clks; i++) {
>  		clk =3D of_clk_get(node, i);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
> +					__func__, node->full_name, i,
> +					PTR_ERR(clk));
> +			continue;
> +		}

Once the following is fixed (checkpatch --strict) feel free to add:
Acked-by: Nishanth Menon <nm@ti.com>

#65: FILE: drivers/clk/ti/clockdomain.c:35:
_node *node)

CHECK: Alignment should match open parenthesis
#71: FILE: drivers/clk/ti/clockdomain.c:40:
+			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
+					__func__, node->full_name, i,

total: 1 errors, 0 warnings, 1 checks, 16 lines checked


If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
