From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 01/12] omap3: pm: Fix for the TRITON sleep/wakeup sequence
Date: Mon, 21 Feb 2011 15:09:42 +0530
Message-ID: <AANLkTik-U0EDfTLCe_UonJbjiDH_Txo5bmQegg=LoYam@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-2-git-send-email-leslyam@ti.com>
	<AANLkTimSS9eDXaWhwfWOKS3oDf5UQPTrW0amfSaex0ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58370 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949Ab1BUJjn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 04:39:43 -0500
Received: by mail-vw0-f45.google.com with SMTP id 19so1608834vws.4
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 01:39:43 -0800 (PST)
In-Reply-To: <AANLkTimSS9eDXaWhwfWOKS3oDf5UQPTrW0amfSaex0ZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi David,

On Sat, Feb 19, 2011 at 5:08 AM, David Cohen <dacohen@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 18, 2011 at 7:08 PM, Lesly A M <leslyam@ti.com> wrote:
>> Since the function to populate the sleep script is getting called al=
ways
>> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
>> is getting over written by the sleep script.
>
> Are you sure this is the correct patch description? For me it's somet=
hing like:
> Add missing brackets to if statement.

Yes, adding the missing brackets, to fix this issue.
Ok, I will include "adding the missing brackets" in the change log.

Regards,
Lesly AM
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0drivers/mfd/twl4030-power.c | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power=
=2Ec
>> index 16422de..2c0d4d1 100644
>> --- a/drivers/mfd/twl4030-power.c
>> +++ b/drivers/mfd/twl4030-power.c
>> @@ -447,12 +447,13 @@ static int __init load_twl4030_script(struct t=
wl4030_script *tscript,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT)
>> + =A0 =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (order)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("TWL4030: =
Bad order of scripts (sleep "\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"script before wakeup) Leads to boot"\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"failure on some boards\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D twl4030_config_sleep_sequence=
(address);
>> + =A0 =A0 =A0 }
>> =A0out:
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
