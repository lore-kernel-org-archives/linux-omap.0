From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH] omap:iommu-added cache flushing operation for L2 cache
Date: Wed, 2 Mar 2011 10:12:53 -0600
Message-ID: <AANLkTimiYogk7Ceon==L3q=FQrySgq51JYzbVyiY5XD=@mail.gmail.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
	<1dc497a090414bf80ff588791d6db5cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1dc497a090414bf80ff588791d6db5cc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, hiroshi.doyu@nokia.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

On Wed, Mar 2, 2011 at 6:48 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Hello,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Fernando Guzman Lugo
>> Sent: Wednesday, March 02, 2011 1:17 AM
>> To: hiroshi.doyu@nokia.com
>> Cc: tony@atomide.com; linux@arm.linux.org.uk; linux-
>> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Ramesh Gupta; Hari Kanigeri
>> Subject: [PATCH] omap:iommu-added cache flushing operation for L2
>> cache
>>
>> From: Ramesh Gupta <grgupta@ti.com>
>>
>> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/plat-omap/iommu.c | =A0 22 ++++++++--------------
>> =A01 files changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index e3eb038..aeb2c33 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -471,22 +471,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);
>> =A0 */
>> =A0static void flush_iopgd_range(u32 *first, u32 *last)
>> =A0{
>> - =A0 =A0 /* FIXME: L2 cache should be taken care of if it exists */
>> - =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 asm("mcr =A0 =A0 =A0 =A0p15, 0, %0, c7, c1=
0, 1 @ flush_pgd"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : : "r" (first));
>> - =A0 =A0 =A0 =A0 =A0 =A0 first +=3D L1_CACHE_BYTES / sizeof(*first)=
;
>> - =A0 =A0 } while (first <=3D last);
>> + =A0 =A0 dmac_flush_range(first, last);
>
> There is note just above this API.

Thank you for your inputs. I agree, I will send an updated patch with
proper apis.

regards
Ramesh Gupta G
