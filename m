Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1F37F8A7
	for <linux-omap@vger.kernel.org>; Tue,  5 May 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977944; cv=none; b=col39qQlBtmyBObx8lohTrlYlUb/Oc/OXWfHAObFeoKfAdxKkyh+rOSjWT/AUsVIWw40xojt2q/7b1tocF/5OVp7HVByyPh96sMQJIYjWLITJ8KchEft7W4pdMqt81LMGYBCLd+QbAmTRIKMbVOVHQnVnMV6/VQbP7/TjdKbXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977944; c=relaxed/simple;
	bh=TsTg/4UWC81TfUPMbovyHWMpmJYOhH0GyHDfnnm3vHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEix52eA0VzBNn+mzbHU5Zfq7qgmUpAIgJ9Gr70kEoKsaYbHSsdGRk+SrUfxHYucAOHOapYsXlItWknbfkPcJxd/NRYFRwkOq+AujAYePhoeEMDjuze+MhD/P7X19SVTC5UDv6yWn28vzNKiA3lrUTWGQMe9H5JBOv74VNUO1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ+tCkcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ+tCkcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E5AC2BD05
	for <linux-omap@vger.kernel.org>; Tue,  5 May 2026 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977944;
	bh=TsTg/4UWC81TfUPMbovyHWMpmJYOhH0GyHDfnnm3vHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJ+tCkcSp6dpIN6tgYJu9sXU6+VcQHZ8W1zFFfUpjX8/2a9fzB+NHY0+oM5ubz08a
	 EPwvgLTTDYnpinWIKHchn5Dy51BJeO15CBCAgYoSTfMYMpBVxh8eq8iobw7dkEcy1p
	 BHY8T0doxouMzLmXwp0pTkjEuc2uxl3fShHQmUcuiJ1xAs/bHaG5CQCPo9Ijy+anqG
	 8nDhUF6mRHTCmsDmQ+NizWo3zkHxEPZIhZX4S/XFacjjSr1vBb7Uq3txgsQiIMLnSx
	 CyIuS4LHW+WbYQ1K3AhYpaaM6iGDu8+egCSAFp4PCGgCigVKMOK+OnXSLeMJ1kfQSO
	 UqMCCoZtKUD2w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39397d63804so22578061fa.2
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2026 03:45:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Rmf5g4gmyoxSJUn872FsDKO9WgG/9Smcc5jzUgtw+kOESSRZVL3T76JeZYJMRbfxpsRimhiI7ipyx@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVkOY23mWNhfZlYdqzdE5T7BOAgDaRxhpuvYtUchmG3CG6dHD
	IXCQR3EnS75dSorn/NOw+WyHljSiSBXkS4fRXZ8z0VoEPDT5/dnU8dAIxQEZf30nQn1UPd7hB8f
	F+3hIS58v0MoTlSykqYT4FUr5Ka43CQU=
X-Received: by 2002:a05:651c:4198:b0:393:a639:4a10 with SMTP id
 38308e7fff4ca-393a6394c4dmr22048921fa.15.1777977943005; Tue, 05 May 2026
 03:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777562725.git.geert+renesas@glider.be>
In-Reply-To: <cover.1777562725.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 12:45:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLmg0-CviaWkzJi7xCvgwzz2KbVkmq-kqcWJ+2=uTNCoHg@mail.gmail.com>
X-Gm-Features: AVHnY4J5V-rMG0dWh1E5TLlvveEO0urdyGOidGxFOXsPqvTO1NYgVMcBKduDto0
Message-ID: <CAD++jLmg0-CviaWkzJi7xCvgwzz2KbVkmq-kqcWJ+2=uTNCoHg@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: Fix types in .pin_config_group_get() callbacks
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-gpio@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:33=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> On 64-bit platforms, "unsigned long" is 64-bit.  However, when checking
> if all "unsigned long" configuration values passed to the
> .pin_config_group_get() callback are equal, several drivers use a 32-bit
> temporary.  Fortunately this works, as currently all configuration
> values fit in 32-bit.
>
> This series makes the code cleaner and more future-proof by changing the
> types of all temporaries to unsigned long.
>
> I intend to queue patches 5 and 6 in renesas-pinctrl for v7.2.
> Thanks for your comments!

Excellent work Geert, thanks for noticing and fixing this!

I applied patches 1, 2, 3, 4 and 7 to the pin control
tree, leaving off the Renesas patches so you can keep the
Renesas stuff together.

Yours,
Linus Walleij
