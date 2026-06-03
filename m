Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375F306757;
	Wed,  3 Jun 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504044; cv=pass; b=mlCldpsl8JFSnx4qdnWolozs5TG+1GkXRHP8YoGw4CkUK5SDLy73fvc63J8cX4Cw0zZs1CISQwWAtq39CmGTkm1nCVSUS2WpSbBvn9Tc63Pp9Cp2+ozoKgaanr2Ua2nV7xxYYQD1EuSiIHkZVbvaqqv37iHADIf0JcVyL82o5Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504044; c=relaxed/simple;
	bh=KhbvD2teloxYJOE0Kr50QjCliTHzHkkB8FT2g49rG5A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lT5ObT9SOSdlLjg4uSyYTKmNwehwnEx+PNKl9xkiGprg4VKwDn6WDFsiGtXZd+CEBFPgeHJr55dvTTKNbenYVqBtm8aSAbgo89VMqzgxMvwUEge0oZsKEjnW+FaIKtn7Pti1tK595TW4R0ERYxpHCFw+YLXY7q4GvoE93RLouqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=NY1P1nV+; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=+psRif6p; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="NY1P1nV+";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="+psRif6p"
ARC-Seal: i=1; a=rsa-sha256; t=1780504023; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gg/YW5bS50p898WW11BfwR81nEm8HV846w7rURzrJAzy1LCDaLOVViOAYzeQt59VM4
    MSM1hPIZak+JyuyFRbeqzMB2PdpslWXmUXAY346Caq3vQscuXt4EQSDlzNgkorJ8+8jR
    URbSoREZKRVjd7AaopYehDI9hktqSCpWv+doyMbMHUiOLL07BZMsfzCtDnO/n6M2tf3Z
    FhVgEGh28jQMMgsVGRE0n/dyFw4o/Re1lp7WXHHfWJ7zGFZUxHoQijTK4423FYa/yRDy
    CNskV0FIkyWHrHJQ/aBOLNQJ8PAIqP42Ld20CMu4mNb7KpPTpe5SJH8s8sBNudIZe3yH
    PavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780504023;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7d+8oWhndjRXJUx9RttSpm6H9eK+ZZIqer3yqlanXs4=;
    b=ABsxRYU4/19qJm6II717cF+HAIrf8q9/DTIMxpu81lH3ZSK7XGlm31gmv8X78/TaK3
    y9KwEwCiKffKTp/CkwAdZxypFI9JLw12ad9rUqSVL/8K9+NsyyksjO/o3mlKmT+Xi1pJ
    Vx9VBu6pXpGClgS19JnPj20f2AQMb6POOm/rKs7/FPL68kpfmW9sONP9U00CEzgOIbhr
    lBn25rvia/VWUrpj5/u1brGeQHYLqKApFDm1TdC4zud/I23llyCn3qRqnPXS3l2JdQjo
    5VjN1OJ2VWaltz28/u65yjVOB9roLgW7cqqVPTz+JiLN3X13Ru0cmbpB6lazr9rpXFaK
    Iq0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780504023;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7d+8oWhndjRXJUx9RttSpm6H9eK+ZZIqer3yqlanXs4=;
    b=NY1P1nV+xeaqwIGwctbcSommvkKVE3ZgKiw95ohyNX2RT4CvlLS8Qu6wcP5BiH3sdo
    wbx/OcrwJPEu7ww3gKHqfVcsuLHPgl6zqebd4oLiVKqCPCi+3h5k8PgHT6SRA4iuhBvH
    Zaieyk5/mNW19Kg9Lkd0FYqRZqqBUEPm9XgnXKLiUsvor0eDJ9jvPllwQBoUK0YSOLpE
    XdE7FZquRF7Xg1+DoBfKm/eif+tShpCXy7NUESk0IdnCd2kW5SMij48BsGywLwwjzi+r
    putBebrneHQBD3Cpvg9w7Q0cqNVPElDCwNCBhdGQxuxAi4/7e0k2GTkTjIPvtA8kTR7j
    shZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780504023;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=7d+8oWhndjRXJUx9RttSpm6H9eK+ZZIqer3yqlanXs4=;
    b=+psRif6p+1qLEHnwqvxv491LwPOE/rZZnGF09pjGqV6vhr68S5y+8UzQkvPcGvDvDr
    zsRi9WgaTiZFakXPf0AA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV0ZpcmsiNHPcN2XAK/x0AmUoQtfhpadx7ORPy"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Qcf97c253GR2jGY
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 18:27:02 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.6\))
Subject: Re: [PATCH 2/4] ASoC: ti: omap3pandora: remove
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260603160021.11cfae7c@kemnade.info>
Date: Wed, 3 Jun 2026 18:26:52 +0200
Cc: grond66@riseup.net,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Stefan Leichter <sle85276@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52C0E6AF-7162-4FF8-ADE7-E5BF42551237@goldelico.com>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
 <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
 <20260603160021.11cfae7c@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>,
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.6)



