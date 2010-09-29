From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Tue, 28 Sep 2010 17:06:27 -0700
Message-ID: <20100929000627.GV3117@atomide.com>
References: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org>
 <1282876196.13328.45.camel@I097020.innocomm.com>
 <4C778455.8050108@ti.com>
 <1283131873.13307.5.camel@I097020.innocomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61989 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0I2AGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 20:06:32 -0400
Content-Disposition: inline
In-Reply-To: <1283131873.13307.5.camel@I097020.innocomm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rockefeller <rockefeller.lin@innocomm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Sorry for the delay on responding to this..

* rockefeller <rockefeller.lin@innocomm.com> [100829 18:23]:
> On Fri, 2010-08-27 at 11:24 +0200, Cousson, Benoit wrote:
>
> I would like to introduce a new function omap_mux_name_strcmp() that
> adapted from strcmp() as below and verified with android-2.6.32 and
> it works fine.

Looks like we can also do it with strncmp and keep it const, then
we don't have to ad a custom strcmp function.

Care to test the following patch and see if it solves your problem?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 28 Sep 2010 16:58:04 -0700
Subject: [PATCH] omap: Fix omap_mux_init_signal not to trash muxname

Otherwise the muxname passed to the function will get truncated.

Based on an earlier patch by rockefeller.lin@innocomm.com.

Reported-by: rockefeller.lin@innocomm.com
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6c2f8f0..e33740c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -127,17 +127,16 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return 0;
 }
 
-int __init omap_mux_init_signal(char *muxname, int val)
+int __init omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_entry *e;
-	char *m0_name = NULL, *mode_name = NULL;
-	int found = 0;
+	const char *mode_name;
+	int found = 0, mode0_len = 0;
 
 	mode_name = strchr(muxname, '.');
 	if (mode_name) {
-		*mode_name = '\0';
+		mode0_len = strlen(muxname) - strlen(mode_name);
 		mode_name++;
-		m0_name = muxname;
 	} else {
 		mode_name = muxname;
 	}
@@ -147,9 +146,11 @@ int __init omap_mux_init_signal(char *muxname, int val)
 		char *m0_entry = m->muxnames[0];
 		int i;
 
-		if (m0_name && strcmp(m0_name, m0_entry))
+		/* First check for full name in mode0.muxmode format */
+		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
 			continue;
 
+		/* Then check for muxmode only */
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
 			char *mode_cur = m->muxnames[i];
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a8e040c..350c04f 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -120,7 +120,7 @@ int omap_mux_init_gpio(int gpio, int val);
  * @muxname:		Mux name in mode0_name.signal_name format
  * @val:		Options for the mux register value
  */
-int omap_mux_init_signal(char *muxname, int val);
+int omap_mux_init_signal(const char *muxname, int val);
 
 #else
 
