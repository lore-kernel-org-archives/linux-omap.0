From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: N900 v3.19-rc5 errors
Date: Mon, 26 Jan 2015 00:40:39 +0200
Message-ID: <20150125224039.GB5048@fuloong-minipc.musicnaut.iki.fi>
References: <201501231415.56922@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:51803 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbAYWkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 17:40:47 -0500
Content-Disposition: inline
In-Reply-To: <201501231415.56922@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

On Fri, Jan 23, 2015 at 02:15:56PM +0100, Pali Roh=E1r wrote:
> I'm getting these two errors when booting DT linux v3.19-rc5 in n900 =
qemu:
>=20
> [    0.309234] device-tree: Duplicate name in onenand@0,0, renamed to=
 "#1"
> [    0.309417] device-tree: Duplicate name in onenand@0,0, renamed to=
 "#2"
> [    0.309844] device-tree: Duplicate name in ethernet@gpmc, renamed =
to "#1"
> [    0.309967] device-tree: Duplicate name in ethernet@gpmc, renamed =
to "#2"
>=20
> [    0.730743] ------------[ cut here ]------------
> [    0.731018] WARNING: CPU: 0 PID: 31 at drivers/memory/omap-gpmc.c:=
1757=20
> gpmc_probe_generic_child+0x128/0x24c()

I don't see these on real HW.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
