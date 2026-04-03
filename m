Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89623D7E6
	for <linux-omap@vger.kernel.org>; Fri,  3 Apr 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201005; cv=none; b=udVoA20RjKvMzohJ2mJtla+oeu3mntpwF0avSogJcB27g71YBE6wiWoOLE0VOUgswfHQbE99QW2JsEVRMfD3e1Q6FQXGOzBs8nEr7j7fNVylnh8Qs9gjwY1BKjQ2P2nbC1WkULRP5OWgGu2njrj3KU1jMRFiat5EgTwtyHQCFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201005; c=relaxed/simple;
	bh=X5jJUvqRgah6D4xreZa2cicuZ87mzGtemSdNEwIyCE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5jHeByPpT/VtM+NEHDLOOi79zg81dIlYhSsZIzDh0U3vbcJVlMjDmJAha0JH0Yg67kymDEcubOJUYLeG3KLR7onKUwAwtVU45J1XG+j4u/sfQZ30ynNhqlfxlmP2pQd9tB5CFa+AiSvoGUYoUQ3YtD05Qf4do8xSCGv5UENvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbsrfuVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbsrfuVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA01C2BCB5
	for <linux-omap@vger.kernel.org>; Fri,  3 Apr 2026 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775201005;
	bh=X5jJUvqRgah6D4xreZa2cicuZ87mzGtemSdNEwIyCE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qbsrfuVDWXDD14HyUPLCwUoEA35b36V8S0xofxc6TYCTk1NGhobr8TzmodD/Smtx4
	 i1QQs5kzFkuDbk/rvg3UozTwMytnG6oUaVI6ZgUWnRCT+4VNmCBHdf450IesQzuZ0q
	 D4tp6UuHBdTfVkvzVGU8APuLPtyH/cN9I8meoXFtmPrO11do9hsn01I+J8U2+an6Ch
	 5gRSGzScckRFAlp1KitJZc+tz+dp6bjBVwv7i4FeWztE1W2RIwDRZu/e9VPxeyknD5
	 B60rdTQ3IYQfsel+S8iRlIbjOc7bOyopVHXNkSEijfCHsDZF5A0j6OvsyptvzNIJ79
	 LSEB4VoLy9+Kg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a3066b68bso14777671fa.3
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2026 00:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5+jsfTmmOrqSQP0/df5+1sVAkWW/59wJBM/fDIjtsEl/rh6KB8k23dzMam4pMhbteE2qgmS104haN@vger.kernel.org
X-Gm-Message-State: AOJu0YwblzZNGSgZf7YyX0mZ23bFfY8gz+e/Q233fDq31MxNHcK+F7ao
	Gfd4FX/TfxjgHOyA/Uoc9pzre5/OT7Ix3LyCaN9XZITHLd53YgiBX+hpKy5CzfFtmuJ8jK9u0zu
	ZukHzWLDVrPA9XaB8TURc0Gu19Nph7NQrqf70X/0wWw==
X-Received: by 2002:a2e:be92:0:b0:38c:6979:f75d with SMTP id
 38308e7fff4ca-38d91d89693mr6167751fa.34.1775201003957; Fri, 03 Apr 2026
 00:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com> <ac6n1p3eLVFzumbt@google.com>
In-Reply-To: <ac6n1p3eLVFzumbt@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 3 Apr 2026 09:23:11 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdZ7JRs3vvz5Rz7vMHYM1JQGRtVujRXeNhsz2igtDADEw@mail.gmail.com>
X-Gm-Features: AQROBzAuWuJJYQfEE9L788n8ipCOf6hcvXwHusg9h7TnjUkNV2xHUaa0ho16T-M
Message-ID: <CAMRc=MdZ7JRs3vvz5Rz7vMHYM1JQGRtVujRXeNhsz2igtDADEw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Kevin Hilman <khilman@baylibre.com>, 
	Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:32=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 04:15:05PM +0200, Bartosz Golaszewski wrote:
> > @@ -244,6 +263,13 @@ static int __init omap16xx_gpio_init(void)
> >               iounmap(base);
> >
> >               platform_device_register(omap16xx_gpio_dev[i]);
> > +
> > +             ret =3D device_add_software_node(&omap16xx_gpio_dev[i]->d=
ev,
> > +                                            omap16xx_gpio_swnodes[i]);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "Failed to add software node.=
\n");
> > +                     return ret;
> > +             }
>
> I think the best and safest way is to convert to using
> platform_driver_register_full() and set swnode in the relevant "info"
> instance.

For sure, that's the plan. I will respin this after v7.1-rc1 with that chan=
ge.

Bart
