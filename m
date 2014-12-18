From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 18 Dec 2014 10:16:18 +0000
Message-ID: <20141218101618.GJ11502@n2100.arm.linux.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <5491F0B6.4090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37962 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752278AbaLRKQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Dec 2014 05:16:29 -0500
Content-Disposition: inline
In-Reply-To: <5491F0B6.4090904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>

On Wed, Dec 17, 2014 at 11:08:06PM +0200, Jyri Sarha wrote:
> I tried booting my 4460 Panda - which is the closest thing to 4430SDP that
> I've got - on next-20141217, but I could not get it to the point where the
> omap-abe-twl6040 probed. It probably is the problem you are talking about as
> the hang does not happen if I disable ASoC ABE all together, right?
> 
> I'll take a deeper look at it tomorrow, as Peter is not working ATM.

Digging into this at my end:

[<c02c8698>] (snd_soc_instantiate_card) from [<c02c95f0>] (snd_soc_register_card+0x344/0x424)
 r10:0000005c r9:00000000 r8:00000620 r7:ce437630 r6:ce437630 r5:00000002
 r4:c05cae58

c02c95e8:       e1a00004        mov     r0, r4
c02c95ec:       ebfffc29        bl      c02c8698 <snd_soc_instantiate_card>

So 'card' is 0xc05cae58, which is correct: c05cae58 d omap_abe_card

[<c02cc0ec>] (snd_soc_dapm_add_routes) from [<c02c8f40>] (snd_soc_instantiate_card+0x8a8/0xc14)
 r10:00000000 r9:00000000 r8:ce437010 r7:ce437630 r6:00000002 r5:c05cb0bc
 r4:c05cae58

c02c8f28:       e594110c        ldr     r1, [r4, #268]  ; 0x10c
c02c8f2c:       e3510000        cmp     r1, #0
c02c8f30:       0a000002        beq     c02c8f40 <snd_soc_instantiate_card+0x8a8>
c02c8f34:       e51b0044        ldr     r0, [fp, #-68]  ; 0x44
c02c8f38:       e5942110        ldr     r2, [r4, #272]  ; 0x110
c02c8f3c:       eb000c6a        bl      c02cc0ec <snd_soc_dapm_add_routes>

This corresponds with:

        if (card->dapm_routes)
                snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
                                        card->num_dapm_routes);

Again, we see r4 is the omap_abe_card, and the code is loading dapm_routes
and num_dapm_routes.  The dump of this in the vmlinux file gives:

c05cae58 <omap_abe_card>:
        ...
c05caf5c:       c045d098        umaalgt sp, r5, r8, r0
c05caf60:       0000000a        andeq   r0, r0, sl
c05caf64:       c045d6a4        subgt   sp, r5, r4, lsr #13
c05caf68:       00000011        andeq   r0, r0, r1, lsl r0

and 0x10c/0x110 gives 0xc045d6a4  / 17.  c045d6a4 r audio_map
So that looks fine.

[<c02cbf08>] (snd_soc_dapm_add_route) from [<c02cc134>] (snd_soc_dapm_add_routes+0x48/0xac)
 r10:c0458801 r9:00000000 r8:00000037 r7:00000000 r6:00000000 r5:c05cafb8
 r4:ce57b420

c02cc0ec <snd_soc_dapm_add_routes>:
c02cc0fc:       e1a05000        mov     r5, r0
c02cc104:       e1a04001        mov     r4, r1
c02cc108:       e3a07000        mov     r7, #0
c02cc114:       e1a08002        mov     r8, r2
c02cc118:       e2844010        add     r4, r4, #16
c02cc120:       e1a06007        mov     r6, r7
c02cc128:       ea00000f        b       c02cc16c <snd_soc_dapm_add_routes+0x80>

c02cc12c:       e1a00005        mov     r0, r5
c02cc130:       ebffff74        bl      c02cbf08 <snd_soc_dapm_add_route>
c02cc134:       e2509000        subs    r9, r0, #0
c02cc138:       aa000009        bge     c02cc164 <snd_soc_dapm_add_routes+0x78>
...
c02cc168:       e2844010        add     r4, r4, #16
c02cc16c:       e1560008        cmp     r6, r8
c02cc170:       e2441010        sub     r1, r4, #16
c02cc174:       baffffec        blt     c02cc12c <snd_soc_dapm_add_routes+0x40>

Here, r5 is &card->dapm.  r4 should be card->dapm_routes, possibly
incremented by 16 up to 17 times, which should be in the range of
0xc045d6a4 - 0xc045d7b4, but it isn't, it's 0xce57b420.

Also, r8 is card->num_dapm_routes, which should be 17, but it's 0x37
(55).  The index is r6, and at least that's sensibly at zero.

Now, we have this call to snd_soc_of_parse_audio_routing(), which
allocates some memory, copies the old routes into it, and then adds
to them from DT.  That explains why the pointer and number of routes
are different - there's 19 routes in omap4-sdp.dts - 17 + 19 = 36.
So that doesn't work - but importantly, it does point towards a
possible culpret - snd_soc_of_parse_audio_routing().

This is obvious when you stop and think about what it's doing, this is
truely where this bug lies, and it /is/ in generic ASoC code.

The problem is that this function doesn't consider the implications of
deferred probing.  Let's see what happens if we defer, and re-do the
ABE initialisation, including calling this function:

17 + 19 = 36. - first probe
17 + 19 + 19 = 55. - second probe

Oh - that works in terms of the number, and it would also explain why
the table has been screwed - because the second time we memcpy(), we're
memcpy()ing from data which was allocated via devm_kzalloc(), and thus
would have been freed after the first failed probe.

Mark - this is a core ASoC problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
