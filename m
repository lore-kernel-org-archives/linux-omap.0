From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND v5 0/4] OMAP GPMC DT bindings
Date: Fri, 30 Nov 2012 11:23:43 +0530
Message-ID: <50B849E7.30600@ti.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3EA07317@DBDE01.ent.ti.com>
 <50B74DCC.5060808@gmail.com>
 <518397C60809E147AF5323E0420B992E3EA0BB6B@DBDE01.ent.ti.com>
 <50B77DD5.4090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50B77DD5.4090001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 11/29/2012 8:53 PM, Daniel Mack wrote:
> On 29.11.2012 16:08, Philip, Avinash wrote:
>> On Thu, Nov 29, 2012 at 17:28:04, Daniel Mack wrote:
>>> Hi Avinash,
>>>
>>> On 29.11.2012 06:24, Philip, Avinash wrote:
>>>> On Wed, Nov 28, 2012 at 22:28:55, Daniel Mack wrote:
>>>>> [Resending +devicetree-discuss, +Rob, +Grant]
>>>>>
>>>>>
>>>>> This is a series of patches to support GPMC peripherals on OMAP boards.
>>>>>
>>>>> Depends on Linus' master +
>>>>> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
>>>>
>>>> Can you resend this series on top of linux_next?
>>>
>>> The only branch these patches depend on is the
>>> "omap-for-v3.8/cleanup-headers-gpmc" branch from omap_next. Are you
>>> actually seeing any merge conflicts with my series? If so, which branch
>>> are you referring to exactly?
>>>
>>>> Some of the missing items I seen 
>>>> 1. Of_node not populated in  omap_nand_platform_data structure.
>>>
>>> Hmm - gpmc_probe_nand_child() from 4/4 adds
>>>
>>>   gpmc_nand_data->of_node = child;
>>>
>>> Do I miss anything?
>>
>> I didn't found definition for of_node member in omap_nand_platform_data
>> structure. This also might be missing in liniux-next?
> 
> Ah, right. I got that entry from your patch ("mtd: nand: omap2: Support
> for hardware BCH error correction"). But you're right, it should be part
> of my series. Will add that when resending, but note that your ELM
> series will then cause a (trivial) merge conflict.
> 
>>>> 2. Remove platform device creation from hwmod as GPMC DT is populating.
>>>>    Currently GPMC device creaing from DT & HWMOD.
>>>
>>> This is already addressed in cd00b0530 ("ARM: OMAP2+: gpmc: Fix kernel
>>> BUG for DT boot mode") by Vaibhav Hiremath, which I got via Afzal's USB
>>> branch:
>>
>> Purpose of VH's patch was to get beagle bone booting, but Jon sent another
>> patch that made beagle bone boot and it has reached mainline by v3.7-rc2,
>> hence the patch you are referring to is currently not going upstream. Still to
>> have GPMC DT work, we need that patch as other wise there would be two GPMC
>> devices. In earlier versions of your series, you had a similar patch, it is
>> required, can you please add it to your series as otherwise with your series
>> GPMC DT won't work.
> 
> Ok, fine. Will do.
>

Feel free to take that patch forward, merge into your series.

Thanks,
Vaibhav


> 
> Daniel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
