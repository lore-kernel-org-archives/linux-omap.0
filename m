From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Wed, 31 Oct 2012 20:04:05 +0200
Message-ID: <C9715CB7-D3E2-4CA7-8A93-2B10E8B70640@antoniou-consulting.com>
References: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com> <20121031175219.GH12739@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121031175219.GH12739@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Oct 31, 2012, at 7:52 PM, Tony Lindgren wrote:

> * Pantelis Antoniou <panto@antoniou-consulting.com> [121031 10:26]:
>> It is painless to move the adapter DT devices to arch/arm/mach-omap2
>> 
>> However I got bit by the __init at omap_build_device family functions.
>> If you don't remove it, crashes every time you instantiate a device
>> at runtime, or you load the cape driver as a module.
> 
> Hmm I think you misunderstood me. You only need to create the
> platform_device under arch/arm/mach-omap2. The device creation
> happens only at __init, so omap_build_device can stay as __init.
> The driver itself should be under drivers.
> 
> But is this bus on non-device-tree omaps? If not, just make it
> device tree only.
> 

I'm afraid that's not the case. The whole notion of capebus is that
instantiation of the devices doesn't just happen early at the boot
sequence.

It is perfectly valid for a cape to be instantiated via loading
a module, or by making an override by writing a sysfs file.

When having the __init there, the function has been long removed
and you get a crash by calling into the weeds.

So the sequence is:

<early boot>       Register the adapter driver.

<user>             insmod bone-geiger-cape
<cape-is-matched>  call omap_build_device

Please look into the capebus patches for the details. 

> Regards,
> 
> Tony

Regards

-- Pantelis
