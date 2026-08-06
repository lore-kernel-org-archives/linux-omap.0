Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF833F3291
	for <linux-omap@vger.kernel.org>; Thu,  6 Aug 2026 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053017; cv=none; b=k6e0Cm8z15bIObVB+2a0y0GS1BiaLLC+guqZpfVgXeeyjC9YX7pHJZNohPxs4pOCinFKtxZW+ltrq5Hkdlj0H2Bn2fgjOr0Q8m4Lst7OcCu6RMsq9U/JoK0HFem3G7eDFsKETEXamty1cF0EEf+Dw2fGzzKqGmtntl8px5AHxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053017; c=relaxed/simple;
	bh=xcy7vptF/hy+DPHjB4Gbv52wsdaMVtOZt/3bPVoHJCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkcz/yRgbACd/agZb8DpbKw4omCMr75R4HHdFugUW6NdieOMV10sPd4831m5W2qJVSF8IlaFRp38kS/TSbBJD1jd9G47v1fZWwlEfhlvYgA5YjLqwf+XoHctQJq1PgeoIa0amoKiaA74FAtNDn0zYMRl1Jqt/k+WadqJOgtg3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngV5zpVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngV5zpVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81331F01566
	for <linux-omap@vger.kernel.org>; Thu,  6 Aug 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053016;
	bh=xcy7vptF/hy+DPHjB4Gbv52wsdaMVtOZt/3bPVoHJCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ngV5zpVu+weQOpvh2gMXaltxq8rXyXczgW76DqK2uqSDkzlHCp8bcelPQ7d9NZqWu
	 9qcU6Qmwhv0CHSXt1hjnP7i9hY6paI1gyIO8etzTx27D5tz0rjwJMs7odjmk8Fr/Fu
	 kD8cNNMtuOh7eTnilBSaWt+3HS5KaxzCmqjHLCDnEobNlUay3H5N/UpT8jXqE4EXbu
	 BWkLtbYFL/vasv6axsDMLMoFoOc+KR+15lE4BY4TnTwXM2uhVshbKk8FTOlfGLEKbO
	 gulS2mOt6lSwEKUHsnrowuAx8G14Cr2r/6lHEwtvFRkrshhUrNj/uSVl2Bk70oiAoZ
	 jB2+/rorUgz1Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aea0fff535so3058305e87.3
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 14:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZ/DeKeMpu+9kr3z+EBr64j8BszTI5HgxA+1N8ktnIt4HZzdBiCSPgyzzK1oM8af5GT44aKtXVOjNW@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXae9VIsMMI5OgIEFgEJbmY3KxtMBszFbQxEa56LelNqFYsZk
	IEB+M826PFMHJIguL1cxAV+KsgYkV7WzRowJ3SZ/bl8NTxI9rQdzzQv8Qk7UI62UYseEiSBIpYJ
	7U/D+Vkc1phGp1Fp2pRcB52qraoFxhK8=
X-Received: by 2002:a05:6512:304f:b0:5b1:5807:50f2 with SMTP id
 2adb3069b0e04-5b303cb381fmr548646e87.43.1786053015336; Thu, 06 Aug 2026
 14:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-b4b4-irq-trigger-mask-gpio-v1-1-948973636c84@oss.qualcomm.com>
In-Reply-To: <20260802-b4b4-irq-trigger-mask-gpio-v1-1-948973636c84@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 6 Aug 2026 23:50:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLmFruzsuSCgzKCZoy63dgTPi=Hci-xgj76315ht9ttFyQ@mail.gmail.com>
X-Gm-Features: AUfX_mz1H-BHPNicMG_kro-JKcpFPgsijOdPLrxM4JqaXBQO7QyYZT_KtNKmkEg
Message-ID: <CAD++jLmFruzsuSCgzKCZoy63dgTPi=Hci-xgj76315ht9ttFyQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Use IRQ trigger mask helpers
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Keerthy <j-keerthy@ti.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Manivannan Sadhasivam <mani@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 4:11=E2=80=AFPM Maulik Shah <maulik.shah@oss.qualcom=
m.com> wrote:

> Use IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH instead of open-coded
> trigger type combinations in irqchip callbacks.
>
> No functional change intended.
>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
