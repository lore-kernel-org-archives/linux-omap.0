From: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu/omap: Convert to devicetree
Date: Mon, 23 Dec 2013 17:42:05 -0600
Message-ID: <52B8CA4D.8000501@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
	<52B89394.5060902@ti.com> <52B8A87F.7080100@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52B8A87F.7080100-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: florian.vaussard-p8DiymsW2f8@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Florian,

 >>
>> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>>> As OMAP2+ is moving to a full DT boot for 3.14, commit 7ce93f3
>>> "ARM: OMAP2+: Fix more missing data for omap3.dtsi file" adds
>>> basic DT bits. But the driver is not yet converted, so this will
>>> not work and driver will not be probed. Convert it!
>>>
>>> Apart from standard bindings, this patch uses 'dma-window' (already
>>> used by Tegra SMMU) and adds a custom 'ti,#tlb-entries' binding.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>> ---
>>>    .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 19 ++++++++++++
>>>    arch/arm/mach-omap2/omap-iommu.c                   |  5 +++
>>>    drivers/iommu/omap-iommu.c                         | 36
>>> +++++++++++++++++++---
>>>    3 files changed, 55 insertions(+), 5 deletions(-)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>> b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>> new file mode 100644
>>> index 0000000..4e5027c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>>> @@ -0,0 +1,19 @@
>>> +OMAP3 IOMMU used by camera subsystem
>>
>> As I mentioned in comments on your cover-letter, the current binding is
>> only limited to OMAP3 ISP, but the driver is common for all OMAP2+ SoCs.
>> This binding an update to handle all SoCs.
>>
>> To summarize the differences, OMAP2/3 has the same MMU register set for
>> all remote processor MMUs (IVA/DSP/ISP) with the only difference being
>> the number of TLBs supported (8 for ISP on OMAP2/3 and 32 for all other
>> instances on all OMAP2+ SoCs). Depending on whether the compatibility
>> property is defined for an SoC or for the processor, "ti,#tlb-entries"
>> can be retrieved directly from the match data or made as an optional
>> property, with the default value being 32.
>>
>
> It makes sense.
>
>> OMAP4 and OMAP5 have some additional registers (MMU_FAULT_PC,
>> MMU_FAULT_STATUS, MMU_GP_REG/DSPSS_MMU_GPR) on top of the OMAP2/OMAP3
>> ones, and DRA7 a further superset of OMAP4/OMAP5. The only difference is
>> the definition of the MMU_GPR register, which is different between the
>> IPU and DSP processors, but present at the same offset, and dictates the
>> validity of the MMU_FAULT_PC and MMU_FAULT_STATUS registers. The MMU_GPR
>> register is also not defined on OMAP4430 ES1.0, but is present on all
>> other newer SoCs.
>>
>
> Thank you for this detailed comparison ! I do not know much about
> OMAP4 and OMAP5. In the current implementation, I was unable to find
> references to these specificities. Is this currently supported?

OMAP4 iommu devices are instantiated today in legacy form, using the 
hwmod data. These are used by the remoteproc driver. OMAP5 data has not 
yet been added, as there is no point in adding it in legacy form at the 
moment.

>
>>> +
>>> +Required properties:
>>> +- compatible : "ti,omap3-mmu-isp"
>> My suggestion would be to use
>>      "ti,omap2-iommu" for OMAP2/OMAP3 MMUs with the optional
>> "ti,#tlb-entries" to distinguish ISP MMU.
>>      "ti,omap4-iommu" for OMAP4/OMAP5 MMUs with an additional boolean
>> property to distinguish the presence/functionality of the MMU_GPR register
>>      "ti,dra7-iommu" for DRA7 MMUs
>>
>> Mark, Tony,
>> Do you have any other recommendations given the above summary?
>>
>>> +- ti,hwmods : "mmu_isp"
>> Replace with general description
>>
>
> You mean something like "Name of the hwmod associated to the IOMMU"?

Yes.

regards
Suman

[snip]
