From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: AM3517 boot failure
Date: Tue, 08 May 2012 17:24:12 +0100
Message-ID: <yw1xr4uu3akz.fsf@unicorn.mansr.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	<4F8FC572.80406@compulab.co.il>
	<alpine.DEB.2.00.1205072349540.9984@utopia.booyaka.com>
	<87pqaesrx0.fsf@ti.com>
	<alpine.DEB.2.00.1205080946570.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:55531 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2EHQYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:24:14 -0400
In-Reply-To: <alpine.DEB.2.00.1205080946570.9984@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 8 May 2012 09:49:26 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> thanks for the suggestion,
>
> On Tue, 8 May 2012, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>>=20
>> > On Thu, 19 Apr 2012, Igor Grinberg wrote:
>> >
>> >> IMO this can be seen on any AM35xx based board with EMAC, or am I=
 mistaken?
>> >
>> > Just tested this on a 3517EVM and the same problem is there too.
>>=20
>> Does adding nohlt on the cmdline make a difference?
>>=20
>> The AM35x has known wakeup limitations, and nohlt would at least avo=
id
>> WFI to see if it's the wakeup problems that are the root cause here.
>
> Adding 'nohlt' allows it to go a little farther in the boot, but stil=
l=20
> hangs.  Log below.
>
> (Without 'nohlt', it hangs right after "calling  ip_auto_config+0x0/0=
xf70=20
> @ 1")
>
> - Paul
>
> [    6.250946] calling  net_secret_init+0x0/0x1c @ 1
> [    6.255981] initcall net_secret_init+0x0/0x1c returned 0 after 119=
=20
> usecs
> [    6.263092] calling  tcp_congestion_default+0x0/0xc @ 1
> [    6.268646] initcall tcp_congestion_default+0x0/0xc returned 0 aft=
er 29=20
> usecs
> [    6.276184] calling  ip_auto_config+0x0/0xf70 @ 1
> [    6.325500] mmc0: new high speed SDHC card at address b368
> [    6.334686] mmcblk0: mmc0:b368 USD   3.75 GiB=20
> [    6.347686]  mmcblk0: p1 p2 p3
> [   18.374359] initcall ip_auto_config+0x0/0xf70 returned -19 after=20
> 11809741 use
> cs
> [   18.382141] calling  initialize_hashrnd+0x0/0x1c @ 1
> [   18.387420] initcall initialize_hashrnd+0x0/0x1c returned 0 after =
59=20
> usecs
> [   18.397949] async_waiting @ 1
> [   18.401184] async_continuing @ 1 after 119 usec
> (hangs)

Are you still trying nfsroot?  Since ip_auto_config failed, it will hav=
e
no way of mounting the nfsroot and stop there.  Do you know why ip setu=
p
failed?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
