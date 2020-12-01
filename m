Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BDC8300F
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37E62151B
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jpaNAzFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgLATXO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:23:14 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:33217 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgLATXO (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2020 14:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606850362;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IAQ8yIuH8zTYK7jwHyUCVO1UbUqSS3sf2HPGaHX9LYk=;
        b=jpaNAzFLPQ1WHCB6VYbONz6kFarmDJE0K9THd84OEF5JHwE0qbitQilKcvB2ed/Xlz
        qpTUujeYkdZks1vEX/v9jy6mffcGd8ItP7GSWk4q9N0kbXVthjW/scBCD4aOQIDx97y+
        9mNuz7T3B+X56s61gZ0dhU9ghWonKjftqSNzcBpBPcvZxmtCTS9uGwwxaJe9mCXEqIJm
        8gPW9vhSt2e/86s2V1n9PgC04TBWZncuoTP6aSEW6l+x1ewi0wMTNKTljFUyJpp9oYP6
        GM7W7a/umcNaoQeVjQApXz5YvcEAoT47lQU2c8rLg/jhNPpgO9msCkERQFZrcTb2Ti5w
        Ywyg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDuo6A=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawB1JJ6VuQ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 20:19:06 +0100 (CET)
Subject: Re: [PATCH] ARM: omap2plus_defconfig: enable SPI GPIO
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20201201191237.15808-1-andreas@kemnade.info>
Date:   Tue, 1 Dec 2020 20:19:14 +0100
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <826AB7B5-E860-40D4-8E33-08F9FF820A98@goldelico.com>
References: <20201201191237.15808-1-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


> Am 01.12.2020 um 20:12 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> GTA04 uses that for controlling the td028ttec1 panel. So
> for easier testing/bisecting it is useful to have it
> enabled in the defconfig.

++

>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> arch/arm/configs/omap2plus_defconfig | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig =
b/arch/arm/configs/omap2plus_defconfig
> index 77716f500813..904a8757ad9f 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -280,6 +280,7 @@ CONFIG_SERIAL_OMAP_CONSOLE=3Dy
> CONFIG_SERIAL_DEV_BUS=3Dy
> CONFIG_I2C_CHARDEV=3Dy
> CONFIG_SPI=3Dy
> +CONFIG_SPI_GPIO=3Dm
> CONFIG_SPI_OMAP24XX=3Dy
> CONFIG_SPI_TI_QSPI=3Dm
> CONFIG_HSI=3Dm
> --=20
> 2.20.1
>=20

