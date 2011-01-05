From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] staging: tidspbridge - configure full L1 MMU range
Date: Wed, 5 Jan 2011 13:45:12 -0600
Message-ID: <AANLkTi=g+Z1wGHYGUZFRZFPTyYVadQiHm7Ex3ET0PcVz@mail.gmail.com>
References: <1294208410-4772-1-git-send-email-fernando.lugo@ti.com>
	<AANLkTinNhBwjFPXwWFWUVfccUzJFN+6NDgxiuKNa_9N7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinNhBwjFPXwWFWUVfccUzJFN+6NDgxiuKNa_9N7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: gregkh@suse.de, rene.sapiens@ti.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 5, 2011 at 12:46 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> Hi,
>
> On Wed, Jan 5, 2011 at 12:20 AM, Fernando Guzman Lugo
> <fernando.lugo@ti.com> wrote:
>> Otherwise a virtual address beyond of the L1 size is used,
>> the MMU hardware will look into a memory that does not belong to
>> L1 translation tables. IOW; the MMU would allow to access any
>> memory, configured or not.
>>
>
> How about:
>
> IVA MMU can manage up to 4GB of address space through its page tables=
,
> given that it's L1 is divided into 1MB sections it requires at least
> 16KB for its table which represents 4096 entries of 32 bits each.
>
> Previously, only 1GB was being handled by setting the page table size
> to 4KB, any virtual address beyond of the L1 size used, would fall
> into memory that does not belong to L1 translation tables, leading to
> unpredictable results.
>
> So, set the L1 table size to cover the entire MMU range (4GB) whether
> is meant to be used or not.

looks good to me.

>
>> Reported-by: Felipe Contreras <felipe.contreras@nokia.com>
>> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
>> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
>> ---
>> =A0drivers/staging/tidspbridge/core/tiomap3430.c | =A0 =A06 ++----
>> =A01 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers=
/staging/tidspbridge/core/tiomap3430.c
>> index 1be081f..ec96d1e 100644
>> --- a/drivers/staging/tidspbridge/core/tiomap3430.c
>> +++ b/drivers/staging/tidspbridge/core/tiomap3430.c
>> @@ -70,6 +70,7 @@
>> =A0#define MMU_LARGE_PAGE_MASK =A0 =A0 =A00xFFFF0000
>> =A0#define MMU_SMALL_PAGE_MASK =A0 =A0 =A00xFFFFF000
>> =A0#define OMAP3_IVA2_BOOTADDR_MASK 0xFFFFFC00
>> +#define MMU_L1_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A00x4000
>> =A0#define PAGES_II_LVL_TABLE =A0 512
>> =A0#define PHYS_TO_PAGE(phys) =A0 =A0 =A0pfn_to_page((phys) >> PAGE_=
SHIFT)
>>
>> @@ -786,10 +787,7 @@ static int bridge_dev_create(struct bridge_dev_=
context
>>
>> =A0 =A0 =A0 =A0pt_attrs =3D kzalloc(sizeof(struct pg_table_attrs), G=
=46P_KERNEL);
>> =A0 =A0 =A0 =A0if (pt_attrs !=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Assuming that we use only DSP's mem=
ory map
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* until 0x4000:0000 , we would need=
 only 1024
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* L1 enties i.e L1 size =3D 4K */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pt_attrs->l1_size =3D 0x1000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pt_attrs->l1_size =3D MMU_L1_SIZE;
>
> How about using SZ_16K instead, struct member name already specifies
> it is L1 size, is the new define needed?

Ok, maybe a comment to state why 16K is used should be good.

I will make the changes.

Regards,
=46ernando.

>
> Regards,
>
> Omar
>
