Received: from mail-qv2-f6.google.com (mail-qv2-f6.google.com [74.125.230.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C836308F
	for <linux-omap@vger.kernel.org>; Sat, 12 Sep 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185580; cv=pass; b=UFqYkFpHfEtnd5IPSPBkmZAnsA6jaCATQ8nVFfD5gFa7+xH7hFI7ilXeIkBIdIaGZ+p9Zs6d7REyv2pYBbC9DnRnRyJAiAaOrDF5sFsezVP1+nH5JwbZffo1NYbj4DYG10zvvQof1d0JFAvxbPuQCL43sV5lebA0sR+z4+aOwpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185580; c=relaxed/simple;
	bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj8dNAHRR50SZa4mER0K/cYTJfTM2GBVcpnSKSEt4q6qtJK1ev6VMzG90GFIaMABl2g2Gi1PtAzqvS26lxflZbyatbVj/lqdfBaL1uO75OXsoW0jm5cDgS/DdDCk3dPXy8OXik/phqhBKOtJZ2oQN8/1Y4MF2iHB9NEYi6obQuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUi99WX2; arc=pass smtp.client-ip=74.125.230.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUi99WX2"
Received: by mail-qv2-f6.google.com with SMTP id 6a1803df08f44-90cd0a3019eso6292136d6.0
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 20:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789185577; cv=none;
        d=google.com; s=arc-20260327;
        b=cVw03DHfSWmOE09JwhNuqbhGHDNsb2uyyw2PIJTRBBDQdR6+ban//M77a+1wRGmxWV
         VUk549Eyud7Ck1724gHCvF22bWFiZ8jGBJuATwilkuUgOdJKhjOfixGTvR3KS8Iik9zV
         xqt7aGnyqNeG8AUDcc4EuKAmncGZo8iTJTRxuE6vZyOhJCNi29MuR4D8F9u1e9Mq5Ljg
         0W6bj1PnhZ/xNkf8W0GFfDmFjKZzrmdoy0X1IjQNGi+dFTow6gJfY284k1wMkyuqKzhA
         2vzJ1QXRy4EzFBQ/lJJNy/o3G3e0gQEFtbI8zsRdKm5uLV/B9HkP2Bibk1I2JSr25SNp
         8kJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        fh=Sl/KiE+ithuSkvJJYMQ8zbmHukyjDL6rPJomYUFwA08=;
        b=jvXiRyEA4XY6mZt5+/5WDmXajIlALHWEOkCAWciF8CIWiO2arygdKSTETQ56zYMkeQ
         nBdBaa3OpiCzfzfJ2dY1R3j/CVuFbWGAYm9OYYTN5M+w8O+aPpSlCLHAWoWB5gVZHM9o
         7AePs3djT3R0QM2aCvYsldneOq2yDht5ZdLPbRyaoVHcGkopzrE2PyJoke0eDjQJZp7B
         Ef2GoHFfXfXH2mey1u9pvMdgsnqC4oIu8TPikWl7Yt9GQ4ArINeaiZ7jDmAz9C3U7L0b
         rPd87D+GnUtOhtH6ERL3Ks81uv+7ll+wUZD9th4Do3iUA3fLc+86VCJCotPuajtJgW3I
         +pOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185577; x=1789790377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=AUi99WX2mjCEnh94Mgz8UyqQU/oNEA9cIEKZBdzKT+z8ihWUMzk831dQkI3koNvu9G
         FOXv9hL+LCMEPxf/E6B6X3tqNMNit0enH6a996hZjF9P1W9Ca9u/JogjBROhVSBVKuKe
         i1ZglNYBRcPU+heleoHDLB4sNQG/UeUlV3ciG1mn4mte93xJ1PyBBaGWQo9SW/MmOyUE
         E2GuwCGaztMXULuWO9e3gDAe+xNSNVCpMSpRBjuIJOXYQi9Lt395uXUGN7PpUrH06Wk6
         hST40P8ADAOoVPLsm4F0dumn5utDUM8S2/msBC6ownOQBTLYS6vL4zC5VkaFucosXqdX
         tFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185577; x=1789790377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=rNtKnaFbOtQFEUlA9TsSWkEa65mBHYuW6dSbXvHiPDLm9I6+kI8oDfjqH1CtwyhvMB
         bscyZ112xyno5wg3vSJxdueLERG2CLi+AhGi1Z7oKGbvIZ+jlvD+LUWhAHEnMqfYBn/w
         /R9w3+63VvtFZmCufyODmwuBYAyFG5G7CDl5gc+4rS5f39HbUnuZ2ZDG1J9kK7HY4NUF
         ezC6hXuMkZmw9AVk6VZI9deYp2MNEQOzf5YbGNnUw1NxZuHxRclnN8RBkk+hbYmxPUvS
         j5UoMHg89xvND6/s6glfiAPAC43Mojsc2ngCRAfAJrY+otO9UY4lEHPUoy//3nk53IGN
         0y7A==
X-Forwarded-Encrypted: i=1; AKwUvBxEWN8kjW7p+Whmq/ngrCTRustcAe4DrqrQA2gVIP5dOaCqbAc5SxPGi1PG/JgiBNCYoTOMp0kobJTS@vger.kernel.org
X-Gm-Message-State: AFuF++lsYE3p9JN/+bW/x0L6hZH+bKsDtvAz4zCM5C+uCt/N7RORNUNE
	g2t4a7lV6gnMHo1wmN6AQeI7R980YGrtyBy27DwKXGiuwtjCw7o+A2A+jvCSN1kewB0ybcd+5Ey
	GOdS3rNDDVTb70f8w2pZCqt2f2amBfkM=
X-Gm-Gg: AYBFou3K/Lcltetvra0js95unfx4Jr7Mly36j3DNLN25pDg9eyWrp6IJOoEoWty1O89
	+1Ar9ZecfNHs7JwcIdGhPhQupka2FnSsORvn0NBuHvv7+qXCh+hqrDfdKPw8jZe1BdvCkxe6pBw
	utcUJ480jMsJZIryIIgTTNt5dDyyVK6X1wb5tnB+eDq7i7nNYfzUOFLETqmBlMOAtQc1T/Qebx5
	SNaUHOSO32Lh+Y9pYKx9J9tyR2yQOlSR5C0ptuWK/4IOFasgB2YE1ntU4uTzUxdT3Y2ZEIMQ0zM
	yi0e0nTArNGVQRNFHxawTpaowlPYb+J5Of1aIEVu9KAjfbtheOB+99NrV3bADv6m71NZiQdXEaC
	iF6vcsI3WeVwP9VTZWrKswSMwlBHLkOjBOlNiztir
X-Received: by 2002:a05:6214:8446:b0:912:15a8:bd9f with SMTP id
 6a1803df08f44-91215a8ec1dmr55956796d6.7.1789185576987; Fri, 11 Sep 2026
 20:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <aqRI3N5FPX1dpIlk@gmail.com> <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
In-Reply-To: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 20:59:26 -0700
X-Gm-Features: AcwNN1VfZ_rXL-z6In5wMRJEgOMU7kPx8LknulegWooIebA5av8sYgSMw6by5S0
Message-ID: <CADkSEUhpe5sX=C5NfUrFMoP9fOGNiFaJ5QmEAVJ=80p8H8S9HQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Karl,

On Fri, Sep 11, 2026 at 7:08=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The Risc PC and NetWinder lost their audio drivers when OSS was
> removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
> working on an ALSA driver for the NetWinder but never finished it
> (IIRC it is in 2.6.0-rmk2 but probably doesn't work).

I just remembered someone wrote an ALSA driver that works on the ISA
card version of the WaveArtist, which would probably be easy to get to
work on the NetWinder:
https://lore.kernel.org/all/1440445816-28593-1-git-send-email-linux@rainbow=
-software.org/

Ethan
