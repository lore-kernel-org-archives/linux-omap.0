From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: mach-omap2: remove NULL board_mux from board
 files
Date: Thu, 2 Dec 2010 12:37:50 +0200
Message-ID: <20101202103750.GM5429@legolas.emea.dhcp.ti.com>
References: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48405 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab0LBKiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:38:15 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so4324776yxm.21
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 02:38:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 11:53:42AM +0200, Aaro Koskinen wrote:
>diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>index 350c04f..e224ab5 100644
>--- a/arch/arm/mach-omap2/mux.h
>+++ b/arch/arm/mach-omap2/mux.h
>@@ -133,6 +133,8 @@ static inline int omap_mux_init_signal(char *muxname, int val)
> 	return 0;
> }
>
>+static struct omap_board_mux *board_mux __initdata __attribute__((unused));

how about __unused ??

-- 
balbi
