Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D443D75D5
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879729; cv=none; b=bg9oDxJXVTVwI5KrE6yWvkTd+RkGDpV7GP9BBMIV1uo0jLc1gCYFy/TFVKxw2p5MXp4LKHlt3trxR0FWF16ciGraBAxcuWRXSuV9HECVyGS2rOXne+ZPhf02bwwaGqFTokk2LdpZ4lMXrCYrMBoOpRZgZTJryhIKIH8iBpYzENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879729; c=relaxed/simple;
	bh=UBMvKa6530vLa0XbCReC9z5oa2AyiAgd7zjDJyxTv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHqd/s+int8rO+1AWCF+i/T9N6jh2KIdUEy/6AA2jCGcN+mcOi6O+SywbJD7BL9NoxtFfP8EWCmWaypTz5fmxUBiSAQO4txp6n/U5CFkzCBmy0yTOP1SYfYFDXgIbqtK9iTFLb6LmmIKv7ghH46wskEXD6tq99XNTNN0KDu0Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuP7Z1Ks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuP7Z1Ks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61560C2BCB8
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774879729;
	bh=UBMvKa6530vLa0XbCReC9z5oa2AyiAgd7zjDJyxTv74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uuP7Z1KsMgAA6tSsPe2Z5q0aw+WmtfZ+YM3g7RqLtOGZbCjBUCFDGPXKx1sZgMUTW
	 5Bv24X1+9iOsLr8H5S0AxGPl5YVOjUUerA2gE4NkPS6v+P8//CqoiKR3akGiuY/9nn
	 lfPWH9fALC2uJtMI7+dGs+kcW4lLy1bGguXutCbJffPStgYy71J8RZrhVBGFGPQ/D5
	 F22RwOEq+Vly6dJixo51icP4mdgf9gnXn3g/rAQ04jobWUTbFQ8h/DfIOkctYqrTt/
	 clayt7zBzx5tFb6Osuqcdlzia+Eccuc4WB2rwJE9J9TxMCXDdnVPdarIcRLwkCgrRr
	 pd1UrbPCRMpEw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38ad26e3992so34968401fa.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 07:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJybGhzuc4osbpYfBJU7kbUQ8qCogfxvw8VitnoQ5CBssz0s2rJQYWTrLvm6JdUe8c6Yj0GQXZK5Aw@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUWmdEaOBBjuz7ez15I38F0YJI7cgrFzLFmPBU5wrBRUlp66U
	MGuRVaYRP4ID5PJuMZiovWZoQjV3GXlvQ9l0uRX3RbbEmIMbZgsLwJsgk0S6yOB8+9eJLFTp5Ad
	abZmLA3aktf987+VGUGOf4IkApAT098+7jLbB0YGzVg==
X-Received: by 2002:a2e:a548:0:b0:38a:43eb:239e with SMTP id
 38308e7fff4ca-38c73192b65mr45193471fa.13.1774879728025; Mon, 30 Mar 2026
 07:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <DHG5OX85I4LL.39U0RRBS0JXFP@kernel.org> <CAMRc=MfG1ZF=4T2WAw71Zb+4BFD2_4VSNRQZQsoGLE8gZxWcHg@mail.gmail.com>
In-Reply-To: <CAMRc=MfG1ZF=4T2WAw71Zb+4BFD2_4VSNRQZQsoGLE8gZxWcHg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 30 Mar 2026 16:08:35 +0200
X-Gmail-Original-Message-ID: <CAMRc=Md4gD+9Rkg9MSe0OiYw-bS53nMAarFq_MZZHEq=yxYwVQ@mail.gmail.com>
X-Gm-Features: AQROBzCZ3sn6YhqN7BcNEXBcWbVXRGN722aFgaQTZcIuW6VGsXjtEbj0I4HGOcQ
Message-ID: <CAMRc=Md4gD+9Rkg9MSe0OiYw-bS53nMAarFq_MZZHEq=yxYwVQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
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

On Mon, Mar 30, 2026 at 3:52=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Mon, Mar 30, 2026 at 3:37=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
> >
> > On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
> > > Bartosz Golaszewski (3):
> > >       kernel: ksysfs: initialize kernel_kobj earlier
> > >       driver core: make software nodes available earlier
> > >       ARM: omap1: enable real software node lookup of GPIOs on Nokia =
770
> >
> > Looks good to me overall (one minor nit in the first patch); which tree=
 should
> > this go through?
>
> If the first two patches can make v7.1 then I'm fine with postponing
> patch 3 until v7.2. Maybe Dmitry's changes allowing passing
> unregistered software nodes to new platform devices (where are we with
> this?) would also make it in and patch 3/3 could be smaller as a
> result.
>

In other words: patches 1 and 2 can go though the driver core tree
into v7.1 and patch 3/3 will be respun next cycle.

Bart
