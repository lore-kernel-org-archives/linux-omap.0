Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58173B27D3
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913273; cv=none; b=YVZ4jl3FMrNfF1xIVLEh8bRhSYfLKnnHLwD3ZNI5jXVga41j5Arvlf9mbGxHTnOzPxGwUKy5UG0rHIwLkFTXQR3AoLyOUh2oJSD5zqgQE5g2MKmJ/k/lgMNufvko53oWBLKcyf7XXjMsqdS+9lPjfzsMLCXYb6Gh1J1a9RQy10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913273; c=relaxed/simple;
	bh=CL9+6k7wNF/Fy7o6POllhCjmlhVQBfyr9jPXJAyaNjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk4a9AeGzgP7hqJ6Jq1LzS2wvrSYDRd1zOr//FfomEntPZIAPI7k4PoyyclRcHqmIZS75J8eCm9RFjrSZhOqjsckpmHajtyuniactfoeOOmYtEZWmDYtsg/xyKnOmCML3aspYAwAcdjwMoM+mR3HP6GPJFPt8j3XM7yfw95IGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrUDLXsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrUDLXsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBD91F00ACA
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779913272;
	bh=CL9+6k7wNF/Fy7o6POllhCjmlhVQBfyr9jPXJAyaNjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZrUDLXsyFFaXWW0XNris92AUEqKRd86ttexYx+Cga0tawFEHXLP5Ge36JqCAYkplv
	 DodSCOUNAiK5O54IYqiAyUVddc16ngi2euptfhA1QmFUrYFpt/dt+E1m7k4keZdXct
	 Tp6buG3Xm9nV7pz7kmOlNXQyDfgRFftjsjUxC2Dq+Lt8HTKD7zSmYh+yppSrocxWSF
	 FXJ+mHLiBx8c0vIeUHEBMw9mds22iKNXxDhn7eAD24TAI58KhQanQF/IeRzFwRp0Q7
	 lFCt2jefn/tm54YNF02ex2RIGtjdmuxQ15DWmcrBNmoQLY6lMdQLPupv4pE5y1rXbm
	 CiC/mSyXyKw/A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa2d5a1d51so5178384e87.3
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 13:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Vc1fFE9gGePioHsVoqMEMTna+JjK7n8ZmaNf7f7wAuyCq7mol/e1ckvy11T3Cz43oPKeiZM5U2Gut@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6dW2pY6uu4ExPJWCWpxTLYzqI5NtbRFysU2MhbOj3IRXUTYm
	dxsTUBVy6yokXFfkxLZzDgwJWrhYBb7FgfD0sdZSAcfiW4GBIaBJ0UeJppvlGFz/Pb2Yzv/ZEnO
	LhAmsx/Efb0f90od0nTIWLGGEsDrZkVY=
X-Received: by 2002:a05:6512:3086:b0:5aa:4d22:b94a with SMTP id
 2adb3069b0e04-5aa4d22bb03mr871554e87.20.1779913271202; Wed, 27 May 2026
 13:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 22:20:59 +0200
X-Gmail-Original-Message-ID: <CAD++jL==yFhKsBuxBkyGgQO18n5FhQw-aeO9yMPR8s4Zu8iM=g@mail.gmail.com>
X-Gm-Features: AVHnY4KjDSA9qFtwb_8I3UpWWDeHjxhItJHAkLGZCFb2ck_4Vp4ui18Tx3tYdQo
Message-ID: <CAD++jL==yFhKsBuxBkyGgQO18n5FhQw-aeO9yMPR8s4Zu8iM=g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpio: Use named initializers for
 platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 4:57=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:

> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

I agree with the goal of these patch series and the end
result makes the kernel a better place.

Yours,
Linus Walleij
