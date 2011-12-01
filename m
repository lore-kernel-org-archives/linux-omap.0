From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 01/11] TWL6030: Add mapping for auxiliary regs
Date: Thu, 1 Dec 2011 11:47:15 -0600
Message-ID: <CAKnK67QKwBCGoQdBALqBjqxx4fNXz_6o3kz7O7y4xffew1c-QA@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-2-git-send-email-saaguirre@ti.com> <CANrkHUZb=ZtMcPyFXkktE0LztBzLcB7vmWPPgriTo7O0yeOPzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:52338 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755280Ab1LARrh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 12:47:37 -0500
In-Reply-To: <CANrkHUZb=ZtMcPyFXkktE0LztBzLcB7vmWPPgriTo7O0yeOPzw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi

Hi Balaji,

Thanks for the review.

On Thu, Dec 1, 2011 at 9:58 AM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> On Thu, Dec 1, 2011 at 5:44 AM, Sergio Aguirre <saaguirre@ti.com> wro=
te:
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0drivers/mfd/twl-core.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
>> index bfbd660..e26b564 100644
>> --- a/drivers/mfd/twl-core.c
>> +++ b/drivers/mfd/twl-core.c
>> @@ -323,7 +323,7 @@ static struct twl_mapping twl6030_map[] =3D {
>> =A0 =A0 =A0 =A0{ SUB_CHIP_ID0, TWL6030_BASEADD_ZERO },
>> =A0 =A0 =A0 =A0{ SUB_CHIP_ID1, TWL6030_BASEADD_ZERO },
>>
>> - =A0 =A0 =A0 { SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
>> + =A0 =A0 =A0 { SUB_CHIP_ID1, TWL6030_BASEADD_AUX },
>
> Instead you can use TWL6030_MODULE_ID1, with base address as
> zero for all registers in auxiliaries register map.

Ok.

I'm actually thinking about this, and in the process on reviewing the
need to access those registers.

I should probably be using the regulator framework to control VAUX3 ins=
tead...

Thanks for your inputs.

Regards,
Sergio

>
>> =A0 =A0 =A0 =A0{ SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
>> =A0 =A0 =A0 =A0{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
>> =A0 =A0 =A0 =A0{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
>> --
>> 1.7.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
