Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEA3D5643
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148029; cv=none; b=O0hNUDoEv6B2Ejwd816dgGsrS+brDHLy5Y4k9jEdEZ6AVgfR3W1AieNahC7oOhdJ1wnsmsJ01KA8Y9FosFWrDp7tPSp5EwvL0DJKRK79IneJ+h+Uz85GWSSkfci+d+3lsPBuTL89R4d9chTZGCmXsDUB8e6OB4rYZ6z3nrJavKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148029; c=relaxed/simple;
	bh=PHhMkTf2PU2A/KjRZXugaP//8msg3BdPHebsYhl2y/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4ZHlemAEIbekj73sZr4iHAM//PXU1n/Mh57icAoTEwZ9BW5YIBYDfGucvGv+UObmWj7pa9fY6dg+52VDijo4yIf6GJnnuPfizLf6lwhnu9npBMtISmb3tgBRN02LS7tqHnqP6X7C2hev1QT2mFaLQJjhSViYo3x73LWZSAuSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF6kwc+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF6kwc+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F075CC19423
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775148028;
	bh=PHhMkTf2PU2A/KjRZXugaP//8msg3BdPHebsYhl2y/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mF6kwc+p9V7x0nJpfO2bEhRtd30slN9Y2SwYnaMv2mYDLT5AXW5aUTpXTf/Kab68h
	 r1Ta022jhAlos8uBUmml3ML+JG5zvZKir5k9wK/PXnqkJ2ZOR1YX2fV1jNVeFb7en1
	 59TD747G2nHVZh4/aEyneAR2GddgjDEkvRpNn/blOeG2bkaUlpbwZiB+uFQxgH3Qrq
	 gSHi8Xl2FBa6EYaVPPlC/cpi8WGa8q7sHBU4DKEV67rRwnrcLG0EIl4tOeVl/z6pLp
	 zSNNrxU2Eja0UafZ8c+LAhasyw8Sogn/FgR5jOt9WSoVud79carFhBV5aL1DQHqZby
	 DgbH4z4P8M8Yw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so1283714e87.2
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 09:40:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeFWOnMAkrVPGu/zEUpqUeJqlKcIDIJlrLaxUoo3G8b8uoi+OdSJpA0BIRASY7wRkLcRqT1R9ko8Xk@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIV+zdJYic3tRsMnpP+xROMLhJoGl7G2U8RYlIPc0U/somlLE
	cX2QQwOU6Pjvv4KYv3ZW3N5n7/qIsbiZSTX9HOocIDB7sqs36Q884cSy/PoEDaVr/2tBXI0VpIt
	pz7QzXZQdmHoHmu7+QsaBE6Wqh0Fj5871ItX9yj3mTA==
X-Received: by 2002:a05:6512:3d0f:b0:5a2:ad98:366f with SMTP id
 2adb3069b0e04-5a2c1f195c1mr2697582e87.20.1775148026537; Thu, 02 Apr 2026
 09:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-1-d730db3dd299@oss.qualcomm.com> <DHITFGL3J4IE.2WZU3K2CSYL7I@kernel.org>
In-Reply-To: <DHITFGL3J4IE.2WZU3K2CSYL7I@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 2 Apr 2026 18:40:13 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfAet449-uH9P-wz1FMLbsmNGCwtwWLRh7=RBrO+v3p-g@mail.gmail.com>
X-Gm-Features: AQROBzAduHOivprlKvhzUpkoRpQrf9dg2jV6hNu93i72s7Oqo9MWAkjXkw22YpE
Message-ID: <CAMRc=MfAet449-uH9P-wz1FMLbsmNGCwtwWLRh7=RBrO+v3p-g@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] kernel: ksysfs: initialize kernel_kobj earlier
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:39=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu Apr 2, 2026 at 4:15 PM CEST, Bartosz Golaszewski wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0f258aeeacba184d2025b932d90280cf2aabf4b0..8bc934162e712cf8ddf033e=
53bf3481054cfb7fe 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7843,6 +7843,7 @@ F:      include/linux/debugfs.h
> >  F:   include/linux/device.h
> >  F:   include/linux/fwnode.h
> >  F:   include/linux/kobj*
> > +F:   include/linux/ksysfs.h
>
> Currently, kernel/ksysfs.c is not listed in the driver core entry (it is =
not in
> any entry), but I guess that would make sense.
>
> So, we should probably also add kernel/ksysfs.c. :) But this can be a sep=
arate
> patch independent of this series.

Ok, I take it no need to resend this?

Bart
