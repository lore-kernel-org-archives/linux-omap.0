From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: OMAP3 SYS_OFF_MODE support
Date: Thu, 24 Jul 2008 16:37:41 +0300
Message-ID: <20080724133741.GB4601@codecarver.research.nokia.com>
References: <20080723134235.GB4543@codecarver.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022C1F60C5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27387 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYGXNh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:37:56 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022C1F60C5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Rangasamy, Devaraj" <dev@ti.com>
Cc: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jul 24, 2008 at 01:00:55PM +0530, ext Rangasamy, Devaraj wrote:
> 
> 
> sr_configure_vc() configures following things, which is needed to scale VDD1/VDD2 voltages while going RET/OFF during cpuidle.
> 
> - Voltage controller config : i2c bus details,voltage range and cmd range.
> - Initializing PRM_VC_CMD_VAL_0, PRM_VC_CMD_VAL_1 with ON/RET/OFF voltage levels
> - SYSOFF mode configuration of PRM_CLKSETUP, PRM_VOLTOFFSET, PRM_VOLTSETUP2
> 
> Its good to have it in prcm_init(),as we might lose this if smartreflex module is removed during compilation.
> 

I agree. We only have to make sure the voltage controller is configured
before smartreflex is enabled.

Cheers,

Peter.

-- 
goa is a state of mind
