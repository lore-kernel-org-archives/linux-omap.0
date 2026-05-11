Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C56175A5
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2026 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465905; cv=none; b=Iyjo9Vkw4Fe4Rf6NdLjfSySMGEtkD9oBdusp7LqPfDRXjN0b7HQKlLYmdIBdicqLaq2jUaHbBCrcj2Wt8xf0TU/Gc9tM286YNi/8+ytF3Bwa/52BiwJ4zAfeqAlh7Nu7OoCgQUqrDXcvi5qEbudO76uXmRnFCKoBHan4aSr2m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465905; c=relaxed/simple;
	bh=4I1f1BA5uiLXHrvlp/+PMpnegKS8Mb2RvXUl2wxLArE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw9XTGWbiOOQTIVGA2OeegtAMAlT/3rbqPG7zdCyaXWcCKeMnnwdjbUDZw8EnJHTNa3qTTmDlwVCNCgwJyEAZwGt7e7wYUQCQ494TKzQF6eUDGQ/MoxqnCh899n1lJKXigCSHFJluN3VrfRhvLsYeHdJc+OBpHXNad9k0Bfi3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8tHSAwm; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8tHSAwm"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c19d23b19so6331046c88.0
        for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 19:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778465903; x=1779070703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIDIZltg3crcgCV0pjwrdHEPWCIgUFdpcpIpUKsfzYk=;
        b=n8tHSAwm3b7l3ApLBod17MCzkup5kl/0gr1W0oceJ7v46ZgV2BtpUubVpWDnZonryY
         vQIkhObd/LGyVfQKr/+j23e03aYv+Z3pkHzMobq2pXsd6aDKYsgMsNBy8W1XkbjXHB4g
         82nBZ+BmX5gFjg0V/N/1spL30Z6bmkhOl6FJxMv5ilbAfWwCH4pKJOOOSpb9Xc2fNkEm
         5xXeOKrbUDSiudXwOez945LmfUSksaqMl6DMWUjQeZEku8DK3uNIU37rmTShYyvdyW6q
         tEXd6c7AAbFwfOQ09b2GF93SWxozFvNf8G7hoiXjk2Q352S5wCYV7wR3H1kwEWKacLGl
         YUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778465903; x=1779070703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIDIZltg3crcgCV0pjwrdHEPWCIgUFdpcpIpUKsfzYk=;
        b=KMQp0YBaea06CrMV3+LUwvaGTvQYb1CdeUqv71GuMUMv0efrL9bJhuoAXVQ61jWDh4
         QBTjDGhfn1a3ouaBBwn0qV95Z0lgU18xlwG1vBtrI3EM9RSPmhdpljyrdBXgNOlQ5C2u
         o7wx+Ka6O4o3TYbDScEJVUaSfMSOAK46Z2b/qUY/SAFIJR3Z2MItOcFw5mwxfmQ2pLAf
         a/gWuosfov78EtpMxgfDNwI8/HZ2eeDPAHp6dXkfG2yeWuL7odLajm1+FlSSJ34O5spz
         Ay14LVGjEnnczD3lCjpBSX9dZbxFbBpvdaUn5jKlW7+ryxmm1DVA1krIgm6HBHMfOooB
         hzrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9msmDA23MkjLe9qoTjUPjV+q9aumDHz0qlWc6ZpIPwit8nO5AtdQy70J4VWDjZax9o9SWyjZSBSuv5@vger.kernel.org
X-Gm-Message-State: AOJu0Yytya+pdrAmNhzTDqpNnk/6MTlQr6ovensDsQqOFW/j58xHt5tj
	E10Sm72X3VVARHBVwMGZe7BuX9+D074I6o9l9HfmxKOqHo+AAOQNHB7F
