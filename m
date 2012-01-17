From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 21:11:37 +0100
Message-ID: <CAMQu2gyjGYooWih=cK72VYEe8X_bKyOi3_eHec7cWi37CHBoJQ@mail.gmail.com>
References: <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com> <20120117194724.GI16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35061 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754778Ab2AQUMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 15:12:06 -0500
Received: by qadc11 with SMTP id c11so380717qad.7
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 12:12:05 -0800 (PST)
In-Reply-To: <20120117194724.GI16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 17, 2012 at 8:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 17, 2012 at 04:27:21PM +0000, Catalin Marinas wrote:
>> Anyway, the first step is this API provided by the secure firmware.
>> Since such API may need to be called before the MMU is initialised,
>> Linux would need to have knowledge of the platform type early on. Ha=
ving
>> some platform hook (asm macro) to call early on wouldn't work with t=
he
>> single zImage configuration. Stack space is not an issue as we alrea=
dy
>> have one for ARMv7 for D-cache flushing (XIP kernels would work but =
they
>> aren't that many).
>
> It _is_ a problem. =A0How much stack space would these undefined plat=
form
> specific functions require? =A016 words? =A032 words? =A0A page? =A0W=
here does
> this memory come from? =A0The .data section, or are we going to stuff=
 it
> into what is supposed to be the read-only text section?

Stack requirement is limited to saving and restoring the processor
registers. There is no additional need. If this is an issue, we can als=
o use
SRAM as a stack for this operation.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
