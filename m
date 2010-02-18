From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] twl6030: regulator: Configure STATE register
 instead of REMAP
Date: Thu, 18 Feb 2010 12:33:16 +0000
Message-ID: <1266496396.3227.3.camel@odin>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
	 <1266420255-4307-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48470 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab0BRMdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 07:33:20 -0500
Received: by ewy19 with SMTP id 19so6777856ewy.21
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 04:33:18 -0800 (PST)
In-Reply-To: <1266420255-4307-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Wed, 2010-02-17 at 20:54 +0530, Rajendra Nayak wrote:
> This is no REMAP register on twl6030, instead there is a STATE register
> to drive a resource to a given state.
> The state register can be used to specify what state the resource should
> enter when its associated with a GRP.
> Register Bit field description is as below. The patch programmes the
> corresponding STATE registers for all LDO's to turn ON when assocaited
> with GRP_P1.
> 
> STATE REG:
> Bit7   |Bit6   |Bit5   |Bit4  |Bit3  |Bit2  |Bit1   |Bit0
> P3_GRP |P2_GRP |P1_GRP |RES   |RES   |RES   |State1 |State0
> 
> State can be specified as below
> 00: OFF
> 01: ON
> 10: OFF
> 11: SLEEP
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Applied.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

