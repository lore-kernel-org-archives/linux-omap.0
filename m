From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 4/7] [RFC] OMAP: hwmod implementation for MCBSP
Date: Wed, 6 Oct 2010 11:42:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CF132F2@dbde02.ent.ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
 <1286296662-7639-4-git-send-email-kishon@ti.com>
 <201010060901.59829.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758534Ab0JFGMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 02:12:44 -0400
In-Reply-To: <201010060901.59829.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

=20

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]=20
> Sent: Wednesday, October 06, 2010 11:32 AM
> To: ABRAHAM, KISHON VIJAY
> Cc: linux-omap@vger.kernel.org; Kamat, Nishant; Varadarajan,=20
> Charulatha; Datta, Shubhrajyoti; Basak, Partha
> Subject: Re: [PATCH 4/7] [RFC] OMAP: hwmod implementation for MCBSP
>=20
> On Tuesday 05 October 2010 19:37:39 ext Kishon Vijay Abraham I wrote:
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Cc: Partha Basak <p-basak2@ti.com>
> > ---
> >  arch/arm/mach-omap2/mcbsp.c             |  251
> > +++++++++----------------------=20
> arch/arm/plat-omap/include/plat/mcbsp.h |=20
> >   6 +-
> >  arch/arm/plat-omap/mcbsp.c              |  189=20
> +++++++++++-------------
> >  3 files changed, 159 insertions(+), 287 deletions(-)
>=20
> So the plan is to kill OMAP1 support in McBSP (audio)?=20
> We do have OMAP1 users, so IMHO dropping OMAP1 is not acceptable.

This patch series would not break OMAP1 as they do not touch
the omap_mcbsp_register_board_cfg() in mach-omap1.

Usage of hwmod is applicable only for OMAP2plus cpus and it modifies
the way in which the platform device is built & registered. It makes
use of centralised database to fetch the addresses, irq, dma info etc.,
for OMAP2plus. OMAP1 cpus will still continue to have the old way of
doing platform device registeration.

pm_runtime APIs are already inplace to take care of enabling clocks in
case of OMAP1.

Hope this clarifies.

>=20
> --=20
> P=E9ter
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
