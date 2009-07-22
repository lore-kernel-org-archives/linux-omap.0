From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: cleanup for
 PROC_FlushMemory/PROC_InvalidateMemory
Date: Wed, 22 Jul 2009 17:01:37 +0300 (EEST)
Message-ID: <20090722.170137.112602411.Hiroshi.DOYU@nokia.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<94a0d4530907220652y4330fb5du81d40957d4e271c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44066 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbZGVOBo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 10:01:44 -0400
In-Reply-To: <94a0d4530907220652y4330fb5du81d40957d4e271c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, ameya.palande@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, h-kanigeri2@ti.com

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: cleanup for PROC_FlushMemory/PROC_I=
nvalidateMemory
Date: Wed, 22 Jul 2009 15:52:47 +0200

> On Wed, Jul 22, 2009 at 11:22 AM, Hiroshi DOYU<Hiroshi.DOYU@nokia.com=
> wrote:
> > Both functions are almost same structure except its flag passed to
> > MEM_FlushCache().
> >
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> > =A0drivers/dsp/bridge/rmgr/proc.c | =A0 82 ++++++++++++++++++------=
---------------
> > =A01 files changed, 38 insertions(+), 44 deletions(-)
>=20
> > + =A0 =A0 =A0 enum DSP_FLUSHTYPE mtype =3D PROC_WRITEBACK_INVALIDAT=
E_MEM;
> > +
> > + =A0 =A0 =A0 return proc_memory_sync(hProcessor, pMpuAddr, ulSize,=
 ulFlags, mtype);
> > +}
>=20
> What's wrong with sending the type directly?
> return proc_memory_sync(hProcessor, pMpuAddr, ulSize, ulFlags,
> PROC_WRITEBACK_INVALIDATE_MEM);

Just I took the readability rather than a wrapping line because of 80 c=
olumns.

>=20
> > + =A0 =A0 =A0 enum DSP_FLUSHTYPE mtype =3D PROC_INVALIDATE_MEM;
> > +
> > + =A0 =A0 =A0 return proc_memory_sync(hProcessor, pMpuAddr, ulSize,=
 0, mtype);
> > =A0}
>=20
> ditto
>=20
> And while we are at it, why only PROC_WRITEBACK_INVALIDATE_MEM and
> PROC_INVALIDATE_MEM? How shall user-space issue a call for
> PROC_WRITEBACK_MEM?

Comparing the performance benefit with that may not be a bad idea.

>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