> Am 03.06.2026 um 16:00 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 03 Jun 2026 14:09:23 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
>=20
>> The omap3pandora driver entirely depends on =
machine_is_omap3_pandora().
>> Pandora has been converted to device tree:
>>=20
>> 7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for =
Pandora")

11 years ago :)

>>=20
>> Since then machine_is_omap3_pandora() always expands to 0. Remove the
>> long unused driver.
>>=20
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> sound/soc/ti/Kconfig        |   9 --
>> sound/soc/ti/Makefile       |   2 -
>> sound/soc/ti/omap3pandora.c | 290 =
--------------------------------------------
>> 3 files changed, 301 deletions(-)
>>=20
> On the first glance, this looks ok... but
> I know there was work undergone in converting this to devicetree but =
it
> appeared not upstream.

Thanks for spotting (before we would have been surprised).

>=20
> So
> Grond, hns: What are your plans in this? You are effectively =
maintaining this
> out-of-mainline. What are your upstreaming plans?
>=20
> Do we need this kind of glue anyway? Or can we use some of the
> audio-graph-card stuff instead to wire up things?

Tony also had mentioned something like this in [1].

I have checked the status of the LetuxOS kernel [2]:

There are patches for the device tree (a simple one without audio =
graphs) and patches
for sound/soc/ti/omap3pandora.c and adding a TI PCM1773 driver.

Main contributors were Grond and Stefan Leichter.

The main work is a patch by Grond: "ASoC: omap3pandora: Rewrite sound =
card driver as a platform driver".
This heavily modifies sound/soc/ti/omap3pandora.c including removal of =
machine_is_omap3_pandora()
but keeps sound/soc/ti/Kconfig & Makefile as is.
And he added "ASoC: pcm1773-codec: write a driver for the PCM1773 chip =
from TI".

So to summarize: the upstream code is the basis for a patch series from =
2020-2023.=20
I regularily rebased and fixed upstream API changes but it was never =
posted and there
was no specific plan to do that due to lack of manpower...

Nevertheless, if people are interested, I can consolidate and tidy up =
this (mainly
the API updates) into a series (approx. 10 to 20 commits) and post as =
RFC over the next weeks.
Note that this series also affects the TWL4030 REGEN and the =
twl4030-codec.

And there is a revert for some pandora related omap2/pdata-quirks [3].
BTW: there is also a special Pandora backlight driver which asks for =
cleanup.

Final observation: we build this with CONFIG_SND_SOC_OMAP3_PANDORA=3Dm =
and this is also defined
in upstream omap2plus_defconfig [4].

My proposal: keep sound/soc/ti/omap3pandora.c at least while the RFC is =
discussed.
This will eventually remove machine_is_omap3_pandora().

BR,
Nikolaus

[1] https://marc.info/?l=3Dalsa-devel&m=3D165632351319716&w=3D2
[2] =
https://github.com/goldelico/letux-kernel/commits/letux/sound-soc-v3/
[3] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/configs/omap2plus_defconfig?h=3Dv7.1-rc6#n532
[4] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/mach-omap2/pdata-quirks.c#n271

