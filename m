From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 16:04:42 +0100
Message-ID: <yw1x8vhrsqyd.fsf@unicorn.mansr.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	<4F8FC572.80406@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:35984 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2DSP2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 11:28:11 -0400
In-Reply-To: <4F8FC572.80406@compulab.co.il> (Igor Grinberg's message of "Thu,
	19 Apr 2012 10:57:38 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> On 04/19/12 05:07, Paul Walmsley wrote:
>>=20
>> Hi,
>>=20
>> just wanted to mention this on the list to see if anyone else was se=
eing=20
>> it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot, an=
d the=20
>> boot hangs.  Here are the last few lines when booting with=20
>> initcall_debug:
>>=20
>> [    7.069885] initcall scsi_complete_async_scans+0x0/0x10c returned=
 0 after 29 usecs
>> [    7.077880] calling  gpio_keys_init+0x0/0xc @ 1
>> [    7.084167] initcall gpio_keys_init+0x0/0xc returned 0 after 1400=
 usecs
>> [    7.091278] calling  rtc_hctosys+0x0/0x110 @ 1
>> [    7.096038] /home/paul/linux/drivers/rtc/hctosys.c: unable to ope=
n rtc device (rtc0)
>> [    7.104217] initcall rtc_hctosys+0x0/0x110 returned -19 after 798=
7 usecs
>> [    7.111297] calling  net_secret_init+0x0/0x1c @ 1
>> [    7.116333] initcall net_secret_init+0x0/0x1c returned 0 after 11=
9 usecs
>> [    7.123443] calling  tcp_congestion_default+0x0/0xc @ 1
>> [    7.128997] initcall tcp_congestion_default+0x0/0xc returned 0 af=
ter 0 usecs
>> [    7.136444] calling  ip_auto_config+0x0/0xf70 @ 1
>>=20
>> Is anyone else seeing this?
>
> I've tried various configurations and can confirm this hang.
> I still haven't got my hands on bisecting this.
> There is nothing special about CM-T3517,
> IMO this can be seen on any AM35xx based board with EMAC, or am I mis=
taken?
> Anyway, can anybody try nfsroot on other AM35xx based board with EMAC
> supported?

I did a little digging...

=46irstly, only the am3571evm board registers the davinci_emac platform
device.  On a Craneboard or a CM-T3517 there will simply be no network
device for IP autoconfig to use (unless you magically have DT working).

Secondly, the clock configuration for davinci_emac on am35xx is broken.
omap3xxx_clk_init() registers two clocks for dev_id "davinci_emac", one
with con_id "emac_clk", one with "phy_clk".  When davinci_emac_probe()
then does a clk_get(dev, NULL), this fails since there is no matching
con_id.  Likewise for davinci_mdio_probe().

With a little hacking, I got the platform device registered and the
clocks matching as (I think) they should.  It now detects the correct
PHY, so that's something.

However, the IP config is still getting stuck.  For reasons I don't
know, the msleep(1) call in ic_open_devs() never returns.

That's as far as I got.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
