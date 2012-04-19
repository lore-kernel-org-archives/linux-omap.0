From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 18:52:35 +0100
Message-ID: <yw1xobqnr4m4.fsf@unicorn.mansr.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	<4F8FC572.80406@compulab.co.il> <yw1x8vhrsqyd.fsf@unicorn.mansr.com>
	<20120419165312.GW21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:40094 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2DSRwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 13:52:37 -0400
In-Reply-To: <20120419165312.GW21106@atomide.com> (Tony Lindgren's message of
	"Thu, 19 Apr 2012 09:53:13 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * M=E5ns Rullg=E5rd <mans@mansr.com> [120419 08:31]:
>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>=20
>> > On 04/19/12 05:07, Paul Walmsley wrote:
>> >>=20
>> >> Hi,
>> >>=20
>> >> just wanted to mention this on the list to see if anyone else was=
 seeing=20
>> >> it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot,=
 and the=20
>> >> boot hangs.  Here are the last few lines when booting with=20
>> >> initcall_debug:
>> >>=20
>> >> [    7.069885] initcall scsi_complete_async_scans+0x0/0x10c retur=
ned 0 after 29 usecs
>> >> [    7.077880] calling  gpio_keys_init+0x0/0xc @ 1
>> >> [    7.084167] initcall gpio_keys_init+0x0/0xc returned 0 after 1=
400 usecs
>> >> [    7.091278] calling  rtc_hctosys+0x0/0x110 @ 1
>> >> [    7.096038] /home/paul/linux/drivers/rtc/hctosys.c: unable to =
open rtc device (rtc0)
>> >> [    7.104217] initcall rtc_hctosys+0x0/0x110 returned -19 after =
7987 usecs
>> >> [    7.111297] calling  net_secret_init+0x0/0x1c @ 1
>> >> [    7.116333] initcall net_secret_init+0x0/0x1c returned 0 after=
 119 usecs
>> >> [    7.123443] calling  tcp_congestion_default+0x0/0xc @ 1
>> >> [    7.128997] initcall tcp_congestion_default+0x0/0xc returned 0=
 after 0 usecs
>> >> [    7.136444] calling  ip_auto_config+0x0/0xf70 @ 1
>> >>=20
>> >> Is anyone else seeing this?
>> >
>> > I've tried various configurations and can confirm this hang.
>> > I still haven't got my hands on bisecting this.
>> > There is nothing special about CM-T3517,
>> > IMO this can be seen on any AM35xx based board with EMAC, or am I =
mistaken?
>> > Anyway, can anybody try nfsroot on other AM35xx based board with E=
MAC
>> > supported?
>>=20
>> I did a little digging...
>>=20
>> Firstly, only the am3571evm board registers the davinci_emac platfor=
m
>> device.  On a Craneboard or a CM-T3517 there will simply be no netwo=
rk
>> device for IP autoconfig to use (unless you magically have DT workin=
g).
>>=20
>> Secondly, the clock configuration for davinci_emac on am35xx is brok=
en.
>> omap3xxx_clk_init() registers two clocks for dev_id "davinci_emac", =
one
>> with con_id "emac_clk", one with "phy_clk".  When davinci_emac_probe=
()
>> then does a clk_get(dev, NULL), this fails since there is no matchin=
g
>> con_id.  Likewise for davinci_mdio_probe().

This clock problem was recently fixed in the linux-omap tree.  I should
have made sure my tree was fully up to date before poking around.

>> With a little hacking, I got the platform device registered and the
>> clocks matching as (I think) they should.  It now detects the correc=
t
>> PHY, so that's something.
>>=20
>> However, the IP config is still getting stuck.  For reasons I don't
>> know, the msleep(1) call in ic_open_devs() never returns.
>>=20
>> That's as far as I got.
>
> Just to check, is this with the bad muxing removed in fixes branch? W=
ithout
> that there can be all kinds of weird issues if some uart pins are use=
d for
> non-uart functionality:
>
> bce492c0 (ARM: OMAP2+: UART: Fix incorrect population of default uart=
 pads)?

Same problem on linux-omap master.

If I simply drop the msleep() calls (and use CONFIG_PREEMPT), it
progresses a bit further.  With a static IP config provided,
ip_auto_config() returns and it hangs somewhere else.  With ip=3Ddhcp i=
t
sends out a DHCP request but gets stuck waiting for the reply.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
