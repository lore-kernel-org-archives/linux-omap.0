From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 31 Dec 2014 14:59:35 +0200
Message-ID: <54A3F337.6030607@ti.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk> <20141217172333.GE23854@atomide.com> <20141218164122.GH23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbaLaNAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2014 08:00:11 -0500
In-Reply-To: <20141218164122.GH23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

On 12/18/2014 06:41 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [141217 09:28]:
>>
>> And then there are these too in the current mainline that are
>> clock related:
>>
>> omap4xxx_dt_clk_init: failed to configure ABE DPLL!
>> ...
>> clock: dpll_abe_ck failed transition to 'locked'
>> clock: dpll_abe_ck failed transition to 'locked'
>> clock: dpll_abe_ck failed transition to 'locked'
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:851 clk_disable+0x24/0x3=
0()
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-09274-g53c5279 #699
>> Hardware name: Generic OMAP4 (Flattened Device Tree)
>> [<c00154b4>] (unwind_backtrace) from [<c0011b7c>] (show_stack+0x10/0=
x14)
>> [<c0011b7c>] (show_stack) from [<c05d5068>] (dump_stack+0x80/0x9c)
>> [<c05d5068>] (dump_stack) from [<c003e104>] (warn_slowpath_common+0x=
78/0xb4)
>> [<c003e104>] (warn_slowpath_common) from [<c003e15c>] (warn_slowpath=
_null+ 0x1c/0x24)
>> [<c003e15c>] (warn_slowpath_null) from [<c04dfc1c>] (clk_disable+0x2=
4/0x30)
>> [<c04dfc1c>] (clk_disable) from [<c0024ea0>] (_disable_clocks+0x18/0=
x68)
>> [<c0024ea0>] (_disable_clocks) from [<c0026410>] (_idle+0x15c/0x240)
>> [<c0026410>] (_idle) from [<c086fc48>] (_setup+0x174/0x22c)
>> [<c086fc48>] (_setup) from [<c002684c>] (omap_hwmod_for_each+0x30/0x=
5c)
>> [<c002684c>] (omap_hwmod_for_each) from [<c0870054>] (__omap_hwmod_s=
etup_all+0x30/0x40)
>> [<c0870054>] (__omap_hwmod_setup_all) from [<c00089e4>] (do_one_init=
call+0x80/0x1d8)
>> [<c00089e4>] (do_one_initcall) from [<c0862ea4>] (kernel_init_freeab=
le+0x1f4/0x2cc)
>> [<c0862ea4>] (kernel_init_freeable) from [<c05cf184>] (kernel_init+0=
x8/0xe4)
>> [<c05cf184>] (kernel_init) from [<c000e8e8>] (ret_from_fork+0x14/0x2=
c)
>> ---[ end trace f0d1b75165d8ef11 ]---
>> clock: dpll_abe_ck failed transition to 'locked'
>> clock: dpll_abe_ck failed transition to 'locked'
>> ...
>>
>> Tero & Tomi, can you please look into these clock issues above?
>=20
> FYI, looks like merging Mike's pending clk-next to current mainline
> somehow fixes the clock issues above. It seems the audio changes
> depended on changes in clk-next?

I'm not aware of any audio changes around here.
BTW: today's linux-next boots fine on Blaze with audio working.

>=20
> Regards,
>=20
> Tony
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
