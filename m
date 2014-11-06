From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: AM43x: Fix DCDC3 regulator voltage
Date: Thu, 6 Nov 2014 13:29:28 -0600
Message-ID: <CAOCHtYiT9VgXD73gLRszSquJsN0Ew1KSNk_tXpA5OcDkT7KnqQ@mail.gmail.com>
References: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
	<20141106182526.GC31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37486 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFT3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 14:29:30 -0500
In-Reply-To: <20141106182526.GC31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

On Thu, Nov 6, 2014 at 12:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Keerthy <j-keerthy@ti.com> [141106 02:55]:
>> Fix DCDC3 volatge to 1.5V which is the right value to be supplied by
>> DCDC3 for all the boards.
>
> Hmm so what about the comments for similar beaglebone changes
> in thread "[PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
> for 1.35v ddr3"?

Based on Keerthy's patchset, i think we should just ignore my "1.35v"
ddr3 patch for the beaglebone black. As by default it will be at
1.50v. (so we can either define it for clarity at 1.50v or just ignore
it.)

Keerthy,

Are you guys seeing these same ddr lockups if u-boot correctly set's
the 1.35v level first? Or should we just really leave it at the
default power on voltage level? (till either u-boot or kernel grows
the capabilities to correctly tell the ddr3 we are changing it's
voltage.)

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
