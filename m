From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states
	list
Date: Thu, 6 Nov 2008 09:01:58 -0800
Message-ID: <20081106170158.GT21736@atomide.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com> <20081106033327.GQ21736@atomide.com> <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56965 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYKFRCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 12:02:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

* Paul Walmsley <paul@pwsan.com> [081106 03:09]:
> On Wed, 5 Nov 2008, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [081105 11:39]:
> > >=20
> > > The SGX device on OMAP3 does not support retention, so remove RET=
 from the=20
> > > list of possible SGX power states.  Problem debugged by Richard W=
oodruff=20
> > > <r-woodruff2@ti.com>.
> >=20
> > Pushing.
>=20
> Just FYI, that patch prevents the kernel from booting due to a bug in=
=20
> pm34xx.c; patch below.
>=20
> Even with the follwoing patch, the initial power state setup code in=20
> pm34xx.c will bail out early since it still tries to set the SGX next=
=20
> power state to retention, which it does not support.

Pushing.

Tony

>=20
>=20
> - Paul
>=20
>=20
> OMAP3 PM: use list_for_each_entry_safe() when deleting list entries
>=20
> From: Paul Walmsley <paul@pwsan.com>
>=20
> The error path in clkdms_setup() needs to use list_for_each_entry_saf=
e()
> when deleting entries from the list, or the kernel will crash.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jouni H=F6gander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index a11a657..da098d2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -540,7 +540,7 @@ static int __init clkdms_setup(struct clockdomain=
 *clkdm)
> =20
>  int __init omap3_pm_init(void)
>  {
> -	struct power_state *pwrst;
> +	struct power_state *pwrst, *tmp;
>  	int ret;
> =20
>  	printk(KERN_ERR "Power Management for TI OMAP3.\n");
> @@ -583,7 +583,7 @@ err1:
>  	return ret;
>  err2:
>  	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
> -	list_for_each_entry(pwrst, &pwrst_list, node) {
> +	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
>  		list_del(&pwrst->node);
>  		kfree(pwrst);
>  	}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
