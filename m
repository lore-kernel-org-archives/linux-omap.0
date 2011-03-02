From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Wed, 2 Mar 2011 16:10:10 +0530
Message-ID: <AANLkTimvDp_W8Kei=RreXtaBZ+879dBuTvj4K2j+Ve6W@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-3-git-send-email-govindraj.raja@ti.com> <AANLkTim8tTO5wDvzXxy8G35vYMBsXP2fJu=KHDHpw7aC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <AANLkTim8tTO5wDvzXxy8G35vYMBsXP2fJu=KHDHpw7aC@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 2, 2011 at 10:19 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> Govind,
>
> Couple of minor comments.
>
> On Mon, Feb 28, 2011 at 20:09, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
>> For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means t=
hey
>> are wakeup capable) enable the IO-daisy wakeup capability.
>> During re-muxing avoid direct write with val as this can disturb if =
any
>> mux done at bootloader level so read the pad then write back.
>>
>> Also add a api to fetch the wake-up status bit is set for given omap=
-hwmod
>
> %s/a api/an API/
>
>> device using available mux info which is added during omap_hwmod_mux=
_init.
>> Wakeup status bit is needed for uart_resume_idle call from sram_idle=
 path
>> based on wake-up event has occurred for given uart we can enable clo=
cks back.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 23 +++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 +++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13=
 +++++++++++++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
>> =A04 files changed, 50 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index 98148b6..5338b93 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -317,6 +317,24 @@ err1:
>> =A0 =A0 =A0 =A0return NULL;
>> =A0}
>>
>> +/* Gets the wakeup status of given pad from omap-hwmod */
>> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>> +{
>> + =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 unsigned int val =3D -EINVAL;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < hmux->nr_pads; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D &hmux-=
>pads[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(pad->partition, =
pad->mux->reg_offset);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (val > 0 && val & OMAP_WAKEUP_EVENT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 else
>
> No need of else here.

Yes correct.

I am resending this patch with some more modifications
to fix one more issue in the above loop.

--
Thanks,
Govindraj.R



<<SNIP>>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
