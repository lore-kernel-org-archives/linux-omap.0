Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D863909B4
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715523; cv=none; b=uYq4dHFL1vdb5+E3iYyDjFM1nHlCROoIwepiLXfDyVUko/H3zo6UpcM0o6mcVS0XHXOqJCKc9b+mZf7PMMjlBeCfNpYjvBglg6/CmxcgDUgiKD3SqPVI2mf4ZCZ29iQSaO6rtB8W5m1r5TudZtR7wvNIAS7E/LvrG7ZultA8+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715523; c=relaxed/simple;
	bh=5are5agdAPBNhp9zXXwfI62i9NhVAzVx4EzODqm4TGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL4BwnxKMvsXmmJW3qRoXiVK4JrI0Cqfkm0R7UqU8+RD87nJq7/3+KROwW4zLvp6vWHoD/Ybm0g1e30mgQ3ZPp0V76A/7+OgUlpZwHxI3iggBqrQ2MNkfm6d8BWbNjIosEV/GGZH9RBm2dcWFgrZmDyEVNebZx3ELS5mD28ESUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV+iriVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV+iriVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3994C2BCB7
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715522;
	bh=5are5agdAPBNhp9zXXwfI62i9NhVAzVx4EzODqm4TGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dV+iriVYRSVkaLwZWL3RYxUVzrSC8aD09FYxF5jNKwSm5Q1YyPTJsFvSzgCigsGzx
	 HTMHgHkuc6N4hI6dLH2FrL4N6624GGkh2DzGuYN82jY6oeYT+0ZZnShusqFd4BG/Kg
	 B1JkTJG72xoKJ5V5FpMaG3Mde4MvfUWAe6CEvDOvdpIy1wzvO2zDb4SjHoqi08W4+n
	 btTVRpbcLf83Ku7WUyELXiwkcystoAPidj7LlhvuXaGCjIxxaUHfn6lHoq+76cQZRJ
	 8fJ63KdmGO1rwKGTsIhQpXPFjeeJEKbzRjR4F1fnBj4tMXrZ/dSOKAtgx8OzbOSDqF
	 t6okvHWVh3vLQ==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-798374d0f44so120735407b3.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 04:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCKhEdqMkUirSRqF7dL/zsxGtrBFEdu29dciS3shYfuc6ClGAlEMPwJdxonbUMInScZZC2v1ulMdI0@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBSR1UyUPzWI18pM4gVbaOMtgV3iwMZyDHTEgMC7cLQss4t0L
	1exM6Nm32brXRqJKheI61Kv8Y++E+0r9JbUDLK2HwYrvAwoTqOsV3jnjLKN8yCmTGkF8NaIaTDw
	Ru7LImDAaDzaU0xMDP6pvWAChIHeR4kA=
X-Received: by 2002:a53:e19e:0:b0:64a:e56f:49fc with SMTP id
 956f58d0204a3-64d07111ed8mr1184395d50.20.1772715522083; Thu, 05 Mar 2026
 04:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:58:30 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Zog5wPPiDDBp=mv1nhCgjOZkuG8NtZjvzfhc0KK5Z7Q@mail.gmail.com>
X-Gm-Features: AaiRm52DhevPDbjjg-MMnWaC2zgG9VailzGdf5hJANa7pRgxzk-RHGIdAAju58g
Message-ID: <CAD++jL=Zog5wPPiDDBp=mv1nhCgjOZkuG8NtZjvzfhc0KK5Z7Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpio: of: clear OF_POPULATED on hog nodes in remove path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> The previously set OF_POPULATED flag should be cleared on the hog nodes
> when removing the chip.
>
> Cc: stable@vger.kernel.org
> Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

I have no idea how OF_POPULATED is supposed to be used
so I just trust you on this one:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
