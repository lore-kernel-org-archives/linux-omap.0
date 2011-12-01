From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 02/11] mfd: twl6040: Fix wrong TWL6040_GPO3 bitfield value
Date: Thu, 1 Dec 2011 11:35:20 -0600
Message-ID: <CAKnK67R_sTToETijbBsyKXfdfvKv68vaF-_Ur5uYy=yKJ4hiEA@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-3-git-send-email-saaguirre@ti.com> <201112011824.54207.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201112011824.54207.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, sakari.ailus@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

Thanks for the review.

On Thu, Dec 1, 2011 at 11:24 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Sergio,
>
> On Thursday 01 December 2011 01:14:51 Sergio Aguirre wrote:
>> The define should be the result of 1 << Bit number.
>>
>> Bit number for GPOCTL.GPO3 field is 2, which results
>> in 0x4 value.
>>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0include/linux/mfd/twl6040.h | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040=
=2Eh
>> index 2463c261..2a7ff16 100644
>> --- a/include/linux/mfd/twl6040.h
>> +++ b/include/linux/mfd/twl6040.h
>> @@ -142,7 +142,7 @@
>>
>> =A0#define TWL6040_GPO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01
>> =A0#define TWL6040_GPO2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> -#define TWL6040_GPO3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03
>> +#define TWL6040_GPO3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x04
>
> What about defining the fields as (1 << x) instead then ?

I thought about that, but I guess I just wanted to keep it
consistent with the rest of the file.

Maybe I can create a separate patch for changing all these bitwise
flags to use BIT() macros instead.

Thanks and Regards,
Sergio

>
>>
>> =A0/* ACCCTL (0x2D) fields */
>
> --
> Regards,
>
> Laurent Pinchart
