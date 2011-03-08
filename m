From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v8 3/7] omap3: pm: TWL4030 power scripts for OMAP3 boards
Date: Tue, 8 Mar 2011 12:20:00 +0530
Message-ID: <AANLkTimyppkqCgfxxy=--iJm1RkPt+yVG3QbWN7iZD5e@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-4-git-send-email-leslyam@ti.com>
	<87y64q4pak.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49123 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752784Ab1CHGuB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 01:50:01 -0500
Received: by mail-vw0-f52.google.com with SMTP id 20so6742238vws.25
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 22:50:00 -0800 (PST)
In-Reply-To: <87y64q4pak.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Tue, Mar 8, 2011 at 2:32 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_re=
set.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script is exported and can be used by any other
>> boardfile to update the power data in twl4030_platform_data.
>>
>> http://omapedia.org/wiki/TWL4030_power_scripts
>
> This is a very helpful wiki page, thanks for writing that up.
>
> I'd recommend putting a link into the C file as well, saying this cod=
e
> implements the recommended sequence as detailed at <wiki page>.
>
> One minor nit on naming here. =A0I think you should use the public na=
me
> TWL4030 throughout instead of Triton (which AFAIK, is not an acronym =
and
> should not be capitalized.)
>

I will add this link in the c file,
also correct the naming to TWL4030.

Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
