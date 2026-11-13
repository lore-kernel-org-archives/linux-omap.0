Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564973;
	b=rIl8EtnWtXbIraX1QiYZlRGlvWw6i4DeuTEkVhxRinH5xE+buGUbE3wtxUNatZ0ouS4Z
	 lbg6nzO2cIXXKvnLdAuGQp3YumEpW3DB4amsrR8qGkIUBzi/Tts2FIhkTk/VuI8dlUWCy
	 klwdmNK2Ol+/DXtgw/6h+mhLS0GE/PAdhK48BZx8f8Bf8OrJPllBs6MUIxou8OXRAmGbX
	 5OnNg30jbUnG+eR9tq5UPuAhXAQZBJZv/LVdARPHvgoY+YromTAVBOZGmrXPImb1UhYpV
	 1c4Qs5p5/xG4vLpyuzKE2TFSOcG+sf8GlDLHY/3I/ErWv1e9JbKf3qO+xWSAO/FULpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564973;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KZ74UW0TYHmPuEppZWYj1rqUKpEM+BQypI3pzsCGhK4=;
	b=Uu6AqadC+qO6rJfEFo1POwWI+/ZBRGHczYICKLIrtYAUY3uYUMSyOZgCmvSg6zilcUlT
	 8a14KuTfm/5tGlUp6z8iify/BXWj7S/QP9/1CeCHUhVI3y3udZn97+PRfsXR+n+p91ou9
	 FqW2UxiatV7B1vVH9jTQ5IPE30hw/f52d6VKGt3TlaUzXmHr/A4Nivri1mmMzuHeTlqJx
	 xFAu5TFkvlVKcPJ32eZIeD1/K1mBAgEgHn8idJDfxco+G1DXHt4UWRG+LKRN5d2AX6T20
	 DoWmr0Cib8ARTGZhYoGnMYV3dMgyxPiMof1t7Ydo0fJEBeod7CcT2gQgTYdCvGKO5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEGSWt5P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376D6606A31C
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEGSWt5P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17731F000CC
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564972;
	bh=KZ74UW0TYHmPuEppZWYj1rqUKpEM+BQypI3pzsCGhK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BEGSWt5PyoYcoZmBiIeq0CohHcsrFxELU+qdTbmL74Ij9U6IK5oGbyQQ422CpXCqM
	 VIHgV8e0jJqEbibLIypOeJiNatRsdrd551N13qRMc8pJAft4U30ARBSYVdhFsaFYdk
	 S7Dsd2GfRO5tHPvcEkLnGRM+saM6utpot+xeBxXg010G2IOrVqPziCd51gdUBWf0jH
	 SbZAW8bJvsDj8SOKpn8h5YRCaXerVjMZStXQ7UBhVaKPw1yvJdkXzSlxj1SAJ2h9zw
	 fq5c4jzYVz0PTdMD+tpsvR6QFNQWk1wJnzCNB86VKNJaLqwoJTv0MUCcnSApJXRlRv
	 IAYUDTQaP6Twg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48ed0b68895so965199fac.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 02:16:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFbxN9Bb/4GIrnL/d1xuQMHpZy+7NjKfIEQ6anS8Qa2NILPcY4G3IOcPX/vvXVzsd3vtu1CeFhaKLV8@vger.kernel.org
X-Gm-Message-State: APuU4Z+A6VJm943PCCC0S46Rsob4+wW9Db99uBHEYieJYqIFKj8y4/m+
	4dwX/bHA5dJgh62++rpxwfWi7L2cFPtrvFsPfgkk482FZb2vsJYY4HMGFEsRHoXFEEP0X3q6QKE
	CfC5+9JxjiBpaRVq1VAz7jr9Lm5VewU4=
X-Received: by 2002:a05:6871:824:b0:48f:e157:eb25 with SMTP id
 586e51a60fabf-4afdf7391e8mr2102560fac.44.1794564971946; Fri, 13 Nov 2026
 02:16:11 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104140820.65243-1-asv@kernel.org>
In-Reply-To: <20261104140820.65243-1-asv@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 13 Nov 2026 11:15:56 +0100
X-Gmail-Original-Message-ID: <CAD++jLn=T5YPDG--pPsdbV4tGxjNFH16ZaceN-Lw7B=TSJqhMw@mail.gmail.com>
X-Gm-Features: AclHuK_xp4juiDSf6WxJ1r0I6C2KBl-UfweFaPL-sasy9mlFdKqm6R0MIJqytLM
Message-ID: <CAD++jLn=T5YPDG--pPsdbV4tGxjNFH16ZaceN-Lw7B=TSJqhMw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: pinctrl-single: Add Alexander Sverdlin
To: Alexander Sverdlin <asv@kernel.org>
Cc: linux-gpio@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, 
	Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:08=E2=80=AFPM Alexander Sverdlin <asv@kernel.org> =
wrote:

> Add myself as a co-maintainer of pinctrl-single driver.
>
> Link: https://lore.kernel.org/all/CAD++jLn8yxh3LmUzbb2vZfJFJB=3D_mCZ+VeQh=
nZktfmuMiv5uEg@mail.gmail.com/
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Alexander Sverdlin <asv@kernel.org>

Patch applied!

Yours,
Linus Walleij
