From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 2/3] omap3: change ISP's IOMMU da_start address
Date: Tue, 8 Mar 2011 19:15:27 +0200
Message-ID: <AANLkTimBxYqSuBCPzmJUWa7KZzvt4SaPwOwXHhqciYBe@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-3-git-send-email-dacohen@gmail.com>
	<4D7637D0.4010402@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D7637D0.4010402@maxwell.research.nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, fernando.lugo@ti.com, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

On Tue, Mar 8, 2011 at 4:06 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> David Cohen wrote:
>> ISP doesn't consider 0x0 as a valid address, so it should explicitly
>> exclude first page from allowed 'da' range.
>>
>> Signed-off-by: David Cohen <dacohen@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/omap-iommu.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/=
omap-iommu.c
>> index 3fc5dc7..3bea489 100644
>> --- a/arch/arm/mach-omap2/omap-iommu.c
>> +++ b/arch/arm/mach-omap2/omap-iommu.c
>> @@ -33,7 +33,7 @@ static struct iommu_device omap3_devices[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .name =3D "isp",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .nr_tlb_entries =3D 8,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .clk_name =3D "cam_ick",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .da_start =3D 0x0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .da_start =3D 0x1000,
>
> The NULL address is still valid for the MMU. Can the IOVMF_DA_ANON
> mapping be specified by the API to be always non-NULL?

The patch 1/3 does that :)

>
> This way it would be possible to combine IOVMF_DA_FIXED and
> IOVMF_DA_ANON mappings in the same IOMMU while still being able to re=
ly
> that IOVMF_DA_ANON mappings would always be non-NULL.

Indeed the IOMMU driver supports it. The flag is set by iovm area and
each IOMMU instance supports a mix of mappings with fixed da or not.
By changing the OMAP3 "isp" IOMMU pdata's da_start to 0x1000, we're
explicitly saying that iovm areas with fixed 'da' or not will never
map first page to OMAP3 ISP driver, what is the behavior it expects.
Without this patch, thanks to patch 1/3 the IOMMU driver will not map
address 0x0 to OMAP3 ISP anyway. But then ISP will be passing wrong
information that it would be fine to map first page. :)

Kind regards,

David Cohen

>
> Regards,
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
>
