Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E51352C28;
	Wed,  3 Jun 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508732; cv=pass; b=csHXYKANaRi8B1lILUn44TAjQYj3JE3jll/F3IUBnUNAGfNG5sJkqwN+PhtJ/Vlgxu/4XMbNTdVN8nWtUfhyNBM7E0A6GWzjslriCzu6ZlNryP4ERcUPfPae8wHLMEdS57fQbbKW2Y4ldyVDDQUSyrl4Ru+rY2bVOGaqa9gaEWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508732; c=relaxed/simple;
	bh=mTFaaXRNISXRL42EdpRyzXJ6mljBOe4odrtxJ+8Pnps=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ad/00awLc92HrWB3MpxSlDNKanr2IcQdHXKnDldZ+iUIg3eS2Ej6KoxPAHpJzzOT/TWTMW0hTxqRQrIzuC3PGCeiIe4GikegQ9LewJLF9Pu0WQ0Gpy9AO9TCvEf43OXoiKDfc+0hiLfqc43GQsGjeRlhxsFBbZ6kq9zdCT81J8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=ifguKrCw; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=GDguRXjU; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ifguKrCw";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GDguRXjU"
ARC-Seal: i=1; a=rsa-sha256; t=1780508536; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F66hKjeZTKXRJ5E/45fcI3DHKgUsIdMhNJH297NZbr2L3qgUw7pXDr1idS37URZE4J
    fwTzXoATy/9+crxNNPP7s1gDvyar9Td880uxYAXR3H8ZJXDmw9v+ks+ckU4sh19R0Vh0
    QWeQQ2RvVX+sJaQzjcrD0Nhaxt5QxbaftLedt+EJooui2TKaaDzuCzR5lPQ72w1ctrFN
    Ut1uhkldbKZUctW4n1wBK94+traen5ORvxWhFQNErLmKfWXYqTv1wzykhBM8oWvQsyli
    KNJn5GMPREFXCbXbRbnsAd8yMySPk+aK2wn67wJ2WMGXO/93V5pTRjokJq4pOirTyKIC
    4+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780508536;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Lpt9HXKUqKWP/M8K/0bx4rkluuEvlOpdinXMoaze9lo=;
    b=QbngrbUAbAdi22dMOKCqaXf/VV6Hq6BRJzTvddNwEAhum8kGxGJZ6qSMc7EikncE2W
    KrXCmcd4he01aoqJf8XoeW04qCsso4sYfDiLMErK5SozJxR0wjDQw6p2V5CI0fyuzxyB
    /3EJPWGY9wJ5R8fHV6ps/QOjoB4IAnjEEsgBy0POUdppnmyVgZSEIuLyGzTG3GkAsFgj
    gUa8P7JCnDMkZRjERg0pR7vbrQP8mdSAS7nTviNhCJ5ucewJN5q41EIAJdWVOaRsTsQk
    7msW3/MWfQ+hUXsTb8mROykFRX0e2nag7RFBLWcyDhNSjRGGLtsFPkUxYCES9MZ7huCj
    /ipg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780508536;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Lpt9HXKUqKWP/M8K/0bx4rkluuEvlOpdinXMoaze9lo=;
    b=ifguKrCw0rKtf40Se22nRFOBUpv3ihmcHExlgjAsYw4e8vBaGkpesahrTLsyOUWeHv
    p1pVXy1+0/ST9mUbmubRLO/tfqqB5YQQReWDFkE3+p8nEdWYDtxQJebXvG/lb+EfciiX
    uGBeDcMetkFcupj6m+XlRNXM2LT+667BbeZ0PQSsu0lxaATK8oqJgyak31/vm0GXC4Dr
    9FEOhNl+inCqU4XFFVutmyfgUFYBLHDHnLxoqc+XAnHFew9Y1TaJP9e6oMgkog6QpmZZ
    4hAyr/b8Z0wE++3zoOAA9naLi6+AMiDHg1FO4oASUVyktgbhgtENrnuY7V6GSBvsDjlA
    3SAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780508536;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Lpt9HXKUqKWP/M8K/0bx4rkluuEvlOpdinXMoaze9lo=;
    b=GDguRXjUakYYAYnfOuqZ3IiRdScQko3V7RLNgGOnN7HFCtRrq7vDo/7QqOZ3ionG2V
    Cbf651leJlyttWEG58CQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV0ZpcmsiNHPcN2XAK/x0AmUoQtfhpadx7ORPy"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Qcf97c253HgFjQE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 19:42:15 +0200 (CEST)
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
In-Reply-To: <20260603193307.0a27264d@kemnade.info>
Date: Wed, 3 Jun 2026 19:42:04 +0200
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 grond66@riseup.net,
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
 Stefan Leichter <sle85276@gmx.de>,
 s.kerkmann@pengutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B93B107-0AD8-45BD-A146-4BBD612769E7@goldelico.com>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
 <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
 <20260603160021.11cfae7c@kemnade.info>
 <52C0E6AF-7162-4FF8-ADE7-E5BF42551237@goldelico.com>
 <20260603193307.0a27264d@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81.1.6)



> Am 03.06.2026 um 19:33 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 3 Jun 2026 18:26:52 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>>> Am 03.06.2026 um 16:00 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>=20
>>> On Wed, 03 Jun 2026 14:09:23 +0200
>>> Sascha Hauer <s.hauer@pengutronix.de> wrote:
>>>=20
>>>> The omap3pandora driver entirely depends on =
machine_is_omap3_pandora().
>>>> Pandora has been converted to device tree:
>>>>=20
>>>> 7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for =
Pandora") =20
>>=20
>> 11 years ago :)
>>=20
>>>>=20
>>>> Since then machine_is_omap3_pandora() always expands to 0. Remove =
the
>>>> long unused driver.
>>>>=20
>>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>>> ---
>>>> sound/soc/ti/Kconfig        |   9 --
>>>> sound/soc/ti/Makefile       |   2 -
>>>> sound/soc/ti/omap3pandora.c | 290 =
--------------------------------------------
>>>> 3 files changed, 301 deletions(-)
>>>>=20
>>> On the first glance, this looks ok... but
>>> I know there was work undergone in converting this to devicetree but =
it
>>> appeared not upstream. =20
>>=20
>> Thanks for spotting (before we would have been surprised).
>>=20
>>>=20
>>> So
>>> Grond, hns: What are your plans in this? You are effectively =
maintaining this
>>> out-of-mainline. What are your upstreaming plans?
>>>=20
>>> Do we need this kind of glue anyway? Or can we use some of the
>>> audio-graph-card stuff instead to wire up things? =20
>>=20
>> Tony also had mentioned something like this in [1].
>>=20
>> I have checked the status of the LetuxOS kernel [2]:
>>=20
>> There are patches for the device tree (a simple one without audio =
graphs) and patches
>> for sound/soc/ti/omap3pandora.c and adding a TI PCM1773 driver.
>=20
> Just a quick glance:
>=20
> audio-graph-card2 seems to accept amplifiers.=20
> So probably it boils down to just remove this and
> add a compatible to ti,pcm1754.yaml and a devicetree patch to use
> audio-grapch-card2.

Sounds like a better solution if someone can draft it. Then I can help =
testing.
Then of course we can retire sound/soc/ti/omap3pandora.c.

> and maybe the regen stuff.

Yes, as far as I understand, this is required to make it work.

BR,
Nikolaus

