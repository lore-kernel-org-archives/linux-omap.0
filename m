From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
Date: Sat, 9 Oct 2010 08:55:09 +0200
Message-ID: <AANLkTimLMZtqkk64xUWDuyPpadtZVb2_+YXF+WNSQW=i@mail.gmail.com>
References: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
	<87y6a8v48p.fsf@deeprootsystems.com>
	<87eic0ti7p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50540 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0JIGzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 02:55:10 -0400
Received: by qyk10 with SMTP id 10so2166560qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 23:55:09 -0700 (PDT)
In-Reply-To: <87eic0ti7p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>

Kevin,

On Sat, Oct 9, 2010 at 12:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> This patch reverts commit 914bab936fe0388a529079679e2f137aa4ff548d,=
 which
>>> breaks the OFF mode on the OMAP3 platforms.
>>> The details are here below.
>>>
>>> The intent behind the original patch was to fix some compiler
>>> warnings, which I do not have on my side. Is the problem dependent =
on
>>> the setup and config used?
>>
>>> From ec85bc90978cf0f257e73eaad593ffb774595863 Mon Sep 17 00:00:00 2=
001
>>> From: Jean Pihet <jean.pihet@newoldbits.com>
>>> Date: Fri, 8 Oct 2010 18:36:48 +0200
>>> Subject: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment=
 warnings"
>>>
>>> This reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
>>> breaks the OFF mode on the OMAP3 platforms.
>>>
>>> The use of a void* pointer for scratchpad_address confuses the
>>> compiler which generates wrong offset for the access to the L4
>>> address space. In that case an alignement fault is generated
>>> during the wake-up from OFF mode.
>>>
>>> The code that causes problem is:
>>> __raw_readl(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);
>>
>> Thanks Jean for tracking down why off-mode was broken on the master
>> branch.
>>
>> I completely agree this patch should be reverted. =A0However, the
>> description here could be a litle more descriptive.
>
> I changed my mind...
>
> Since only one part of the original patch introduced a bug, I decided=
 to
> just fix that bug and keep the fixes for the sparse warnings. =A0I ju=
st
> posted a patch[1] for the fix. =A0 Please test.
>
> Thanks,

Thanks for the follow-up on the patch. I will test asap.
>
> Kevin
>
> [1] https://patchwork.kernel.org/patch/242661/
>
Jean

>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
