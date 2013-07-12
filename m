From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Fri, 12 Jul 2013 11:09:51 +0200
Message-ID: <51DFC7DF.7050806@ti.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk> <20130706133627.GV21614@n2100.arm.linux.org.uk> <20130708093410.GT5523@atomide.com> <20130708142103.GX21614@n2100.arm.linux.org.uk> <20130709082304.GB5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47912 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757211Ab3GLJK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 05:10:29 -0400
In-Reply-To: <20130709082304.GB5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 07/09/2013 10:23 AM, Tony Lindgren wrote:
>> ASoC looks dead too:
>>
>> omap-abe-twl6040 sound.10: ASoC: CPU DAI (null) not registered
>> omap-abe-twl6040 sound.10: snd_soc_register_card() failed: -517
>=20
> Peter, I think you've had audio working with devicetree for at least
> a year or something?

Yes it has been working and going to work soon again:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/063909.h=
tml

With the DMA devicetree bindings platform_get_resource_byname() stopped
working for DMA (it works for MEM resources) -> dai drivers were not pr=
obing.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
