From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to
 ensure correctness
Date: Wed, 7 Sep 2011 17:54:58 +0100
Message-ID: <CAHkRjk5qyR4O2bXPSX4U7pPG2+K0B=U=G3kJGHM43vBzko-jsw@mail.gmail.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
 <E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk> <CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
 <20110907161906.GA2327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62329 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab1IGQzZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 12:55:25 -0400
Received: by yie30 with SMTP id 30so5105018yie.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 09:55:24 -0700 (PDT)
In-Reply-To: <20110907161906.GA2327@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On 7 September 2011 17:19, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 07, 2011 at 04:41:32PM +0100, Catalin Marinas wrote:
>> On 1 September 2011 13:49, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Add a dsb after the isb to ensure that the previous writes to the
>> > CP15 registers take effect before we enable the MMU.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> > =A0arch/arm/mm/proc-v7.S | =A0 =A01 +
>> > =A01 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> > index dec72ee..a773f4e 100644
>> > --- a/arch/arm/mm/proc-v7.S
>> > +++ b/arch/arm/mm/proc-v7.S
>> > @@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
>> > =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r4, c10, c2, 0 =A0@ write PRRR
>> > =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r5, c10, c2, 1 =A0@ write NMRR
>> > =A0 =A0 =A0 =A0isb
>> > + =A0 =A0 =A0 dsb
>>
>> Isn't an ISB enough here? We usually have the DSB for some backgroun=
d
>> operations like cache maintenance.
>
> That depends whether you're including the effects of the cache
> maintanence instructions in this. =A0The ARM ARM tells me that
> a DSB is required to ensure that all cache maintanence is issued
> before the dsb is complete at the point that the dsb is executed.

Another minor point, in general we would use the DSB before the ISB
(but that's when the I-cache is enabled).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
