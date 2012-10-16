From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3] ARM: vfp: fix save and restore when running on pre-VFPv3
 and CONFIG_VFPv3 set
Date: Tue, 16 Oct 2012 12:13:22 -0500
Message-ID: <507D95B2.3020506@ti.com>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com> <20121013090255.GT28061@n2100.arm.linux.org.uk> <yw1xr4p2myre.fsf@unicorn.mansr.com> <20121013133654.GU28061@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1210150157400.16624@utopia.booyaka.com> <CAG5Tg6XqpeRppWbr9-yBmsf+2TobhE5ateMX4crs10grn-tuAA@mail.gmail.com> <alpine.DEB.2.00.1210150523190.15973@utopia.booyaka.com> <20121015175317.GE15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab2JPRNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 13:13:40 -0400
In-Reply-To: <20121015175317.GE15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, linux-arm-kernel@lists.infradead.org


On 10/15/2012 12:53 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [121014 22:26]:
>>
>> After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: fi=
x
>> saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP boar=
d
>> started crashing during boot with omap2plus_defconfig:
>>
>> [    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
>> [    3.915954]  mmcblk0: p1
>> [    4.086639] Internal error: Oops - undefined instruction: 0 [#1] =
SMP ARM
>> [    4.093719] Modules linked in:
>> [    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
>> [    4.103149] PC is at vfp_reload_hw+0x1c/0x44
>> [    4.107666] LR is at __und_usr_fault_32+0x0/0x8
>>
>> It turns out that the context save/restore fix unmasked a latent bug
>> in commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Ma=
ke
>> VFPv3 usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel i=
s
>> booted on a pre-VFPv3 core, the code attempts to save and restore th=
e
>> d16-d31 VFP registers.  These are only present on non-D16 VFPv3+, so
>> this results in an undefined instruction exception.  The code didn't
>> crash before commit 846a136 because the save and restore code was
>> only touching d0-d15, present on all VFP.
>>
>> Fix by implementing a request from Russell King to add a new HWCAP
>> flag that affirmatively indicates the presence of the d16-d31
>> registers:
>>
>>    http://marc.info/?l=3Dlinux-arm-kernel&m=3D135013547905283&w=3D2
>>
>> and some feedback from M=E5ns to clarify the name of the HWCAP flag.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Cc: M=E5ns Rullg=E5rd <mans.rullgard@linaro.org>
>=20
> This fixes the error above on my 2430sdp:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

=46ixes same error on 2420 H4.

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
