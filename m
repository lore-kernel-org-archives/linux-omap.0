From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Sat, 26 Nov 2011 19:07:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com> <4EC6566C.70202@ti.com> <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1897424294-1322359657=:6289"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49435 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab1K0CHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Nov 2011 21:07:38 -0500
In-Reply-To: <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1897424294-1322359657=:6289
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 26 Nov 2011, Paul Walmsley wrote:

> Hi Beno=EEt,
>=20
> a question about this patch.

=2E..

> > +=09=09.name=09=09=3D "mipi_stm",
> > +=09=09.pa_start=09=3D 0x54161000,
> > +=09=09.pa_end=09=09=3D 0x54161fff,
> > +=09=09.flags=09=09=3D ADDR_TYPE_RT

> ... none of the address spaces above have the ADDR_TYPE_RT flag set.
> Without this flag set, the hwmod code won't know where to access the OCP=
=20
> registers.

Ugh, it's above; I just missed it.  Sorry about that.

So just out of curiosity, do those SYSCONFIG registers in the STM address=
=20
space apply to the entire DEBUGSS, or just the STM IP block?


- Paul
--155748971-1897424294-1322359657=:6289--
