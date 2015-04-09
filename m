From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Thu, 9 Apr 2015 21:50:13 +0300
Message-ID: <5526C9E5.4070601@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com> <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com> <20150409151846.GR18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52799 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932841AbbDISyA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 14:54:00 -0400
In-Reply-To: <20150409151846.GR18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com

On 04/09/2015 06:18 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 02:37]:
>> The sDMA requests are routed through the DMA crossbar and without th=
e
>> crossbar only peripherals using DMA request 0-127 can be used.
>=20
> I assume this can be merged separately from the driver
> changes?

Unfortunately not. We need to have the drivers in place for the DTS cha=
nges to
work.

>=20
> Otherwise we'll have the same kind of "flag day" mess with
> the IRQ crossbar..
>=20
> Regards,
>=20
> Tony
> =20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
