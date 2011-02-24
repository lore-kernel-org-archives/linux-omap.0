From: =?UTF-8?Q?Radek_=28Mrkva=29_Pila=C5=99?= <mrkva@mrkva.eu>
Subject: Re: [PATCH 1/2] OMAP3 Touchbook: Fix MMC caps
Date: Thu, 24 Feb 2011 21:09:00 +0100
Message-ID: <99a50271913b424eb17354f8b058c8dc@localhost>
References: <44de2f4c8b17d38df1d25b7236223247@localhost>
 <20110224193441.GF20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mrkva.eu ([83.167.228.102]:45897 "EHLO mrkva.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690Ab1BXUJC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 15:09:02 -0500
In-Reply-To: <20110224193441.GF20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Well, MMC_CAP_8BIT data is definetely wrong - according to schematics,
there are only D0-D3 (+CLK and CMD) lines connected. I'm going to test =
4
BIT and let you know.

On Thu, 24 Feb 2011 11:34:42 -0800, Tony Lindgren <tony@atomide.com>
wrote:
> * Radek (Mrkva) Pila=C5=99 <mrkva@mrkva.eu> [110224 10:02]:
>> MMC controller cannot handle MMC_CAP_4_BIT_DATA nor
>> MMC_CAP_8_BIT_DATA - the card won't be detected (tested with two
>> SDHC cards, both Class6). Thus disabling.
>=20
> Hmm it might be worth checking that the MMC data lines are muxed
> correctly. Maybe make sure CONFIG_OMAP_MUX_DEBUG is set in
> your .config and CONFIG_DEBUG_FS too. Then boot and and mount
> debugfs with mount -tdebugfs debugfs /sys/kernel/debug.
> Then you can do:
>=20
> # grep -i mmc1 /sys/kernel/debug/omap_mux/* | grep dat
>=20
> And check the settings. Changing the values could cause data
> corruption, so use a temporary root file system!
>=20
> Tony
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
