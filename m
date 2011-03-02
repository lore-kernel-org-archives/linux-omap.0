From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 1/8] omap3: pm: Fix for the TRITON sleep/wakeup sequence
Date: Wed, 2 Mar 2011 11:38:14 +0530
Message-ID: <AANLkTik_5e6mKJMNJKgqzFhZj1qU=1qZmASLTKkw2cX4@mail.gmail.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
	<1298723139-1693-2-git-send-email-leslyam@ti.com>
	<87pqqafp30.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:58847 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752590Ab1CBGIQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 01:08:16 -0500
Received: by vxc38 with SMTP id 38so4822928vxc.10
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 22:08:15 -0800 (PST)
In-Reply-To: <87pqqafp30.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Wed, Mar 2, 2011 at 4:03 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Since the function to populate the sleep script is getting called al=
ways
>> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
>> is getting over written by the sleep script. Adding the missing brac=
kets for
>> if statement to fix the issue.
>
> This is still a confusing changelog. =A0How about simply:
>
> Only write the sleep script when TWL4030_SLEEP_SCRIPT is set.
>

Yes, I agree

Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.

Regards,
Lesly A M

< ... >

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>> - =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT)
>> + =A0 =A0 if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (order)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("TWL4030: Bad=
 order of scripts (sleep "\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "script before wakeup) Leads to boot"\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "failure on some boards\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D twl4030_config_sleep_sequence(ad=
dress);
>> + =A0 =A0 }
>> =A0out:
>> =A0 =A0 =A0 return err;
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
