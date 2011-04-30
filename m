From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: problem with "undefined instruction"
Date: Sat, 30 Apr 2011 18:09:19 +0100
Message-ID: <yw1xsjszr7i8.fsf@unicorn.mansr.com>
References: <20110430162357.GA14287@earth.universe>
	<yw1xwribr8n5.fsf@unicorn.mansr.com> <4DBC3F86.3010902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52866 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab1D3RJe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 13:09:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QGDfh-0006jA-HQ
	for linux-omap@vger.kernel.org; Sat, 30 Apr 2011 19:09:33 +0200
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 19:09:33 +0200
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 19:09:33 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 4/30/2011 10:14 PM, M=E5ns Rullg=E5rd wrote:
>> Sebastian Reichel<sre@debian.org>  writes:
>>
>
> [..]
>
>>>
>>>     32ecc:   9cd0        ldr r4, [sp, #832]  ; 0x340
>>>     32ece:   fffe e92d   vtbl.8  d30, {d14-d15}, d29
>>>
>>> 00032ed0<_IO_vfprintf>:
>>>     32ed0:   e92d 4ff0   stmdb   sp!, {r4, r5, r6, r7, r8, r9, sl, =
fp, lr}
>>>     32ed4:   ed2d 8b02   vpush   {d8}
>>
>> Your userland appears to be built with Thumb2.  Make sure CONFIG_THU=
MB
>> is enabled in your kernel.
>>
> Oh yes. The config has CONFIG_ARM_THUMB=3Dy but THUMB2 isn't enabled.

Sorry, I meant CONFIG_ARM_THUMB and that is indeed enabled.  Must be
something else.

> CONFIG_THUMB2_KERNEL=3Dy should fix the problem.

No, that builds the kernel in Thumb2 mode and you probably don't want
that.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
