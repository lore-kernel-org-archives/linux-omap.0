From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: mach-omap2: remove NULL board_mux from board
 files
Date: Thu, 2 Dec 2010 13:36:42 +0200
Message-ID: <20101202113642.GR5429@legolas.emea.dhcp.ti.com>
References: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
 <20101202103750.GM5429@legolas.emea.dhcp.ti.com>
 <alpine.DEB.1.10.1012021303240.27201@esdhcp041196.research.nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45335 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab0LBLhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 06:37:17 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so3510504yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 03:37:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012021303240.27201@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: ext Felipe Balbi <balbi@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 01:04:57PM +0200, Aaro Koskinen wrote:
>Hi,
>
>On Thu, 2 Dec 2010, Felipe Balbi wrote:
>>On Thu, Dec 02, 2010 at 11:53:42AM +0200, Aaro Koskinen wrote:
>>>diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>>>index 350c04f..e224ab5 100644
>>>--- a/arch/arm/mach-omap2/mux.h
>>>+++ b/arch/arm/mach-omap2/mux.h
>>>@@ -133,6 +133,8 @@ static inline int omap_mux_init_signal(char 
>>>*muxname, int val)
>>>	return 0;
>>>}
>>>
>>>+static struct omap_board_mux *board_mux __initdata 
>>>__attribute__((unused));
>>
>>how about __unused ??
>
>I don't think we have that:
>
>  CC      arch/arm/mach-omap2/mux.o
>In file included from arch/arm/mach-omap2/mux.c:39:
>arch/arm/mach-omap2/mux.h:136: error: expected ',' or ';' before '__unused'
>make[1]: *** [arch/arm/mach-omap2/mux.o] Error 1
>make: *** [arch/arm/mach-omap2] Error 2

sorry, it's __maybe_unused :-)

#define __maybe_unused			__attribute__((unused))

-- 
balbi
