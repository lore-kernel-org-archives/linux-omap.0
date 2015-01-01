From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Thu, 1 Jan 2015 20:20:54 +0200
Message-ID: <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
References: <54A58E23.5080103@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:42260 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbAASVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jan 2015 13:21:04 -0500
Content-Disposition: inline
In-Reply-To: <54A58E23.5080103@gmx.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Jan 01, 2015 at 07:12:51PM +0100, Peter K=FCmmel wrote:
> When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
> I see a "In-band ERROR" warning which wasn't present in 3.18.1.
> Could it be that I missed some DT updates?

> [    0.366882] In-band Error seen by MPU  at address 0
> [    0.366912] ------------[ cut here ]------------
> [    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:16=
6 omap3_l3_app_irq+0x100/0x134()

This appears also on N900/N950/N9...

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
