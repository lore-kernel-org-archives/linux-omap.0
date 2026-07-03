Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94936C9C1
	for <linux-omap@vger.kernel.org>; Fri,  3 Jul 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066300; cv=none; b=BBaxNVEUrfzD+S4FcQVkduK/IjsjniJUK4AKf5KJOfB3oc3jFHZYspVX1Gkd69wJOX40GXB+46FT/6gILyZN4O4K23HtiNeADlMGKLeUTAA2/5SSKzjaD6Wq3Wp5xDapoY3xiPNx3pzAtKM5kq6uS1oScwigou+efWyziutuB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066300; c=relaxed/simple;
	bh=BkwWV5hJpNCm3E4SPznpvd89v31vfbPa5MKL+m+sbx8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMne48m3j+W2oh9gXH1YeQxXobPuIjpd1VicNp3BaeuEm517zOIGl33Yl5ohRw39GP/MdV/4Qx4zTg5l+wkXEtIcHX8eAFF01yjbSNjF3F3jMdD24UN/BkXUrWCeSPeeeAZXOPN4o2qzsx71v6WVkrR5zGnSEIjL0G+ClrGGM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePD7Oqi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePD7Oqi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B641F00A3D
	for <linux-omap@vger.kernel.org>; Fri,  3 Jul 2026 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066299;
	bh=efYg+iV1L6ef429hOtMTh+aB9u+dJLoTtfuENqul9xQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ePD7Oqi8suA3TLdsXWaUwKSsDz10Uz6HM4Q5IP5VpGtvawuqXokZp68/lzXmOgXiW
	 RqmLoiI/R9adJZcM/b4urH5Rna8hLLXhOk77jn5CHY+j9q0bnU7MbkTboB/gHOrKJc
	 j2qDo5XZ7e/xZlAP+LxAbB9HzrjMCYt1YPNPlEX7zRq4I6dQlDoQf9rhiPNJno4Ugx
	 gSExIqMkQO58liq2fR925ggZcxJFJAnrxbeIhaQQ+WMifdEdEd+2HlnlK+ar/CP/G0
	 cVUPNMjnV2CvY8D6Nju3LwxhFu/gJqJc2Pfw0gEgymnxDtgVNlGlreNiC7rDm9ISn8
	 YiAPXce/yxmsA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec6360133so241539e87.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Jul 2026 01:11:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqgah0zO+MuQRvMUhVX6c7TDNfKLAym1kguqfwAVMYCBF8fPrKtgnt/3DTfMm/Lvlaj9SA2PJrxxKbN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HSvPpXvkXK9SKLqTXDY+p/ZeUXNVRAebpYMHcK8RaGSNQTiD
	kGd3roJC4SAGDhjuZ/zOPIbgg5q7QKksILYuF0CFA7qEwJjcL6ryD4oZzf4JHIXlXkrmzDLCnAt
	RDN6Usk35KoLftACMJQHqJEkiSuAkFvREVaJO255cow==
X-Received: by 2002:a05:6512:10c8:b0:5ae:bf5c:bdc5 with SMTP id
 2adb3069b0e04-5aec714fe67mr2874313e87.52.1783066298465; Fri, 03 Jul 2026
 01:11:38 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:11:36 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:11:36 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703-palmas-getdirection-v1-1-046c155961c4@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-palmas-getdirection-v1-1-046c155961c4@kemnade.info>
Date: Fri, 3 Jul 2026 03:11:36 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mcm0OV60hCw5HWWcXYCb_5KyRvFe0bOuV=9kyu1n0sgGg@mail.gmail.com>
X-Gm-Features: AVVi8Cd8IM03mNd100TR-6OpMqQe8TYl-eW8KETzscMBAkr0NMahTwo6Vnccs6M
Message-ID: <CAMRc=Mcm0OV60hCw5HWWcXYCb_5KyRvFe0bOuV=9kyu1n0sgGg@mail.gmail.com>
Subject: Re: [PATCH] gpios: palmas: add get_direction op
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 07:21:05 +0200, Andreas Kemnade <andreas@kemnade.info> said:
> Accessing debug/gpio is quite noisy without a get_direction()
> implementation.  To calm that down add an implementation.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

I treat these as fixes and send them with upstream for current release, please
add the Fixes tag and Cc stable.

Bart
