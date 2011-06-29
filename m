From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Wed, 29 Jun 2011 19:48:50 +0200
Message-ID: <BANLkTin8HQTCfV6zqNcWN-80vQ53YxT7xQ@mail.gmail.com>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
	<87mxh0tuk2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42426 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1F2Rsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 13:48:51 -0400
Received: by qwk3 with SMTP id 3so733507qwk.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 10:48:50 -0700 (PDT)
In-Reply-To: <87mxh0tuk2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Wed, Jun 29, 2011 at 7:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
>> is copied to internal SRAM at boot and after wake-up from CORE OFF m=
ode.
>> However only a small part of the code really needs to run from inter=
nal SRAM.
>>
>> This fix lets most of the ASM idle code run from the DDR
>> in order to minimize the SRAM usage and the overhead in the code cop=
y.
>>
>> The only pieces of code that are mandatory in SRAM are:
>> - the i443 erratum WA,
>> - the i581 erratum WA,
>> - the security extension code.
>>
>> SRAM usage:
>> - original code:
>> =A0 . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>> =A0 . 852 bytes for omap_sram_idle (used by suspend/resume in RETent=
ion),
>> =A0 . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode=
 on ES3.x),
>> =A0 . 108 bytes for save_secure_ram_context (used on HS parts only).
>>
>> With this fix the usage for suspend/resume in RETention goes down 28=
8 bytes,
>> so the gain in SRAM usage for suspend/resume is 564 bytes.
>>
>> Also fixed the SRAM initialization sequence to avoid an unnecessary
>> copy to SRAM at boot time and for readability.
>>
>> Tested on Beagleboard (ES2.x) in idle with full RET and OFF modes.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
>
> Also tested retention and off on 3430/n900, 3530/Overo and 3630/Zoom3
>
> Tested-by: Kevin Hilman <khilman@ti.com>
Thanks for the extensive testing!

Regards,
Jean

>
> Russell, if you're OK with it, can you add it to your suspend branch =
for
> the upcoming merge window?
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
