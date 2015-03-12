From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ti,codec property in sound/soc/omap/omap-twl4030.c not used
Date: Thu, 12 Mar 2015 11:19:06 +0200
Message-ID: <55015A0A.1060309@ti.com>
References: <CAAfyv34ebp1oL7t9GKT20_c4VYMM=3rfJTrj-MfT6NUBXk6d2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbCLJTa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2015 05:19:30 -0400
In-Reply-To: <CAAfyv34ebp1oL7t9GKT20_c4VYMM=3rfJTrj-MfT6NUBXk6d2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>, jarkko.nikula@bitmer.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

On 03/12/2015 12:12 AM, Belisko Marek wrote:
> Hi,
>=20
> I'm looking at sources for omap-twl4030.c driver which is used by man=
y
> boards. In DT bindings documentation is property ti,codec described a=
s
> mandatory but it's never parsed in driver code. I did small experimen=
t
> in gta04 board and remove ti,codec from devicetree and sound was
> working. I think it can be removed from documentation and also from
> various device trees. Is my assumption correct? Thanks.

Correct. The ti,twl4030-audio is for the MFD driver and the device for =
the
ASoC codec is created in there w/o actual DT compatible string. The aud=
io part
of the twl4030 is responsible for the audio and the vibra functionality=
=2E

Are you going to send the patches?

Thanks,
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
