From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP2+: Fix boot with multi_v7_defconfig
Date: Tue, 11 Feb 2014 08:17:38 -0600
Message-ID: <52FA3102.7080407@ti.com>
References: <1392055835-6494-1-git-send-email-rogerq@ti.com> <52FA2B4F.3010408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FA2B4F.3010408@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

On 02/11/2014 07:53 AM, Roger Quadros wrote:
> On 02/10/2014 08:10 PM, Roger Quadros wrote:
>> The OMAP EHCI controller is not compatible with the EHCI
>> platform HCD driver so don't claim that we are.
>>
>> This fixes boot on OMAP platforms with CONFIG_USB_EHCI_HCD_PLATFORM=y
>> e.g. multi_v7_defconfig
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Please ignore this patch as Hans has agreed to do a more proper fix in
> 
> http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7015
umm.. even then, drivers/usb/host/ehci-ppc-of.c claims compatibility
with usb,ehci -> and we wont function with that driver either.

-- 
Regards,
Nishanth Menon