X-Gm-Gg: Acq92OFr3lKqXNuxx+ONhaSdWTxrX1v/6HcYHWLJvftfWnuTT0aPaXBQEBA8kimJSMH
	MLmnChpijFRQaVd3SDtYpUumyTdBzVEadmiiZgFETfsDvAuSavgWPSRWxs4vo4CWIAUZZ5rpRGg
	G69ljSPzHPgKl2a7ZD6MKuqSNTCqyMqiyeqDWZJ9Qm1dKhmilCR+onprWT00TLU/Gj+FGUpOIjM
	zFBggzWPCU/bhgq/qta6IlPdvHRa32UNFku3sPFx9EcQdKf6A4sdhBhaEl1sxph8Nw1nFV+tOdw
	K2uoPwwE2qFckw4YTLeWJoi2PjyIYvCr8mSbxwncOsbGcXr4G3IiB6kiwdXc+mgHwoaYv027lFT
	pkxUwHCSoppsBU447mPmNHTOXwneNU4BV5rXUX5z4g9giuvzH2Ky7zf7qaAJ0u6BHTVX3ge2x78
	K0D8QZn4nMociO2//lw/WyQ/o3K0TVVNMQtGwjncQJmBLhjUoIz6SylL8J+IYolOkSMG2NU75fH
	lSLzKz9KJsIXnKsrgR3ulQoeUr5bk8Q5PkeJTuUag6RVVqYsvj8tZlL1s030nynxKypq75ailx9
	jyMeFUhpONUS+GdErA==
X-Received: by 2002:a05:7022:123:b0:128:d375:f1cc with SMTP id a92af1059eb24-1319cc11ecbmr10668636c88.12.1778465903419;
        Sun, 10 May 2026 19:18:23 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm15313599c88.4.2026.05.10.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 19:18:22 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH] ARM: move the only use of machine_desc.reboot_mode into mach-omap2
Date: Sun, 10 May 2026 19:18:00 -0700
Message-ID: <20260511021806.180107-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct machine_desc defines a reboot_mode field which is only set by
mach-omap2. Simplify the code and make it more generic by moving the
code to set reboot_mode from arch/arm/kernel/setup.c into mach-omap2.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/include/asm/mach/arch.h    | 1 -
 arch/arm/kernel/setup.c             | 3 ---
 arch/arm/mach-omap2/board-generic.c | 6 ------
 arch/arm/mach-omap2/io.c            | 7 +++++++
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2b18a258204d..d4688cd1f080 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -40,7 +40,6 @@ struct machine_desc {
 	unsigned char		reserve_lp0 :1;	/* never has lp0	*/
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
-	enum reboot_mode	reboot_mode;	/* default restart mode	*/
 	unsigned		l2c_aux_val;	/* L2 cache aux value	*/
 	unsigned		l2c_aux_mask;	/* L2 cache aux mask	*/
 	void			(*l2c_write_sec)(unsigned long, unsigned);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0bfd66c7ada0..6430646a46bf 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1123,9 +1123,6 @@ void __init setup_arch(char **cmdline_p)
 	machine_name = mdesc->name;
 	dump_stack_set_arch_desc("%s", mdesc->name);
 
-	if (mdesc->reboot_mode != REBOOT_HARD)
-		reboot_mode = mdesc->reboot_mode;
-
 	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	/* populate cmd_line too for later use, preserving boot_command_line */
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 68e0baad2bbf..fde6ccb3df6e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -246,12 +246,6 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_time	= omap_init_time_of,
 	.dt_compat	= am33xx_boards_compat,
 	.restart	= am33xx_restart,
-	/*
-	 * Historically am33xx supported only REBOOT_WARM even though default
-	 * reboot_mode was REBOOT_COLD. Reflect legacy de-facto behaviour in
-	 * SYSFS.
-	 */
-	.reboot_mode	= REBOOT_WARM,
 MACHINE_END
 #endif
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 14ec3f78000b..26a12d083dce 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -15,6 +15,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -546,6 +547,12 @@ void __init ti816x_init_early(void)
 #ifdef CONFIG_SOC_AM33XX
 void __init am33xx_init_early(void)
 {
+	/*
+	 * Historically am33xx supported only REBOOT_WARM even though default
+	 * reboot_mode was REBOOT_COLD. Reflect legacy de-facto behaviour in
+	 * SYSFS.
+	 */
+	reboot_mode = REBOOT_WARM;
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
 	omap2_control_base_init();
-- 
2.43.0

