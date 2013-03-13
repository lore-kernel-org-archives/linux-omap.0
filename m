From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby
 for musb
Date: Wed, 13 Mar 2013 10:14:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303131013270.32131@utopia.booyaka.com>
References: <1363031340-9382-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-998023820-1363169662=:32131"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40361 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506Ab3CMKOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 06:14:23 -0400
In-Reply-To: <1363031340-9382-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-998023820-1363169662=:32131
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Gra=B8vydas,

On Mon, 11 Mar 2013, Grazvydas Ignotas wrote:

> For some unknown reason, allowing hwmod to control MIDLEMODE causes
> core_pwrdm to not hit idle states for musb in DM3730 at least.
> I've verified that setting any MIDLEMODE value other than "force
> standby" before enabling the device causes subsequent suspend
> attempts to fail with core_pwrdm not entering idle states, even
> if the driver is unloaded and "force standby" is restored before
> suspend attempt. To recover from this, soft reset can be used, but
> that's not suitable solution for suspend.
>=20
> Keeping the register set at force standby (reset value) makes it work
> and device still functions properly, as musb has driver-controlled
> OTG_FORCESTDBY register that controls MSTANDBY signal.
> Note that TI PSP kernels also have similar workarounds.
>=20
> This patch also fixes HWMOD_SWSUP_MSTANDBY documentation to match the
> actual flag name.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks for the good patch description and for making those changes. =20
Queued for v3.9-rc.

- Paul
--843723315-998023820-1363169662=:32131--
