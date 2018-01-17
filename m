From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCHv2 15/15] clk: ti: convert to use proper register
 definition for all accesses
Date: Wed, 17 Jan 2018 15:44:18 -0600
Message-ID: <CAHCN7xJ-NaKoeZOqrdc48fFCLNQvm_uRXC0ErtiG+Ac86a14+w@mail.gmail.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
 <1489236606-24023-16-git-send-email-t-kristo@ti.com> <CAHCN7x+oKEmXBpogy4VOB8UgmTd6+X5fBiP66yzUqXmvDWdqaw@mail.gmail.com>
 <6b4c5bf2-1260-0e79-0414-9870f21e4a75@ti.com> <CAHCN7xLaP-th=vAzN8C1QXstf3c5SP4JADAZZXTb1Nd6N6QdsQ@mail.gmail.com>
 <20180117211907.GE4042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20180117211907.GE4042@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 17, 2018 at 3:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Adam Ford <aford173@gmail.com> [180117 15:15]:
>> On Wed, Jan 17, 2018 at 8:02 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> > On 17/01/18 15:27, Adam Ford wrote:
>> >>
>> >> On Sat, Mar 11, 2017 at 6:50 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> >>>
>> >>> Currently, TI clock driver uses an encapsulated struct that is cast into
>> >>> a void pointer to store all register addresses. This can be considered
>> >>> as rather nasty hackery, and prevents from expanding the register
>> >>> address field also. Instead, replace all the code to use proper struct
>> >>> in place for this, which contains all the previously used data.
>> >>>
>> >>> This patch is rather large as it is touching multiple files, but this
>> >>> can't be split up as we need to avoid any boot breakage.
>> >>>
>> >>
>> >> I know it's late coming, but according to git bisect, this patch is
>> >> causing some problems with Logic PD Torpedo 37xx Dev kit.
>> >
>> >
>> > Oh reporting bugs is never too late, thanks for posting this out.
>> >
>> >>
>> >> It it is a DM3730 that has a WL1283 chipset attached to the SDIO
>> >> interface on MMC3.  The driver seems to load properly, but when
>> >> loading wpa_supplicant to activate the WL1283, we get a giant crash.
>> >> I checked kernel revisions starting at 4.14 and working back to when
>> >> it worked, then used git bisect from there.
>> >>
>> >> I am hoping it might be a simple fix for something that just needs to
>> >> get added or tweaked in the device tree.
>> >
>> >
>> > I don't have access to the specific hw, but can you try to dig out which
>> > hwmod is causing the crash? Just print out the oh->name from the
>> > _wait_softreset_complete. That would help root causing the issue.
>> >
>>
>> With one small patch, I was able to make it work again.
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 2dbd632..ed1f625 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -477,7 +477,7 @@ static int _wait_softreset_complete(struct omap_hwmod *oh)
>>         int c = 0;
>>
>>         sysc = oh->class->sysc;
>> -
>> +pr_warn("_wait_softreset_complete: %s\n", oh->name);
>>         if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
>>                 omap_test_timeout((omap_hwmod_read(oh, sysc->syss_offs)
>>                                    & SYSS_RESETDONE_MASK),
>>
>>
>> This leads me to believe that the omap_test_timeout functions might
>> not be working quite right.
>
> There may be a srst_udelay needed for some module, see commit
> ebf244148092 ("ARM: OMAP2+: Use srst_udelay for USB on dm814x")
> for example.
>
> You might be able to find which module it is by commenting out
> postcore_initcall_sync(omap3_l3_init) in drivers/bus/omap_l3_smx.c
> temporarily as the system will most likely hang right there.

I commented out that line as you suggested, but the system boots as
normal and I get the crash (as normal)

I am looking through the DM3730 and OMAP3630 TRM now.  Any thought on
a keyword search I should use to see which hwmods might require
srst_udelay?

adam

>
> Regards,
>
> Tony
