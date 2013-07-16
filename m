From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: OMAP2+: Provide alias to USB PHY clock
Date: Tue, 16 Jul 2013 16:39:25 +0300
Message-ID: <51E54D0D.3030200@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com> <1371571487-14389-5-git-send-email-rogerq@ti.com> <51E40199.9070906@ti.com> <20130716123256.GY7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130716123256.GY7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, benoit.cousson@linaro.org
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/16/2013 03:32 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130715 07:11]:
>> Hi Tony,
>>
>> On 06/18/2013 07:04 PM, Roger Quadros wrote:
>>> Till the OMAP clocks are correctly defined in device tree, use
>>> this temporary hack to provide clock alias to the USB PHY clocks.
>>>
>>> Without this, USB Host & Ethernet will not be functional with
>>> device tree boots on Panda and uEVM.
>>
>> Looks like this one got missed out.
>>
>> USB host no longer works on Panda with DT boot.
>> Could you please queue this for next 3.11-rc? Thanks.
> 
> OK thanks for checking, applying into omap-for-v3.11/fixes.

Thanks.

> 
> Looks like I also have some pending the .dts changes in
> omap-for-v3.11/dt branch:
> 
> 4cf2198b1e3cee47a1cccbb500b67782c36615d5 ARM: dts: omap3-beagle-xm: Add USB host supprot for Rev. Ax/Bx
> 9bc44515819a00c0ffaf751ad497ddf275089ede ARM: dts: omap3-beagle-xm: Add USB Host support
> fd65d7df4598c1d2ad27d664c719611a1a070edc ARM: dts: omap3-beagle: Make USB host pin naming consistent

Please disregard those. They are old versions.

Benoit had agreed to take the newer version of those for 3.12.

Please pick this one to get usb host working on 3.11 with DT.

http://www.spinics.net/lists/arm-kernel/msg253612.html

> 39ea891d9da6ae1824bc9f689db3f306f5ce0724 ARM: dts: omap4-panda: Add USB Host support

This one is already in through Benoit.

cheers,
-roger
