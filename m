From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 17:00:26 +0000
Message-ID: <AANLkTi=vCOShfeLN7_WRor4C5bQ6zVzBMO1XsWtt8=WH@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081615.15713.arnd@arndb.de>
	<20110208162515.GB6188@n2100.arm.linux.org.uk>
	<201102081747.18674.arnd@arndb.de>
	<20110208165537.GE6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48704 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab1BHRA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 12:00:27 -0500
Received: by ewy5 with SMTP id 5so3092590ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 09:00:26 -0800 (PST)
In-Reply-To: <20110208165537.GE6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 4:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 05:47:18PM +0100, Arnd Bergmann wrote:
>> On Tuesday 08 February 2011 17:25:16 Russell King - ARM Linux wrote:
>> > On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
>> > > But that doesn't work if you build a combined v5/v6/v7 kernel, b=
ecause
>> > > v5 supports neither form, right? I think to do that, it needs th=
e
>> > > same kind of abstraction that we have for a number of other thin=
gs
>> > > like cache management in arch/arm/mm/.
>> >
>> > The options are kernels which support v3-v5 or v6-v7. =A0There's t=
oo big
>> > a change between v5 and v6 to combine those into one kernel.
>>
>> Ah, good to know. I never realized this with the common binary discu=
ssions.
>> Building for the versatile/realview platform makes it possible to se=
lect
>> any of ARM926 and the v6/v6k/v7 CPUs, as well as ARM7TDMI in the sam=
e
>> kernel config, so I assumed that this was actually a valid configura=
tion
>> aside from bugs.
>>
>> Would an attempt to make a combined v5/v6 kernel result in unaccepta=
bly
>> bad code, or is this just too much work for anyone to be bothered wi=
th
>> and little practical value?
>
> If you build for anything less than v6, you lose all barriers, the ic=
ache
> synchronization, and proper atomic operations. =A0Just to name a few.
>

Can we represent the restriction in Kconfig somehow?

=46or example:

CPU_V6 depends on CPU_COMMON_V6PLUS
CPU_V7 depends on CPU_COMMON_V6PLUS
CPU_V5 depends on CPU_COMMON_V3_TO_V5
CPU_V4 depends on CPU_COMMON_V3_TO_V5
CPU_V3 depends on CPU_COMMON_V3_TO_V5

CPU_COMMON_V6PLUS depends on !CPU_COMMON_V3_TO_V5
CPU_COMMON_V3_TO_V5 depends on !CPU_COMMON_V6PLUS

=2E..or something like that.

---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
