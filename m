From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP: TWL4030: Sound broken in 3.1
Date: Fri, 04 Nov 2011 17:28:45 +0200
Message-ID: <6555903.9RbRJEkmHF@barack>
References: <WC20111104151805.630235@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47167 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755201Ab1KDP2v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Nov 2011 11:28:51 -0400
Received: by mail-fx0-f41.google.com with SMTP id f16so3602267faa.0
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 08:28:50 -0700 (PDT)
In-Reply-To: <WC20111104151805.630235@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org

On Friday 04 November 2011 15:18:05 Joe Woodward wrote:
> In 3.1 sound support is broken for any boards using a TWL4030-based C=
ODEC.
>=20
> The Kconfig option for the TWL4030 CODEC used to be TWL4030_CODEC, an=
d in
> 3.1 this has been changed to MFD_TWL4030_AUDIO.
>=20
> I believe this has caused a problem in drives/mfd/twl-core.c:112 as t=
he
> define for the twl_has_codec() macro still tests for CONFIG_TWL4030_C=
ODEC.
> Hence the macro always returns false and during boot I get:
>=20
> [    2.417999] ALSA device list:
> [    2.421142]   No soundcards found.
>=20
> Is this likely to be the problem?

See Jarkko's patch:
https://lkml.org/lkml/2011/10/19/125

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
