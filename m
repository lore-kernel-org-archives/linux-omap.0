From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: problem with "undefined instruction"
Date: Sat, 30 Apr 2011 22:27:42 +0530
Message-ID: <4DBC3F86.3010902@ti.com>
References: <20110430162357.GA14287@earth.universe> <yw1xwribr8n5.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44418 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039Ab1D3Q6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 12:58:13 -0400
Received: by yxh35 with SMTP id 35so1909576yxh.8
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 09:58:11 -0700 (PDT)
In-Reply-To: <yw1xwribr8n5.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org

On 4/30/2011 10:14 PM, M=E5ns Rullg=E5rd wrote:
> Sebastian Reichel<sre@debian.org>  writes:
>

[..]

>>
>>     32ecc:   9cd0        ldr r4, [sp, #832]  ; 0x340
>>     32ece:   fffe e92d   vtbl.8  d30, {d14-d15}, d29
>>
>> 00032ed0<_IO_vfprintf>:
>>     32ed0:   e92d 4ff0   stmdb   sp!, {r4, r5, r6, r7, r8, r9, sl, f=
p, lr}
>>     32ed4:   ed2d 8b02   vpush   {d8}
>
> Your userland appears to be built with Thumb2.  Make sure CONFIG_THUM=
B
> is enabled in your kernel.
>
Oh yes. The config has CONFIG_ARM_THUMB=3Dy but THUMB2 isn't enabled.

CONFIG_THUMB2_KERNEL=3Dy should fix the problem.

Regards
Santosh



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
