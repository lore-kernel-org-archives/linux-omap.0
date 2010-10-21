From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/5] arm: omap: introduce 32k timer hwmod for omap2/3/4
Date: Thu, 21 Oct 2010 13:20:20 -0700
Message-ID: <87tykfs3gb.fsf@deeprootsystems.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
	<1287480136-2046-5-git-send-email-balbi@ti.com>
	<871v7jzawa.fsf@deeprootsystems.com>
	<20101021190833.GW3958@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63986 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab0JUUU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 16:20:26 -0400
Received: by ywk9 with SMTP id 9so61022ywk.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 13:20:26 -0700 (PDT)
In-Reply-To: <20101021190833.GW3958@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu, 21 Oct 2010 22:08:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> On Thu, Oct 21, 2010 at 12:57:41PM -0500, Kevin Hilman wrote:
>>Felipe Balbi <balbi@ti.com> writes:
>>
>>> Add 32k timer hwmod to the database.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>
>>Not sure how this is working correctly on OMAP2 and OMAP3.  All the
>>hwmods are mising the oh->prcm.omap2.module_offs field.
>>
>>Without this, _wait_target_ready *should* fail, and the hwmod should not
>>actually be enabled.
>>
>>Since this was tested to work, I guess what's happening, is because
>>module_offs == 0 (OCP_MOD), it's reading from the IDLEST register offset
>>in OCP_MOD, which is an undefined register.  On 34xx, we get lucky that
>>that bit is zero so omap2_cm_wait_module_ready succeeds.  On 24xx, the
>>polarity of the idlest bits is inversed, so this would likely fail on
>>OMAP2.
>>
>>Either way, the right fix for this is to ensure that OMAP2/3 hwmods have
>>.module_offs populated correctly.
>
> I'll look again but when I was reading omap3 TRM I couldn't find IDLEST
> for this module, maybe I missed something.

It's there, see bit 2 of CM_IDLEST_WKUP.

Kevin
