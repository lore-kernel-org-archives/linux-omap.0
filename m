From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
Date: Sat, 18 Dec 2010 00:07:27 +0100
Message-ID: <AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<87bp4k6m1d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57349 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab0LQXH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 18:07:28 -0500
Received: by qyj19 with SMTP id 19so2186370qyj.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 15:07:27 -0800 (PST)
In-Reply-To: <87bp4k6m1d.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Sat, Dec 18, 2010 at 12:02 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> jean.pihet@newoldbits.com writes:
>
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
>
> Can you do one more spin of this series in order to collect the
> reviewed-by/tested-by tags posted, and address some of Nishanth's
> comments. =A0Since we are reaching a merge window deadline, I'll leav=
e it
> to your discretion to decide which of Nishanth's suggestions to addre=
ss
> now and which to address later.
Sure I will post a new version tomorrow.
This will include some fixes after Nishant's comments. The rest can be
done later after we agree on the future changes.

Thanks,
Jean

>
> Kevin
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
>> =A0arch/arm/mach-omap2/control.c =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
>> =A0arch/arm/mach-omap2/control.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-
>> =A0arch/arm/mach-omap2/sdrc.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0| =A0724 +++++++++=
++++++++---------------
>> =A0arch/arm/plat-omap/include/plat/sram.h | =A0 11 +
>> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 +=
-
>> =A08 files changed, 413 insertions(+), 346 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
