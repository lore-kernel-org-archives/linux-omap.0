From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] arm: omap: introduce 32k timer hwmod for omap2/3/4
Date: Thu, 21 Oct 2010 22:08:33 +0300
Message-ID: <20101021190833.GW3958@legolas.emea.dhcp.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
 <1287480136-2046-5-git-send-email-balbi@ti.com>
 <871v7jzawa.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349Ab0JUTIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 15:08:37 -0400
Content-Disposition: inline
In-Reply-To: <871v7jzawa.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Oct 21, 2010 at 12:57:41PM -0500, Kevin Hilman wrote:
>Felipe Balbi <balbi@ti.com> writes:
>
>> Add 32k timer hwmod to the database.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
>Not sure how this is working correctly on OMAP2 and OMAP3.  All the
>hwmods are mising the oh->prcm.omap2.module_offs field.
>
>Without this, _wait_target_ready *should* fail, and the hwmod should not
>actually be enabled.
>
>Since this was tested to work, I guess what's happening, is because
>module_offs == 0 (OCP_MOD), it's reading from the IDLEST register offset
>in OCP_MOD, which is an undefined register.  On 34xx, we get lucky that
>that bit is zero so omap2_cm_wait_module_ready succeeds.  On 24xx, the
>polarity of the idlest bits is inversed, so this would likely fail on
>OMAP2.
>
>Either way, the right fix for this is to ensure that OMAP2/3 hwmods have
>.module_offs populated correctly.

I'll look again but when I was reading omap3 TRM I couldn't find IDLEST
for this module, maybe I missed something.

-- 
balbi
