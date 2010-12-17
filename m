From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
Date: Fri, 17 Dec 2010 11:18:11 +0100
Message-ID: <AANLkTi=968TjtNn_M5FV54xF-E8Xw=3xohN0g+iJZ04Z@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
	<f3afb9340d4f1d0c8d2936d9faea79c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45298 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab0LQKSM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:18:12 -0500
Received: by qyj19 with SMTP id 19so1420439qyj.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:18:11 -0800 (PST)
In-Reply-To: <f3afb9340d4f1d0c8d2936d9faea79c8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh, Kevin,

On Fri, Dec 17, 2010 at 6:05 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Jean,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Thursday, December 16, 2010 11:21 PM
>> To: linux-omap@vger.kernel.org
>> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.or=
g;
>> Jean Pihet
>> Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch only contains clean-ups and cosmetic changes,
>> no functional change.
>>
>> Clean-up of the ASM sleep code, for better readability and
>> easier maintenance.
>>
>> Applies on top of Nishant's latest idle path errata fixes step 2,
>> cf. http://marc.info/?l=3Dlinux-omap&m=3D129139584919242&w=3D2
>>
> Thanks for cleanup. Have few minor comments on these patches.

Thanks for the review.
I fixed the issues and reposted the series as '[PATCH 0/7 v5] OMAP3:
clean up ASM sleep code'.

Regards,
Jean

>
>> Jean Pihet (7):
>> =A0 OMAP2+: use global values for the SRAM PA addresses
>> =A0 OMAP3: remove hardcoded values from the ASM sleep code
>> =A0 OMAP3: re-organize the ASM sleep code
>> =A0 OMAP3: rework of the ASM sleep code execution paths
>> =A0 OMAP3: add comments for low power code errata
>> =A0 OMAP3: ASM sleep code format rework
>> =A0 OMAP3: remove unused code from the ASM sleep code
>>
>> =A0arch/arm/mach-omap2/control.c =A0 | =A0 10 +-
>> =A0arch/arm/mach-omap2/control.h =A0 | =A0 =A02 +
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 =A01 -
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 =A04 +-
>> =A0arch/arm/mach-omap2/sdrc.h =A0 =A0 =A0| =A0 =A07 +
>> =A0arch/arm/mach-omap2/sleep34xx.S | =A0714
> +++++++++++++++++++++-------------
>> -----
>> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 | =A0 =A07 +-
>> =A07 files changed, 401 insertions(+), 344 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
