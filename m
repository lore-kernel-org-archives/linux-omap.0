From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [Resend/PATCH 0/5] omap4/5: i2c/spi: device tree data
Date: Wed, 13 Mar 2013 17:46:45 +0100
Message-ID: <5140AD75.2050900@ti.com>
References: <1363009486-19430-1-git-send-email-sourav.poddar@ti.com> <513DEAE1.1050606@ti.com> <513DFB62.5030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182Ab3CMQrB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 12:47:01 -0400
In-Reply-To: <513DFB62.5030709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, santosh.shilimkar@ti.com, Andrew Morton <akpm@osdl.org>

Hi Sourav,

I've just applied your branch after a minor subject cleanup for consistency.

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.10/dts

Regards,
Benoit


On 03/11/2013 04:42 PM, Sourav Poddar wrote:
> On Monday 11 March 2013 08:02 PM, Benoit Cousson wrote:
>> Hi Sourav,
>>
>> On 03/11/2013 02:44 PM, Sourav Poddar wrote:
>>> Hi Tony/Benoit,
>>>
>>> These patches had been sent couple of times before, but there were no
>>> comments on it.
>> Sorry for that. I got a big flu in Jan and was in Linaro Connect last
>> week.
>> Patches look good, I just have to check that they apply nicely to the
>> dts/for_3.9 I already prepared.
>>
> Ok. Thanks!!
>> I still have to rebase that branch on top of a recent master branch and
>> then check your branch.
>>
>>> If there are no comments, Can these be picked ?
>>> Cc: Andrew Morton<akpm@osdl.org>
>>>
>>> The following changes since commit
>>> f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
>>>
>>>    Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
>>>
>>> are available in the git repository at:
>>>    git@gitorious.org:linux-connectivity/linux-connectivity.git
>>> omap_i2c_spi_dts_data
>>>
>>> Felipe Balbi (1):
>>>        arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file
>>>
>>> Sourav Poddar (4):
>>>        arm: dts: omap4-sdp: Add I2c pinctrl data
>>>        arm: dts: omap5-evm: Add I2c pinctrl data
>>>        arm: dts: omap4-panda: Add I2c pinctrl data
>>>        arm: dts: omap5-evm: Add mcspi data
>> Thanks,
>> Benoit
>>
> 

