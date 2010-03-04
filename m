From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Thu, 4 Mar 2010 09:44:34 +0200
Message-ID: <20100304074434.GI15954@nokia.com>
References: <1267688416-5998-1-git-send-email-felipe.balbi@nokia.com>
 <1267688416-5998-2-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48310 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab0CDHpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 02:45:17 -0500
Content-Disposition: inline
In-Reply-To: <1267688416-5998-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Mar 04, 2010 at 08:40:16AM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>From: Felipe Balbi <felipe.balbi@nokia.com>
>
>the early_param() call in board-omap3touchbook.c expands to:
>
>static const char __setup_str_early_touchbook_revision[]
>	__section(.init.rodata) _aligned(1) = tbr;
>[...]
>
>and we have a non-const variable being added to the
>same section:
>
>static struct ehci_hcd_omap_platform_data ehci_pdata
>__section(.init.rodata);
>
>because of that, gcc generates a section type conflict
>which can (and actually should) be avoided by marking
>const every variable marked with __initconst.
>
>This patch fixes that for the ehci_hdc_omap_platform_data.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

missed one git add, sorry. Resending this one only.

-- 
balbi
