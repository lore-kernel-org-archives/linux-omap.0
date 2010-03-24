From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/9] OMAP: Devkit8000: Add missing package selection
Date: Wed, 24 Mar 2010 14:58:17 +0200
Message-ID: <20100324125817.GJ29419@nokia.com>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
 <1269435138-27192-3-git-send-email-weber@corscience.de>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52204 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0CXM6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:58:54 -0400
Content-Disposition: inline
In-Reply-To: <1269435138-27192-3-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Thomas Weber <weber@corscience.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Wed, Mar 24, 2010 at 01:52:11PM +0100, ext Thomas Weber wrote:
>Devkit8000 uses the CUS package for OMAP3530.
>
>This patch adds missing package selection for CUS and enables
>CONFIG_MUX.
>
>Replace whitespace with tab in Kconfig.
>
>Signed-off-by: Thomas Weber <weber@corscience.de>
>---
> arch/arm/mach-omap2/Kconfig |    6 ++++--
> 1 files changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>index a8a3d1e..2455dcc 100644
>--- a/arch/arm/mach-omap2/Kconfig
>+++ b/arch/arm/mach-omap2/Kconfig
>@@ -59,8 +59,10 @@ config MACH_OMAP3_BEAGLE
> 	select OMAP_PACKAGE_CBB
>
> config MACH_DEVKIT8000
>-        bool "DEVKIT8000 board"
>-        depends on ARCH_OMAP3
>+	bool "DEVKIT8000 board"
>+	depends on ARCH_OMAP3
>+	select OMAP_PACKAGE_CUS
>+	select OMAP_MUX

keep the formating, please.

-- 
balbi
