From: Li Li <eggonlea@gmail.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Fri, 8 Apr 2011 11:39:09 +0800
Message-ID: <BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
References: <20100623133636.GC7058@shareable.org>
	<20100629141836.GM2822@atomide.com>
	<alpine.LFD.2.00.1006291355520.24097@xanadu.home>
	<20100630110828.GZ2822@atomide.com>
	<20100630131737.GF2822@atomide.com>
	<alpine.LFD.2.00.1006301011520.24097@xanadu.home>
	<20100701092510.GH2822@atomide.com>
	<20100701174051.GA8786@shareable.org>
	<alpine.LFD.2.00.1007012226170.26524@xanadu.home>
	<20100702103744.GJ6632@atomide.com>
	<20100705135526.GF15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:63505 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab1DHDjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 23:39:10 -0400
Received: by pxi2 with SMTP id 2so1617915pxi.10
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 20:39:09 -0700 (PDT)
In-Reply-To: <20100705135526.GF15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, Jamie Lokier <jamie@shareable.org>, linux-arm-kernel@lists.infradead.org

Dears,

I cannot understand how TLS EMU ensure it's SMP safe, because get_tls
helper (at 0xffff0fe0) just read the value from 0xffff0ff0. But all
SMP cores should have the exact same mapping to the vectors page (at
0xffff0000). So various threads running on different SMP cores at the
same time would get the same emulated TLS value (instead of thread
specific value set via set_tls). Could anybody explain this a little
bit?

Thanks,
Lea

On Mon, Jul 5, 2010 at 9:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [100702 13:32]:
>> * Nicolas Pitre <nico@fluxnic.net> [100702 05:31]:
>> > On Thu, 1 Jul 2010, Jamie Lokier wrote:
>> >
>> > > Tony Lindgren wrote:
>> > > > +static void __init kuser_get_tls_init(unsigned long vectors)
>> > > > +{
>> > > > + =A0 =A0 =A0 /*
>> > > > + =A0 =A0 =A0 =A0* vectors + 0xfe0 =3D __kuser_get_tls
>> > > > + =A0 =A0 =A0 =A0* vectors + 0xfe8 =3D hardware TLS instructio=
n at 0xffff0fe8
>> > > > + =A0 =A0 =A0 =A0*/
>> > > > + =A0 =A0 =A0 if (tls_emu || has_tls)
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy((void *)vectors + 0xfe0, =
(void *)vectors + 0xfe8, 4);
>> > > > +}
>> > >
>> > > Just a little opinion: Perhaps has_tls_reg would be a clearer na=
me.
>> > > All variants "have TLS" after all.
>> >
>> > Good point.
>>
>> I like that too. Updated patch below.
>
> I've uploaded this patch into Russell's patch system:
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D6207=
/1
>
> Jamie, assuming no more comments, do you care to Ack/Reviewed/Tested-=
by
> the patch in the link above?
>
> Regards,
>
> Tony
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
