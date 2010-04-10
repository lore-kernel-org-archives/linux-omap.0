From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP35xx Boot failure
Date: Sat, 10 Apr 2010 20:59:50 +0300
Message-ID: <20100410175949.GA2183@gandalf>
References: <274F7B50569A1B4C9D7BCAB17A9C7BE102216BC8@mailguy3.skynet.nuvation.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47987 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0DJR7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Apr 2010 13:59:13 -0400
Content-Disposition: inline
In-Reply-To: <274F7B50569A1B4C9D7BCAB17A9C7BE102216BC8@mailguy3.skynet.nuvation.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jerry Johns <Jerry.Johns@nuvation.com>
Cc: linux-omap@vger.kernel.org

Hi,

first of all, please read http://elinux.org/Netiquette

On Fri, Apr 09, 2010 at 08:33:20AM -0700, Jerry Johns wrote:
> Hello all, =A0=A0=A0 I've got a custom OMAP3503 board with 256Mbytes =
of
> LPDDR memory (single die, x32-bit) that i've got working with x-loade=
r
> and u- boot. However, when i load the Linux kernel (2.6.32 git), it
> randomly produces the=A0following errors:=A0
>=20
> 1) Hangs midway through the "Uncompressing Linux ...." stage, and
> this=A0is arbitrary and random on different attempts=A0 2) If it ever=
 does
> go through, it sometimes displays "invalid=A0compressed format (err =3D
> 2)" or "crc error", "incomplete literal tree" and says "System
> halted"=A0 3) If i disable caching in the kernel (in
> arch/arm/boot/compressed.S,=A0line 233 "bl cache_on"), it at least
> completes the Uncompressing stage=A0fine and proceeds to print ".....=
=2E.
> done, booting the kernel.", at=A0which point it does not boot (most
> likely since i disabled the=A0caching)=A0 4) If i reset the board (no=
t
> power-cycle) after the board hang above,=A0and do a crc32 check on th=
e
> kernel image in DDR memory (this is=A0 possible since DDR2 memory
> contents do not get changed after a soft-=A0reset), it matches the CR=
C32
> that i have calculated manually on the=A0 kernel image. This shows th=
at
> the main kernel image (from which it is uncompressed) is still
> intact.=A0

could it be memory timings ??

One thing you might wanna do is enable CONFIG_DEBUG_LL and
CONFIG_EARLY_PRINTK and append "debug earlyprintk" to your CMDLINE this
might give your more information about the problem.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
