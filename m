Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F1246BCD
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098288; cv=pass; b=MsCaaznv0FEGQsDAqS1rWh0D3pEwAWqrVSnvKnhuaM7nybH0y74aXMoYbk2AZUdTLJwZDnpcw7L9bLOFJtCZwZzJluczmWv0SZdPqwAByCbOq0G80+BqKC9nNxMciyEKrQC45aVGjOp6Bm/4rCguNYOxhX/uyOZB6rzYl7sVSXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098288; c=relaxed/simple;
	bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbFX36SfTi/z7uQmLWT9Av3Xb2O/hEhJpum8yGQIRtPLRmuoVXoDHoWHOB0gEJXleUobAl/NOb8OGVHzMHWWF61++5nSjKsS1BPOD0HgwCz9BuSTBLtcXvaXQaMjVqtyhg26yc3ZaASlYlu5XdpR+j51gHLCoinCVl6Kp2k8vdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2V24x4G; arc=pass smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2V24x4G"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-51bfca7f85aso3859931cf.0
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2026 20:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789098286; cv=none;
        d=google.com; s=arc-20260327;
        b=L2TVAcSWw0rQcMGbQZxcY9Ox3FfIALf97p4787VEdtp2wGZKOgxI8ObMMg/7dipbN+
         VFU20/CVHtOoYbBCNCOBRBEijjR2IPNXKvZ2K5encmGKW9ebhJ6ZrUU+OvBFVblzQ4yb
         9KNNMuiysTUu+4ZjJIFfjDmKfHyDqg4XOp4jHS1F3DWjN0yNuLb5DZGQZPMdD0sP83l/
         l9+hm5LSYm/u0vAuP/HKV4BLiWOhpWbhweyGQwACnae/fsHsDEprXFmR5G0mB4HVEPSz
         wkK+/cEGpkU1La+HJszq19MRcxAB78ecfnxFECUTQjyHtUW5wX8vJdUYhEcmz2jMHwl8
         jcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        fh=q/HjJHbNF30Nt++DHQhqwvLArIZU3pz4fzi3x3kz+z8=;
        b=mkB9YphbSeYI9OkcinN+r93o01dl7dDCF8uiwD4+0mSjhCBZxbggWFqcZ79rYEZ7+L
         l6oN8LGrZPtwwHGN70tlS1rcz8n62g5WxD9IkTqL8fNBe4rit3g+IbAHflcxZtd1LS3I
         JJe0HGwJI2fci/You3jf/1NfkMt53J5NWSxb8W/erdf7A8Gi59wZg+sF5Cdibyr1oPoN
         g13xORpoo7mHN3BHA2SlxdPPyBrHhXh0/2jPdhtPxUJBsMODnnoV7TDlxne6thvciD0q
         3T4eVjBwR+L9DQX1DfQelPLUi6fLrl4OLl8jzLkPOwZY3agTQbXOZoNfoR0P+MgF3pyK
         FpQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098286; x=1789703086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=G2V24x4GGyCwAd8LaJ2X8PGNbql6wdGj7itobGHv+DWtilwCENd20LNJWE0FPLHB3/
         0AjlkwMCGqs9CTmfIsOad/o7305l5dxeD1ZFHVPrHnNcoEDHmmOEkUoLBmMXN0uGF9mA
         NFt62u0bdoESjLGcIpLtJ0v7+FmJRxrD/o1lT5g+LldSZZhD3Og4hV+mUCCZhqbjd2JS
         rECTuLTUzPCSAjku7N+dnRXlt7UYkl6EGUg9xcf0TT9TiheCSHMZR1kposahxXE8JxLQ
         5XMF89T6zDhqWdtlqtNhZhEm9Fss7ApuSwbHeeM2sCdkBm+3v8htMXW4iBX0va4HMp+v
         aDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098286; x=1789703086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=i8HAkemIPMUxRtJQYYhsW0kbiNSm2+ugy8Jp12k/Eh+K3OkEe1Msmu8vSugE64O5WZ
         q2ny+hrcb3H2QneLWPQvRcdIIF16x06KwXMde0cuRktZW3KpK76rR4uykGlcaHzaDKNU
         Gie6SGzIZvjoLgKwXk88Ww2RBuARVDEqFDmKuZy/XcSgTfVRe5nUxpDnGarYd5LXKmx+
         U1ocME9KtPFCFghVTJZ4e6F6zuJc+a9Yqlbg0CDrs0BShGnxt+kZK0HnueqfmjRlwCMs
         6srGMuH/Ufa/55R/b6VEAWkUH0kd65ZMS4RqNAQbzGa4+Y4+MC1guUOQbve55PZtHoCk
         dnPg==
