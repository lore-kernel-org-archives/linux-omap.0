From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 10/12] OMAP2+: hwmod: Add api to enable io_ring wakeup.
Date: Thu, 5 May 2011 11:28:51 +0530
Message-ID: <BANLkTin-Yyg5cLUpjRvXvAQgoNN4anKHUQ@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-11-git-send-email-govindraj.raja@ti.com> <87mxj2nhjn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87mxj2nhjn.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 5:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Add api to enable io_pad wakeup based on mux dynamic pad and
>
> s/api/API/
> s/io_pad/IO pad/

will update.

>
>> wake_up enable flag initialized during hwmod_mux.
>>
>> Use the wakeup flag and pad_remux flag and enable wakeup capability
>> for the pad having these flags enabled.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> This patch (except for the serial.c hange) isn't really dependent on =
the
> rest of this series, and should be a separate patch to be merged by
> Paul.
>

Yes. fine will post out hwmod API additions as separate patch.

> Some other comments below...
>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 34 +++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 ++++
>> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
>> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 26 +++++++++++++++++++
>> =A05 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index e034294..4a12336 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2369,3 +2369,37 @@ int omap_hwmod_no_setup_reset(struct omap_hwm=
od *oh)
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> +
>> +/**
>> + * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
>> + * @oh: struct omap_hwmod *
>> + * @enable: based on 0 or 1 set or unset wakeup bit.
>
> more specifically, when true, set wakeup bit, when false, clear wakeu=
p bit

ok.

>
>> + * traverse through dynamic pads. If pad is enabled then
>> + * set wakeup bit for the mux pin. Return error if pads are
>> + * not enabled or not available.
>> + */
>
> The comment here should be clearer about when the bit actually gets
> set. =A0Specifically, this function doesn't actually write the value =
out,
> but instead it configures the value which will be used during the hwm=
od
> idle transition.
>

Yes correct. Will update the comments.

> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
