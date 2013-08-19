From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 0/9] USB: phy: phy-nop: Manage RESET GPIO in the driver
Date: Mon, 19 Aug 2013 10:37:06 +0300
Message-ID: <5211CB22.4040600@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <520E0461.70305@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520E0461.70305@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: devicetree@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, tony@atomide.com, linux-usb@vger.kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 08/16/2013 01:52 PM, Benoit Cousson wrote:
> Hi Roger,
> 
> On 15/08/2013 12:18, Roger Quadros wrote:
>> Hi,
>>
>> Modelling the RESET line as a regulator supply wasn't a good idea
>> as it abuses the regulator framework and makes adaptation
>> code/data more complex.
>>
>> Instead, manage the RESET gpio line directly in the driver.
>>
>> This also makes us easy to migrate to a dedicated GPIO RESET controller
>> whenever it becomes available. As of now, it doesn't seem to be making
>> it into 3.12.
>>
>> *NOTE:* As there are changes to platform data, Patch 1 needs to be shared
>> between the arm-soc tree and usb tree.
>>
>> Patch 1 is available at repo
>>     git://github.com/rogerq/linux.git
>> in branch
>>     phy-reset-common
>>
>> Patch 2 contains the phy-nop driver changes
>> Patches 3 and 4 adapt legacy boot code to the phy-nop driver changes.
>> Patches 5, 6 and 7 adapt DT data to the binding changes.
>> Patch 8 is cleanup of omap3-beagle DT.
>> Patch 9 adds USB host support to omap3-beagle-xm using the new binding.
>>
>> Patches are based on v3.11-rc5.
>> Tested leacy boot on omap3-beagle and omap3-beagle-xm
>> Tested DT boot on omap3-beagle, omap3-beagle-xm and omap4-panda-es
>>
>> v2:
>> - Added RESET GPIO polarity feature
>> - Changed to gpio_set_value_cansleep()
>>
>> cheers,
>> -roger
>>
>> ---
>> Roger Quadros (9):
>>    usb: phy: nop: Add gpio_reset to platform data
>>    usb: phy: nop: Don't use regulator framework for RESET line
>>    ARM: OMAP2+: omap-usb-host: Get rid of platform_data from struct
>>      usbhs_phy_data
>>    ARM: OMAP2+: usb-host: Adapt to USB phy-nop RESET line changes
>>    ARM: dts: omap3-beagle: Use reset-gpios for hsusb2_reset
>>    ARM: dts: omap4-panda: Use reset-gpios for hsusb1_reset
>>    ARM: dts: omap5-uevm: Use reset-gpios for hsusb2_reset
>>    ARM: dts: omap3-beagle: Make USB host pin naming consistent
>>    ARM: dts: omap3-beagle-xm: Add USB Host support
> 
> The 5 DTS patches looks good to me, and I can apply them, but you need to be sure that the driver will be merged for 3.12 as well.

Could you please let us know if this series can make it to 3.12? Thanks.

cheers,
-roger