X-Forwarded-Encrypted: i=1; AKwUvBzlDFaKMc3f66yFjEKqgvr7BLFNT9ne0TsQK9sMym7xkuaWat/aEBOAF52doljwug6C6dY7L18hP3eH@vger.kernel.org
X-Gm-Message-State: AFuF++njQYxMsa2Hyil3dYNyUfynsGKnQz49A8M6/m1IIdWePJ0KGVkl
	h61KM4BmzGDV1MgnYkjJsS1wvyEeBcunNPv7gG3ZoNtmO+edL0Ukur+37LR8bzXG0G12UDYTe3a
	dJxlJrE0mpYaBB0Avm6gKnD/E4a3EPqs=
X-Gm-Gg: AYBFou0+9JIJxB0SkbTQP7X7KFZnhC0Wg6NYG+C+F20hvOgahWrTAjUvaU52U2hyqVI
	swZhDq9vABW/J/NW+e4hebqytL6O8xPXqIdMPN8f6XHeJLXb4uZJ3zKcUELgBMnTGpmehrFT5Dt
	i9DwppT5P2TmH+wVpLDKwXuIjuMk26CZc2q/izc4T+sIMUui2Wy2jNdUKqzedJ6d475mWQsXSf4
	WG2EVEJQwA/7LgEwzIdYs994k9fm5zGlD1KGuT35ZH9ZhwJEPPzI4rb9G3NvYJuxfLzU1ZqW92+
	DsTRa33I21NIm8qmVwDEvd4bkLkfKVHZKm9UmCaFAwdVO4GU2FbPJWn6PUzBpBQXhcbht9FX/oN
	wx9NYlgr73dkSMNb0cNc+Iayx0sjBKZPJyKGdS3gn
X-Received: by 2002:a05:622a:5987:b0:52d:918b:92e1 with SMTP id
 d75a77b69052e-530c84f326bmr40390581cf.5.1789098285727; Thu, 10 Sep 2026
 20:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-4-arnd@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 10 Sep 2026 20:44:34 -0700
X-Gm-Features: AcwNN1V1fOC0jmd_i5r-nVHD_ZWN_P0KCiZNA7MUoO0nuGcjQ9okMtkGALkOIWk
Message-ID: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, everyone,

On Tue, Sep 8, 2026 at 8:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> The main limitation here is the CPU bus that does not allow 16-bit
> wide data transfers and hence requires the kernel to be built with the
> -march=3Darmv3 compiler option that was discontinued in gcc-9.
>
> As gcc-8 is barely supported for compiling the kernel, this one
> will not see another LTS kernel release, so remove it now.

Because I think it's cool that the kernel still supports actual Acorn
hardware, I patched gcc 16.2 to restore ARMv3m support:
https://github.com/EthanNelson-Moore/gcc-arm-retro

This ended up being surprisingly straightforward - only a couple
hundred lines changed - and it would be even fewer lines had I not
reverted a commit that adds a use of ldrh instead of fixing it.

It is able to compile a kernel successfully (once you update the GCC
version check to check for -march=3Darmv3m support instead - I can send
my patch). I haven't tested it, but I am fairly confident that it
would run, because the assembler will reject code the compiler
generates with unsupported instructions - this is how I found the
commit I needed to revert.

I am working on a clocksource driver, which uses both timers (to
hopefully fix the awful time drift), and removes the dependency on
LEGACY_TIMER_TICK.

I also have patches for several cleanups to Risc PC-related code.

I am aware that this has no actual use case, but it was fun. No LLM
was used for any part of the work.

Ethan
