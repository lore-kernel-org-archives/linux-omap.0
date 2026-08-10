Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE533F377;
	Mon, 10 Aug 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358926; cv=pass; b=eoKuj2I3RcVDs3eoz8yPlJHhceE0mFvAK89oh/OAm4DxlHvGzKxNRnW28K1JBVLjGQMv38GtY8TmmCoab7igxcvZ5I9r1t7lHsjGSmgocLToZhgRVxRk3x0r4dKw22qyWlMze9cZdvxawPcPhyxgUUsm03+PYz4RECxSnLJHxmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358926; c=relaxed/simple;
	bh=/+Lj5ZmB2Wj4J0ALCVryLcGBe7uwKxdF0BoFyEVf5Lw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SYNzJu55fzzkAdSTANZZtRNi+9hbPTlZ9GpROHrhrfK1oYN9nYBetAb5Nefc7t4UvduLjByPRBqfQT/gdAuPsCL9JIsWEB1PacLI12vG6LBGZqHkFt4rv+g9m83huVhSkIJ+AK5oj04YhcyskiePx9jhj40nMjmbbCK+rIZ4Oc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=k0vB1a3X; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=u0XFv4Ji; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="k0vB1a3X";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="u0XFv4Ji"
ARC-Seal: i=1; a=rsa-sha256; t=1786358730; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r95vgetHZxNU5/Q91bpahGuvUzNS6S2TBIeGd/QD0yKLV9sWOswllTVMy5nC/xI3Q3
    mzdOBafYfZKVUKizWCKYIVofrhglfSiMinenGSq59RRATfCpnsEZ7iwpreKyO+CiKYqx
    dxj2wpd2KTfklVzDwOeC9iOSezWzDxHy11ogy0eqAI7e1rJZ8kTZr4IyvYOGry3isGLa
    NZ8N2KI6c5ZfaLEOO5MtA0C8a2/GRCpqTlLQk7oXaPBpkMq70+wSc4O/9n41DwwD51iV
    PnmKY0WZtTDO3BsAu6IapkPO+4VsHJABSFgsxUSaCJ1euEO1W/MtpsFMgynQyMKeiFsA
    XOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786358730;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/+Lj5ZmB2Wj4J0ALCVryLcGBe7uwKxdF0BoFyEVf5Lw=;
    b=cZANkWRCwYlNVeyjB6NB4O0XANCgXcxaXuXBrybQg3WdB5qI4AIES4njNz55YNvgez
    ACgdGH3frpp11kDyAc/6G0vsP8E55Q8GAllXV6cE6mLtp/heESnOVFRw/QOlB/XyQI4g
    FWAC3lH7ZCkOPby3mnn6tzjcEjyqVp/O1IZsvhLUkve+m+Rc1EXva2eC7DSiDZCZDG3v
    jt1J2T9v62EDkhjTjlDEpevh1fWRnK1gzIdJPhnqZlCkaTTY0JSsAy6QKwCz12/8lRts
    R4sZz5WS3KwwIIkYSH2BQxH+pO5yxyhbrJNLkPlmwEDXaBQdyqfycVXsHlH4BjaY0ivX
    XQoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786358730;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/+Lj5ZmB2Wj4J0ALCVryLcGBe7uwKxdF0BoFyEVf5Lw=;
    b=k0vB1a3XGQa/vwzXHC/q+UZUBFPNUJqaHKDb1/QhVR06t596gAA2wEhFYOAjF8eH6r
    ceyWM4RenhaakWurc8GGAmIj0CzrCmAK3dMM8+ZVeJvAonbDhh9zlwI8e3I+dJp3pOOF
    NhQh0j5Xo5VW8t+LwtSdBR1LaPN2h3cyoJBZuz2DAajhfOIgWDdAvEsYfdtRjzjCY1Z+
    bIhRAX5J3Ld+TGk7B+sUMH6QDjtkRmVOp5b5LmLBWeLjKcNfFgNLFafC4yyjZasjlhPo
    Gh1JPRryhLmgpa3Na6SMI8BeccvKKYW0ttR3Z8PpWg8cgCtwXlx1KlAZ25APIdZ0JqSK
    Wdzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786358730;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/+Lj5ZmB2Wj4J0ALCVryLcGBe7uwKxdF0BoFyEVf5Lw=;
    b=u0XFv4Ji86X9gdHTYnWTfT1UnxYTAcLRqIwilIA9yK+Y/G0MHETjxnZElNPmRYKujj
    rQ4V4cAiyXvtdwQTN2Aw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrTipoGmsiNZ9v/oGyp26o/Wi+pVFrZX1Db5b3z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac27AAjRgVw
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 10 Aug 2026 12:45:27 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 15/16] backlight: remove pandora_bl
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <anmpiADsvzW39DNx@aspen.lan>
Date: Mon, 10 Aug 2026 12:45:16 +0200
Cc: Grond <grond66@riseup.net>,
 Stefan Leichter <sle85276@gmx.de>,
 Grazvydas Ignotas <notasas@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>,
 Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>,
 letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com,
 mfd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
 <anmpiADsvzW39DNx@aspen.lan>
To: Daniel Thompson <danielt@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Daniel,

> Am 10.08.2026 um 12:35 schrieb Daniel Thompson <danielt@kernel.org>:
>=20
> On Sat, Jul 11, 2026 at 08:02:02AM +0200, H. Nikolaus Schaller wrote:
>> Retire the platform specific pandora backlight driver since
>> it can now be replaced by twl_pm and device tree.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> Yay!
>=20
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Well, there were some good comments by Sahiko to the prerequisites of =
this patch,
because it has one speciality the PWM BL driver does not handle (avoid
interpretation of PWM signals as W1 protocol).

I haven't found time to work on this, so we can't remove this yet.

In the end it may either remain a pandora_bl driver (converted to DT)
or become a patch for something else.

BR,
Nikolaus=
