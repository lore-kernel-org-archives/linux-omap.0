From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Tue, 3 Dec 2013 14:49:40 +0530
Message-ID: <529DA22C.6060102@ti.com>
References: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>	<529D9D43.6040101@ti.com>
 <CAAfyv37Vie1vZK2XQ1cfVq6eVnSuaBLfykk6pU8fwEyqvPF4BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAfyv37Vie1vZK2XQ1cfVq6eVnSuaBLfykk6pU8fwEyqvPF4BA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Dr. H.
 Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 03 December 2013 02:38 PM, Belisko Marek wrote:
> Hi,
> 
> On Tue, Dec 3, 2013 at 9:58 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi,
>>
>> On Tuesday 03 December 2013 02:03 PM, Marek Belisko wrote:
>>> Without this change when booting omap3 device (gta04) with board file
>>> leads to follwing errors:
>>>
>>> [    1.203308] musb-hdrc musb-hdrc.0.auto: unable to find phy
>>> [    1.209075] HS USB OTG: no transceiver configured
>>> [    1.214019] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
>>>
>>> and usb isn't working.
>>>
>>> This is probably regression caused by commit: 6c27f939
>>
>> I think a better fix would be to have this merged..
>> https://lkml.org/lkml/2013/7/26/91
> Yes I see but how this could help with current situation? Ho you then
> specify device number?

With this we can for sure know the device numbering (of MUSB) starts from '0'.
If we use PLATFORM_DEVID_AUTO, we won't know what dev number has been assigned
to us. In your case you get "musb-hdrc.0.auto" because no one else is creating
a device using PLATFORM_DEVID_AUTO (before your device is created).
> This patch is fixing 3.13-rcx regression.
> 
>>>
>>> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
>>> ---
>>>  arch/arm/mach-omap2/twl-common.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
>>> index b0d54da..3640ce0 100644
>>> --- a/arch/arm/mach-omap2/twl-common.c
>>> +++ b/arch/arm/mach-omap2/twl-common.c
>>> @@ -92,7 +92,7 @@ void __init omap_pmic_late_init(void)
>>>
>>>  #if defined(CONFIG_ARCH_OMAP3)
>>>  struct phy_consumer consumers[] = {
>>> -     PHY_CONSUMER("musb-hdrc.0", "usb"),
>>> +     PHY_CONSUMER("musb-hdrc.0.auto", "usb"),
>>
>> the index '0' might vary for some boards leading it to again break musb.
> If you run grep for musb-hdrc :
> arch/arm/mach-omap2/board-3430sdp.c: usb_bind_phy("musb-hdrc.0.auto",
> 0, "twl4030_usb");
> arch/arm/mach-omap2/board-devkit8000.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> arch/arm/mach-omap2/board-overo.c: usb_bind_phy("musb-hdrc.0.auto", 0,
> "twl4030_usb");
> arch/arm/mach-omap2/board-omap3beagle.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> arch/arm/mach-omap2/board-omap3touchbook.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> arch/arm/mach-omap2/board-cm-t35.c: usb_bind_phy("musb-hdrc.0.auto",
> 0, "twl4030_usb");
> arch/arm/mach-omap2/board-omap3stalker.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> arch/arm/mach-omap2/board-omap3logic.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> arch/arm/mach-omap2/board-2430sdp.c: usb_bind_phy("musb-hdrc.0.auto",
> 0, "twl4030_usb");
> arch/arm/mach-omap2/board-ldp.c: usb_bind_phy("musb-hdrc.0.auto", 0,
> "twl4030_usb");
> arch/arm/mach-omap2/board-rx51.c: usb_bind_phy("musb-hdrc.0.auto", 0,
> "twl4030_usb");
> arch/arm/mach-omap2/board-omap3pandora.c:
> usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");

hmm.. that patch was in a series that fixes this too
https://lkml.org/lkml/2013/7/26/88

Thanks
Kishon
