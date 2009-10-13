From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Tue, 13 Oct 2009 11:45:47 -0700
Message-ID: <87r5t7ku90.fsf@deeprootsystems.com>
References: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:40179 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934033AbZJMSq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 14:46:28 -0400
Received: by pxi10 with SMTP id 10so140746pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 11:45:51 -0700 (PDT)
In-Reply-To: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 12 Oct 2009 17\:51\:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia.com>
>
> This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace via
> sysfs. This can be used to track down silicon specific issues. The info is
> exported via sysfs because it should be possible to include this in corematic
> dumps.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Please export these via debugfs. 

Kevin

> ---
>  arch/arm/mach-omap2/id.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2c5e0a3..97670e2 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -70,6 +70,10 @@ EXPORT_SYMBOL(omap_type);
>  /*----------------------------------------------------------------------------*/
>  
>  #define OMAP_TAP_IDCODE		0x0204
> +#define OMAP_TAP_PROD_ID_0      0x0208
> +#define OMAP_TAP_PROD_ID_1      0x020c
> +#define OMAP_TAP_PROD_ID_2      0x0210
> +#define OMAP_TAP_PROD_ID_3      0x0214
>  #define OMAP_TAP_DIE_ID_0	0x0218
>  #define OMAP_TAP_DIE_ID_1	0x021C
>  #define OMAP_TAP_DIE_ID_2	0x0220
> @@ -77,6 +81,10 @@ EXPORT_SYMBOL(omap_type);
>  
>  #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
>  
> +static ssize_t idcode_show(struct kobject *, struct kobj_attribute *, char *);
> +static struct kobj_attribute idcode_attr = __ATTR(idcode, 0444, idcode_show,
> +							NULL);
> +
>  struct omap_id {
>  	u16	hawkeye;	/* Silicon type (Hawkeye id) */
>  	u8	dev;		/* Device type from production_id reg */
> @@ -96,6 +104,23 @@ static struct omap_id omap_ids[] __initdata = {
>  static void __iomem *tap_base;
>  static u16 tap_prod_id;
>  
> +static ssize_t idcode_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				char *buf)
> +{
> +	return sprintf(buf, "IDCODE: %08x\nProduction ID: %08x %08x %08x %08x\n"
> +				"Die ID: %08x %08x %08x %08x\n",
> +			read_tap_reg(OMAP_TAP_IDCODE),
> +			read_tap_reg(OMAP_TAP_PROD_ID_0),
> +			read_tap_reg(OMAP_TAP_PROD_ID_1),
> +			read_tap_reg(OMAP_TAP_PROD_ID_2),
> +			read_tap_reg(OMAP_TAP_PROD_ID_3),
> +			read_tap_reg(OMAP_TAP_DIE_ID_0),
> +			read_tap_reg(OMAP_TAP_DIE_ID_1),
> +			read_tap_reg(OMAP_TAP_DIE_ID_2),
> +			read_tap_reg(OMAP_TAP_DIE_ID_3));
> +
> +}
> +
>  void __init omap24xx_check_revision(void)
>  {
>  	int i, j;
> @@ -259,3 +284,14 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>  	else
>  		tap_prod_id = 0x0208;
>  }
> +
> +void __init export_omapid(void)
> +{
> +	int error;
> +
> +	error = sysfs_create_file(power_kobj, &idcode_attr.attr);
> +	if (error)
> +		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> +}
> +
> +late_initcall(export_omapid);
> -- 
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
