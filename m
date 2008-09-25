From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fixed OMAP3 version check
Date: Thu, 25 Sep 2008 13:17:51 +0300
Message-ID: <20080925101750.GG5222@atomide.com>
References: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com> <1221572797-15949-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59941 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIYKRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:17:55 -0400
Content-Disposition: inline
In-Reply-To: <1221572797-15949-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Tero Kristo <tero.kristo@nokia.com> [080916 14:59]:
> CPU version was reported incorrectly (e.g. ES3.0 instead of ES2.1.)
> Also added a piece of optimization for CPU type check (omap_type()).
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/id.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index ab7a6e9..4e2b449 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -37,7 +37,10 @@ EXPORT_SYMBOL(omap_chip_is);
>  
>  int omap_type(void)
>  {
> -	u32 val = 0;
> +	static u32 val;
> +
> +	if (val != 0)
> +		return val;

Hmm I guess this would return a random val? :)


>  	if (cpu_is_omap24xx()) {
>  		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> @@ -169,7 +172,7 @@ void __init omap34xx_check_revision(void)
>  	rev = (idcode >> 28) & 0xff;
>  
>  	if (hawkeye == 0xb7ae)
> -		system_rev = 0x34300034 | ((1 + rev) << 12);
> +		system_rev = 0x34300034 | (rev << 12);
>  
>  out:
>  	switch (system_rev) {

Well AFAIK here are the numbers for rev:

ES1.0	   0	/* Cannot read idcode register */
ES2.0	   0
ES2.1	   1
ES3.0	   2

While ES3.0 TRM claims:

ES1.0 	   0
ES2.0	   1
ES2.1	   2
ES3.0	   3

Which I think is incorrect at least for ES2.0 and ES2.1.

Can you please try the attached patch and see if it detects your ES3.0
correctly?

Tony

--vv4Sf/kQfcwinyKX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap3-cpu-detection-fix.patch"

>From 51b488cee3cea1e791728fd6dc69941448a951ce Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 25 Sep 2008 13:07:23 +0300
Subject: [PATCH] ARM: OMAP: Improve 34xx detection

Fix it for ES3.0. Also use ES3.0 now as the default for unknown
future revision, and make the code easier to follow.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ab7a6e9..bf3691f 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -150,45 +150,49 @@ void __init omap34xx_check_revision(void)
 	char *rev_name;
 
 	/*
+	 * We cannot access revision registers on ES1.0.
 	 * If the processor type is Cortex-A8 and the revision is 0x0
-	 * it means its Cortex r0p0 which is 3430 ES1
+	 * it means its Cortex r0p0 which is 3430 ES1.0.
 	 */
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		system_rev = OMAP3430_REV_ES1_0;
+		rev_name = "ES1.0";
 		goto out;
 	}
 
 	/*
 	 * Detection for 34xx ES2.0 and above can be done with just
 	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
-	 * Note that rev cannot be used directly as ES1.0 uses value 0.
+	 * Note that rev does not map directly to our defined processor
+	 * revision numbers as ES1.0 uses value 0.
 	 */
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
-	if (hawkeye == 0xb7ae)
-		system_rev = 0x34300034 | ((1 + rev) << 12);
-
-out:
-	switch (system_rev) {
-	case OMAP3430_REV_ES1_0:
-		rev_name = "ES1.0";
-		break;
-	case OMAP3430_REV_ES2_0:
-		rev_name = "ES2.0";
-		break;
-	case OMAP3430_REV_ES2_1:
-		rev_name = "ES2.1";
-		break;
-	case OMAP3430_REV_ES3_0:
-		rev_name = "ES3.0";
-		break;
-	default:
-		rev_name = "Unknown revision\n";
+	if (hawkeye == 0xb7ae) {
+		switch (rev) {
+		case 0:
+			system_rev = OMAP3430_REV_ES2_0;
+			rev_name = "ES2.0";
+			break;
+		case 1:
+			system_rev = OMAP3430_REV_ES2_1;
+			rev_name = "ES2.1";
+			break;
+		case 2:
+			system_rev = OMAP3430_REV_ES3_0;
+			rev_name = "ES3.0";
+			break;
+		default:
+			/* Use the latest known revision as default */
+			system_rev = OMAP3430_REV_ES3_0;
+			rev_name = "Unknown revision\n";
+		}
 	}
 
+out:
 	pr_info("OMAP%04x %s\n", system_rev >> 16, rev_name);
 }
 

--vv4Sf/kQfcwinyKX--
