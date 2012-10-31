From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Wed, 31 Oct 2012 22:12:44 +0200
Message-ID: <8AD2F7AF-8315-442B-A394-1A38DAB29F52@antoniou-consulting.com>
References: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com> <20121031175219.GH12739@atomide.com> <C9715CB7-D3E2-4CA7-8A93-2B10E8B70640@antoniou-consulting.com> <20121031180935.GL12739@atomide.com> <50918223.6080003@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50918223.6080003@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Oct 31, 2012, at 9:55 PM, Benoit Cousson wrote:

> Hi Panto,
> 
> On 10/31/2012 07:09 PM, Tony Lindgren wrote:
>> * Pantelis Antoniou <panto@antoniou-consulting.com> [121031 11:05]:
>>> Hi Tony,
>>> 
>>> On Oct 31, 2012, at 7:52 PM, Tony Lindgren wrote:
>>> 
>>>> * Pantelis Antoniou <panto@antoniou-consulting.com> [121031 10:26]:
>>>>> It is painless to move the adapter DT devices to arch/arm/mach-omap2
>>>>> 
>>>>> However I got bit by the __init at omap_build_device family functions.
>>>>> If you don't remove it, crashes every time you instantiate a device
>>>>> at runtime, or you load the cape driver as a module.
>>>> 
>>>> Hmm I think you misunderstood me. You only need to create the
>>>> platform_device under arch/arm/mach-omap2. The device creation
>>>> happens only at __init, so omap_build_device can stay as __init.
>>>> The driver itself should be under drivers.
>>>> 
>>>> But is this bus on non-device-tree omaps? If not, just make it
>>>> device tree only.
>>>> 
>>> 
>>> I'm afraid that's not the case. The whole notion of capebus is that
>>> instantiation of the devices doesn't just happen early at the boot
>>> sequence.
>>> 
>>> It is perfectly valid for a cape to be instantiated via loading
>>> a module, or by making an override by writing a sysfs file.
>>> 
>>> When having the __init there, the function has been long removed
>>> and you get a crash by calling into the weeds.
>>> 
>>> So the sequence is:
>>> 
>>> <early boot>       Register the adapter driver.
>> 
>> OK this is always there for the hardware, and done during
>> the __init and this one should have an omap_device..
>> 
>>> <user>             insmod bone-geiger-cape
>>> <cape-is-matched>  call omap_build_device
>>> 
>>> Please look into the capebus patches for the details. 
>> 
>> ..but it seems that the devices connected to capebus should
>> not have anything to do with omap_device and hwmod?
> 
> 
> Yeah, I do agree. I'm confused as well. Only OMAP IPs under PRCM control
> could have an hwmod and thus must be handled by an omap_device.
> 
> Any devices that is created later cannot be omap_device. The DT core
> will create regular platform_device for them.
> 
> Since cape is an external board, it should have nothing to do with
> omap_device.
> 
> Looking at your patch:
> da8xx-dt: Create da8xx DT adapter device
> 
> I understand why you do that, but in fact that patch does not make sense
> to me :-(
> 
> Why do you have to create an omap_device from the driver probe?
> 

The problem is that capes are not external boards in the normal sense
as a PCI board is. In the PCI case the hardware that implements the 
desired functionality is on the PCI board, while in the cape case the
hardware module is in the SoC. The cape most of the times is quite
simple and contains passive components, leds or some kind of I2C/SPI devices.

In the da8xx case it contains only the minimum hardware required for 
interfacing to the required display type, be it an LCD or a DVI or something
other.

You can't instantiate the omap_device early in the boot process like it was done up to 
now in the board file. You can only do that later in the boot process (for built-in 
cape drivers), or even after user-space has booted and the matching cape driver module
has been loaded.

So this is a use case that hasn't been encountered yet I'm afraid, but it is a valid
use case.

I don't see what the big deal is about to be honest. The omap device is safely created
in the da8xx-dt adapter's probe method, and everything seems to work.

If there are any gotcha's or problems with this approach I think can be overcome.

> 
> Regards,
> Benoit
> 

Regards

-- Pantelis
