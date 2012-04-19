From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
Date: Thu, 19 Apr 2012 03:49:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204190346350.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053651.16278.22844.stgit@dusk> <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com> <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com> <4F8FCB4A.3080805@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1562160966-1334828945=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53533 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2DSJtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 05:49:06 -0400
In-Reply-To: <4F8FCB4A.3080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1562160966-1334828945=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Thu, 19 Apr 2012, Cousson, Benoit wrote:

> On 4/19/2012 10:17 AM, Paul Walmsley wrote:
>=20
> >   static int __init omap_hwmod_setup_all(void)
> >   {
> > -=09int r;
> > -
> > -=09if (!mpu_oh) {
> > -=09=09pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet
> > registered\n",
> > -=09=09       __func__, MPU_INITIATOR_NAME);
> > -=09=09return -EINVAL;
> > -=09}
> > -
> > -=09r =3D omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
> > -
> > -=09r =3D omap_hwmod_for_each(_init_clocks, NULL);
> > -=09WARN(IS_ERR_VALUE(r),
> > -=09     "omap_hwmod: %s: _init_clocks failed\n", __func__);
> > +=09_ensure_mpu_hwmod_is_setup(NULL);
> >=20
> > +=09omap_hwmod_for_each(_init, NULL);
> >   =09omap_hwmod_for_each(_setup, NULL);
>=20
> Does it make sense to iterate twice? Cannot we just iterate over a _init =
+
> _setup single call?

It's a good idea but I don't think we can do that until we add the code to=
=20
walk the hwmod data in dependency order.  The DSS custom reset function=20
accesses registers in another hwmod, which won't have its clocks=20
initialized yet if _init() and setup() are combined.


- Paul
--155748971-1562160966-1334828945=:29048--
