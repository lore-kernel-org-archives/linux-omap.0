Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C93612E2
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2026 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354268; cv=none; b=hvoGguAaP3aPiMCLO58cIoWEoWK7zJmOYsI1XEX75n8I4vYnJFL7lZL14I8sl4X3AS2JfRlbXraGRLLelPiRRMswf1tMEmYhvdbacMONNUkLrK7Xz2T5BP3BTS+oPFNpGEI4DUvNLE0T5QeuuLcohrH556xX4pp3P9SegV8yRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354268; c=relaxed/simple;
	bh=TKLGSf3GBjMP36BA0MEdaSC8c160hy43LOrQEKAZGHA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh60n7czKTCj9Z4uRbtaTHKovh7ITFUNOK703PAb1NVNxn2U1HQO/Mgql5BwiKnTbHWEGrmhUgImxkyENUomRHJERcwlb0gjjLvmo02ZUW7LdQJCDxrnijr8QAzXK5YHfElt6AoScahTzXUUhz9yihIYJGuuCVGtXJstyXJeY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKQomMCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKQomMCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7001F01572
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2026 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779354266;
	bh=TKLGSf3GBjMP36BA0MEdaSC8c160hy43LOrQEKAZGHA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=eKQomMCRdagq0CrKNNAbWd+5SdT7HxEZk8SS5c8YukUkxYbmsHDNc/MTCkRogOOAR
	 Pt90hL1Y+9+RT+N3XxUqrqLtC8PCPudBhj3TVnarBl21Gv9NEoCrtJ8+d5Jb/WMAeC
	 ML0j7DPXCMlI6VpU6g8SKFHinb03aCauKOqSAnYd6mmg/ByxqHRUMCYHVZSLCbjYjR
	 Jqr3WTarjbmTW+joe5Y++iCVDIgMGOqSp9V1U1/HCam6x7pvdtNk1FCRJOo8Tkv7FQ
	 FOLySF45LYKr6CJSo7I6TQ3iC18Zx5azfFzHqJN/J5myRPJSuw9bweC9nSI3U1A2dq
	 WJy66QWmIaooQ==
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-135e88b8e55so6396948c88.0
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2026 02:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8uzgwlm15FcvyhYkzdVlnzIVPM0B8PijT+aaYWlTqAnSw2slZnm3yswhKDYG2+PnSttyg2re0XNK4Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJUjTIdGT5kuOi1SAXu5c5OavU/vdv2Vf58BX0ZmOQ/Kf1+8h
	8A7v10DemgRY9jhgcaZdLXtn06BbBTg4tzJ9jIGxsNB285NgJWUbzq6fS6iJlDW+wXGqN8CgE+6
	hnBtLInDc6T7pGmTUN0mNORYpbLVmDdi2Gj/zvM6EZQ==
X-Received: by 2002:a05:7022:ec88:b0:134:a731:e778 with SMTP id
 a92af1059eb24-13632f6adf6mr920006c88.39.1779354265385; Thu, 21 May 2026
 02:04:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:04:21 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:04:21 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260520183815.2510387-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520183815.2510387-1-arnd@kernel.org> <20260520183815.2510387-8-arnd@kernel.org>
Date: Thu, 21 May 2026 02:04:21 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mebt+hpSBfpsnHh1+SKt9b1cRBNge5WSoRrsfX1BBFgtA@mail.gmail.com>
X-Gm-Features: AVHnY4LWqhGtTeBYvpB-D8gN85zif4ar2-h8NZZ1yCLGF3pH11futzwzVDKQXSE
Message-ID: <CAMRc=Mebt+hpSBfpsnHh1+SKt9b1cRBNge5WSoRrsfX1BBFgtA@mail.gmail.com>
Subject: Re: [PATCH 07/10] [v6 net-next] dt-bindings: net: add
 st,stlc4560/p54spi binding
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Lamparter <chunkeey@googlemail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	netdev@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 20:38:12 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The SPI version of Prism54 was sold under a couple of different
> names and supported by the Linux p54spi driver, but there was
> never a DT binding for it.
>
> Document the four known names of this device and the properties
> that are sufficient for its use on the Nokia N8x0 tablet.
>
> As I don't have this hardware or documentation for it, this is
> purely based on existing usage in the driver.
>
> Link: https://lore.kernel.org/all/e8dc9acb-6f85-e0a9-a145-d101ca6da201@gmail.com/
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
