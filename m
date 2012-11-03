From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 14/15] ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
Date: Sat, 03 Nov 2012 13:20:25 +0100
Message-ID: <50950C09.6000108@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38214 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab2KCMU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:20:26 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1979990wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 05:20:25 -0700 (PDT)
In-Reply-To: <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> AM33XX PM code depends on Mailbox module for IPC
> between MPU and WKUP_M3.

OK, but what if I try to build for AM33xx without starting from 
omap2plus_defconfig?

IOW, instead of changing the default defconfig, AM33xx should select 
this when PM
is enabled.   Something like the (untested) change below.

Kevin


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d669e22..93c1a37 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,6 +109,7 @@ config SOC_AM33XX
  	bool "AM33XX support"
  	default y
  	select ARM_CPU_SUSPEND if PM
+        select OMAP_MBOX_FWK if PM
  	select CPU_V7
  	select MULTI_IRQ_HANDLER



