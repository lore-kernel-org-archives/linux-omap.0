From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Wed, 8 Dec 2010 10:11:48 +0100
Message-ID: <AANLkTinbrg0q5bGfpWrTuc5YNMvM=DgXx2eqYrfKhQJr@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
	<87ipz5hxuw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46965 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0LHJLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 04:11:49 -0500
Received: by vws16 with SMTP id 16so746717vws.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 01:11:48 -0800 (PST)
In-Reply-To: <87ipz5hxuw.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

On Wed, Dec 8, 2010 at 2:11 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Some bad interaction between the idle and the suspend paths has been
>> noticed: the idle code is called during the suspend enter and exit
>> sequences. This could cause corruption or lock-up of resources.
>>
>> The solution is to move the call to disable_hlt at the very beginnin=
g
>> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepa=
re),
>> and the call to enable_hlt at the very end of the suspend sequence
>> (in omap3_pm_end instead of omap3_pm_finish).
>>
>> Tested with RET and OFF on Beagle and OMAP3EVM.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> Can you update this to do similar for OMAP2 and OMAP4?
Done!
It needs some testing on OMAP2 and OMAP4 boards since it has been
compile tested only.

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
