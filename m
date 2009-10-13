From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FEATURES prints
Date: Tue, 13 Oct 2009 14:46:47 -0700
Message-ID: <87ws2zge60.fsf@deeprootsystems.com>
References: <4ACE39CC.1070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63432 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbZJMVsA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 17:48:00 -0400
Received: by pzk26 with SMTP id 26so9372734pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 14:46:49 -0700 (PDT)
In-Reply-To: <4ACE39CC.1070906@ti.com> (Nishanth Menon's message of "Thu\, 8 Oct 2009 14\:13\:16 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Folks,
>
> With the addition of FEATURES in l-o, the following prints:
>  - l2cache : Y
>  - iva : Y
>  - sgx : Y
>  - neon : Y
>  - isp : Y
>
> comes up on SDP3430 -> now that we will introduce half a dozen
> features here and there, we will soon clutter this up. we should
> introduce a sysfs entry + remove the above noise..
>

Like Nishanth, I don't like the multi-line noise here.  The patch
below results in a single line output like this instead

OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )

Not sure why we need to dump features that are not there, but if that
s considered important, maybe prefixing each feature with a '+' or '-'
would still allow this to be collapsed into a single line.

Even with this, I think adding the display of these features into an
OMAP-specific section of /proc/cpuinfo would be even better.

Comments?

Kevin


commit 24f7422bad970cea2ed71d71e3994eeed70f175f
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Tue Oct 13 14:42:00 2009 -0700

    OMAP3: collapse chip feature prints to single line
    
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 71d5568..b90fcf1 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -249,11 +249,8 @@ void __init omap3_check_revision(void)
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat()) {		\
-		pr_info (" - "#feat" : Y");	\
-	} else {				\
-		pr_info (" - "#feat" : N");	\
-	}
+	if (omap3_has_ ##feat())		\
+		printk (#feat" ");      	\
 
 void __init omap3_cpuinfo(void)
 {
@@ -307,13 +304,14 @@ void __init omap3_cpuinfo(void)
 	/*
 	 * Print verbose information
 	 */
-	pr_info("OMAP%s ES%s\n", cpu_name, cpu_rev);
+	pr_info("OMAP%s ES%s (", cpu_name, cpu_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
 	OMAP3_SHOW_FEATURE(sgx);
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
+	printk(")\n");
 }
 
 /*
