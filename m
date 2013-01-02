From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Wed, 2 Jan 2013 10:51:50 +0100
Message-ID: <50E40336.2080008@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:43055 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389Ab3ABJwC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 04:52:02 -0500
In-Reply-To: <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

Paul Walmsley a =E9crit :
> Hi
>=20
> On Mon, 3 Dec 2012, Artem Bityutskiy wrote:
>=20
>> On Tue, 2012-11-06 at 11:51 +0100, Matthieu CASTET wrote:
>>> - NAND_CMD_READID want an address that it is not scaled on x16 devi=
ce (it is always 0x20)
>>> - NAND_CMD_PARAM want 8 bits data
>>>
>>> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>> Pushed this one to l2-mtd.git, thanks!
>=20
> This patch (commit ff3206b2450499203532af2505a7f6f8413e92c0 in mainli=
ne)=20
> is causing warnings on OMAP3730 Beagle XM, OMAP3530 Beagle, and DM37x=
x EVM=20
> as of v3.8-rc1:
>=20
> [    1.349456] ------------[ cut here ]------------
> [    1.351959] WARNING: at drivers/mtd/nand/nand_base.c:2861 nand_sca=
n_ident+0xdb4/0xf90()
> [    1.356292] Modules linked in:
> [    1.357971] [<c001bf50>] (unwind_backtrace+0x0/0xf0) from [<c0045c=
ec>] (warn_slowpath_common+0x4c/0x64)
> [    1.363037] [<c0045cec>] (warn_slowpath_common+0x4c/0x64) from [<c=
0045d20>] (warn_slowpath_null+0x1c/0x24)
> [    1.368194] [<c0045d20>] (warn_slowpath_null+0x1c/0x24) from [<c03=
9d304>] (nand_scan_ident+0xdb4/0xf90)
> [    1.373229] [<c039d304>] (nand_scan_ident+0xdb4/0xf90) from [<c03a=
2448>] (omap_nand_probe+0x2e8/0x678)
> [    1.378234] [<c03a2448>] (omap_nand_probe+0x2e8/0x678) from [<c035=
7f84>] (platform_drv_probe+0x18/0x1c)
> [    1.383239] [<c0357f84>] (platform_drv_probe+0x18/0x1c) from [<c03=
56b84>] (driver_probe_device+0x84/0x224)
> [    1.388458] [<c0356b84>] (driver_probe_device+0x84/0x224) from [<c=
0356db8>] (__driver_attach+0x94/0x98)
> [    1.393493] [<c0356db8>] (__driver_attach+0x94/0x98) from [<c03553=
30>] (bus_for_each_dev+0x50/0x7c)
> [    1.398315] [<c0355330>] (bus_for_each_dev+0x50/0x7c) from [<c0356=
250>] (bus_add_driver+0xa0/0x2a0)
> [    1.403198] [<c0356250>] (bus_add_driver+0xa0/0x2a0) from [<c03572=
ec>] (driver_register+0x78/0x18c)
> [    1.408020] [<c03572ec>] (driver_register+0x78/0x18c) from [<c0008=
6a4>] (do_one_initcall+0x34/0x194)
> [    1.412933] [<c00086a4>] (do_one_initcall+0x34/0x194) from [<c0528=
188>] (kernel_init+0x154/0x2ec)
> [    1.417724] [<c0528188>] (kernel_init+0x154/0x2ec) from [<c0013d50=
>] (ret_from_fork+0x14/0x24)
> [    1.422454] ---[ end trace 7f5c9fb048cfa61e ]---
>=20
> The patch also looks bogus.  The patch states that "ONFI need to be p=
robed=20
> in 8 bits mode" (sic).  But if that's so, shouldn't=20
> nand_flash_detect_onfi()  just fail immediately, rather than warn?
>=20
I put a warning in order we fix drivers instead of a silent failure.

The omap driver was fixed in the same series with
http://article.gmane.org/gmane.linux.ports.arm.omap/88551 and
http://article.gmane.org/gmane.linux.ports.arm.omap/88549

=46or drivers that can't support ONFI, I don't know what to do.
May we should be replace the WARN_ON by a printk and early return.

Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
