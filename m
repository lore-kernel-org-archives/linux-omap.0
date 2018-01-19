From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 15/15] clk: ti: convert to use proper register
 definition for all accesses
Date: Fri, 19 Jan 2018 11:42:17 +0200
Message-ID: <5cffb571-f3b0-1632-9f5c-d55e6068ce4f@ti.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
 <1489236606-24023-16-git-send-email-t-kristo@ti.com>
 <CAHCN7x+oKEmXBpogy4VOB8UgmTd6+X5fBiP66yzUqXmvDWdqaw@mail.gmail.com>
 <6b4c5bf2-1260-0e79-0414-9870f21e4a75@ti.com>
 <CAHCN7xLaP-th=vAzN8C1QXstf3c5SP4JADAZZXTb1Nd6N6QdsQ@mail.gmail.com>
 <20180117211907.GE4042@atomide.com>
 <CAHCN7xJ-NaKoeZOqrdc48fFCLNQvm_uRXC0ErtiG+Ac86a14+w@mail.gmail.com>
 <4f0f185a-2890-3747-7060-1f5b5a77022a@ti.com>
 <CAHCN7x+hkCyrj1pH7f5DQia-1QgF3g-idAo0Sd-vY6u8iLufWA@mail.gmail.com>
 <cee43b44-1de6-a317-e89a-57f86607df86@ti.com>
 <CAHCN7xL0Y8z+QhCQC8GrDeqiiHPQwnemR5mwJYEGMxUPFZfe6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xL0Y8z+QhCQC8GrDeqiiHPQwnemR5mwJYEGMxUPFZfe6Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 18/01/18 16:12, Adam Ford wrote:
> On Thu, Jan 18, 2018 at 7:29 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> On 18/01/18 15:26, Adam Ford wrote:
>>>
>>> On Thu, Jan 18, 2018 at 1:34 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>
>>>> On 17/01/18 23:44, Adam Ford wrote:
>>>>>
>>>>>
>>>>> On Wed, Jan 17, 2018 at 3:19 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>>
>>>>>>
>>>>>> * Adam Ford <aford173@gmail.com> [180117 15:15]:
>>>>>>>
>>>>>>>
>>>>>>> On Wed, Jan 17, 2018 at 8:02 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 17/01/18 15:27, Adam Ford wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sat, Mar 11, 2017 at 6:50 AM, Tero Kristo <t-kristo@ti.com>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Currently, TI clock driver uses an encapsulated struct that is cast
>>>>>>>>>> into
>>>>>>>>>> a void pointer to store all register addresses. This can be
>>>>>>>>>> considered
>>>>>>>>>> as rather nasty hackery, and prevents from expanding the register
>>>>>>>>>> address field also. Instead, replace all the code to use proper
>>>>>>>>>> struct
>>>>>>>>>> in place for this, which contains all the previously used data.
>>>>>>>>>>
>>>>>>>>>> This patch is rather large as it is touching multiple files, but
>>>>>>>>>> this
>>>>>>>>>> can't be split up as we need to avoid any boot breakage.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I know it's late coming, but according to git bisect, this patch is
>>>>>>>>> causing some problems with Logic PD Torpedo 37xx Dev kit.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Oh reporting bugs is never too late, thanks for posting this out.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> It it is a DM3730 that has a WL1283 chipset attached to the SDIO
>>>>>>>>> interface on MMC3.  The driver seems to load properly, but when
>>>>>>>>> loading wpa_supplicant to activate the WL1283, we get a giant crash.
>>>>>>>>> I checked kernel revisions starting at 4.14 and working back to when
>>>>>>>>> it worked, then used git bisect from there.
>>>>>>>>>
>>>>>>>>> I am hoping it might be a simple fix for something that just needs
>>>>>>>>> to
>>>>>>>>> get added or tweaked in the device tree.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I don't have access to the specific hw, but can you try to dig out
>>>>>>>> which
>>>>>>>> hwmod is causing the crash? Just print out the oh->name from the
>>>>>>>> _wait_softreset_complete. That would help root causing the issue.
>>>>>>>>
>>>>>>>
>>>>>>> With one small patch, I was able to make it work again.
>>>>>>>
>>>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>> index 2dbd632..ed1f625 100644
>>>>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>>>>> @@ -477,7 +477,7 @@ static int _wait_softreset_complete(struct
>>>>>>> omap_hwmod *oh)
>>>>>>>            int c = 0;
>>>>>>>
>>>>>>>            sysc = oh->class->sysc;
>>>>>>> -
>>>>>>> +pr_warn("_wait_softreset_complete: %s\n", oh->name);
>>>>>>>            if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
>>>>>>>                    omap_test_timeout((omap_hwmod_read(oh,
>>>>>>> sysc->syss_offs)
>>>>>>>                                       & SYSS_RESETDONE_MASK),
>>>>>>>
>>>>>>>
>>>>>>> This leads me to believe that the omap_test_timeout functions might
>>>>>>> not be working quite right.
>>>>>>
>>>>>>
>>>>>>
>>>>>> There may be a srst_udelay needed for some module, see commit
>>>>>> ebf244148092 ("ARM: OMAP2+: Use srst_udelay for USB on dm814x")
>>>>>> for example.
>>>>>>
>>>>>> You might be able to find which module it is by commenting out
>>>>>> postcore_initcall_sync(omap3_l3_init) in drivers/bus/omap_l3_smx.c
>>>>>> temporarily as the system will most likely hang right there.
>>>>>
>>>>>
>>>>>
>>>>> I commented out that line as you suggested, but the system boots as
>>>>> normal and I get the crash (as normal)
>>>>>
>>>>> I am looking through the DM3730 and OMAP3630 TRM now.  Any thought on
>>>>> a keyword search I should use to see which hwmods might require
>>>>> srst_udelay?
>>>>
>>>>
>>>>
>>>> Looking at the log you provided, it looks like only mmc1, mmc3 and i2c1
>>>> are
>>>> reset during the wlan probe. Based on the prints coming out in the
>>>> failing
>>>> case, it looks like the culprit might be mmc3 for some reason.
>>>>
>>>> [   18.239746] _wait_softreset_complete: mmc3
>>>> [   18.638580] _wait_softreset_complete: mmc3
>>>> [   18.657562] _wait_softreset_complete: mmc1
>>>> [   18.833374] wlcore: firmware booted (Rev 7.3.10.0.141)
>>>>
>>>> ^ the firmware notification above does not come out in the crash.
>>>>
>>>
>>> I agree with your assessment.  Any ideas why moving the debug
>>> statement before the if statement would make it start working?  I
>>> added some artificial udelay at around 100, but I still got the crash.
>>> It seems like there is some timing issue, but at the same time just
>>> adding a delay isn't enough.
>>
>>
>> The pr_warn does more than just delay, it accesses the io-space potentially
>> causing a flush on certain IO ranges. There might be some OCP readback
>> missing for example, in which case a simple udelay may not help.
>>
> 
> I am not very familiar with the OCP and/or how the flushing would
> impact this.  Do you have any suggestions on how I can troubleshoot?

Typically an OCP barrier is inserted in the code as an immediate 
readback of the register in question, this effectively forces the 
register write all the way to the IP.

But, you said that the issue gets fixed with 4.15-rc? You could just 
simply bisect the issue and see which exact patch fixes it.

-Tero

> 
> adam
> 
>> -Tero
>>
>>
>>>
>>>> -Tero
>>>>
>>>
>>> adam
>>>
>>>>>
>>>>> adam
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Tony
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>
>>
>> --

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
