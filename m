From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 19:42:01 +0200
Message-ID: <504A31E9.70405@ti.com>
References: <504A11E4.6000406@ti.com> <20120907172355.GA9208@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740Ab2IGRmV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Sep 2012 13:42:21 -0400
In-Reply-To: <20120907172355.GA9208@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On 09/07/2012 07:23 PM, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Sep 07, 2012 at 05:25:24PM +0200, Benoit Cousson wrote:
>> Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
>> (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
>> we can now specify reg and interrupts using standard device tree
>> attributes.
>>
>> Update the OMAP4 dtsi file with missing reg and interrupts attributes.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> Hi Tony,
>>
>> This is the first step toward reduction of the hwmod data inside mach-omap2.
>> OMAP2/3/4 data still need to be there for legacy boards, but it will allow
>> OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
>>
>> DMA is still missing, but I hope that the discussion that happened during
>> LPC will fixed that soon.
> 
> Very nice work. Do you already have a way on omap_device creation to use
> DT data instead of hwmod's ?

No, not yet. This will require a change in the way omap_hwmod /
omap_device are created and thus it will need some more work.

And then, the only way to get rid of the data for OMAP4 at least is to
have a pure DT boot without anymore legacy boards... and we are still
not yet there :-(

Regards,
Benoit

