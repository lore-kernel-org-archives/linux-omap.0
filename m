From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 3/3] omap3 nand : use NAND_BUSWIDTH_AUTO
Date: Tue, 6 Nov 2012 17:47:18 +0100
Message-ID: <50993F16.8070908@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1352199105-30215-3-git-send-email-matthieu.castet@parrot.com> <50990473.2090300@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:46302 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab2KFQrY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 11:47:24 -0500
In-Reply-To: <50990473.2090300@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

Igor Grinberg a =E9crit :
> Cc: Tony Lindgren, Afzal Mohammed,
>=20
> On 11/06/12 12:51, Matthieu CASTET wrote:
>> This allow to clean the omap nand driver that were trying in x8 and =
x16 bits mode.
>>
>> This also make work onfi detection on beagleboard :
>>
>> Before :
>> [    1.954803] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Mi=
cron NAND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64
>>
>> After :
>> [    1.914825] ONFI param page 0 valid
>> [    1.919158] ONFI flash detected
>> [    1.922515] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Mi=
cron MT29F2G16ABD), page size: 2048, OOB size: 64
>>
>> platform data devsize is renamed bussize. It now indicate the maximu=
n size of the nand bus.
>>
>> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>=20
> I think, you should base on one of Tony's branches with that kind of =
patches.
> Because, for example the omap_nand_flash_init() function does not exi=
st anymore
> in Tony's master and may be several more things will need to have adj=
ustments.
> Also, the GPMC related stuff inside the NAND driver
> should probably be coordinated with Afzal, as he is reworking the who=
le
> GPMC related code.

Thanks for the info.

Where such tree could be found ?


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
