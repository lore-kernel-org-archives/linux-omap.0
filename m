From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is
 available.
Date: Fri, 13 Jan 2017 08:59:24 +0100
Message-ID: <423304d1-ffe3-ce7e-74d9-9707c391d501@ti.com>
References: <1483964535-4298-1-git-send-email-jjhiblot@ti.com>
 <20170112223007.GP2630@atomide.com> <20170112223627.GQ2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170112223627.GQ2630@atomide.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/01/2017 23:36, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170112 14:31]:
>> * Jean-Jacques Hiblot <jjhiblot@ti.com> [170109 04:23]:
>>> AHCI provides the register PORTS_IMPL to let the software know which port
>>> is supported. The register must be initialized by the bootloader. However
>>> in some cases u-boot doesn't properly initialize this value (if it is not
>>> compiled with SATA support for example or if the SATA initialization fails).
>>> The DTS entry "ports-implemented" can be used to override the value in
>>> PORTS_IMPL.
>>> Adding this entry in the dts allows us no to worry about what is done by
>>> the bootloader.
>> Adding into omap-for-v4.11/dt thanks.
> Actually not applying just yet as I just noticed you tagged this for stable.
>
> Care to describe what breaks and on which devices without this patch?
Hi tony,

Without this patch the SATA will not work in the following two cases:
* if there has been a failure to initialize SATA in u-boot.
* if ahci_platform module has been removed and re-inserted. The reason 
is that the content of PORTS_IMPL is lost after the module is removed. I 
suspect that it's because the controller is reset by the hwmod.

Jean-Jacques
>
> Regards,
>
> Tony
