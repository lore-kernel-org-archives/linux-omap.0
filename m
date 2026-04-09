Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D4379EFC
	for <linux-omap@vger.kernel.org>; Thu,  9 Apr 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724266; cv=none; b=ScNenEplkdchzT9sXrfTU5SXRmOSsWprdXjw49H2W5jAw14MQjtN7sfc4s8U2ydCBWnZ+VpcgehlnSQesKvwS/3BJoqugw89N+Xt+8Jd9+D34CKdNUfqDMPp1FpzEMRbRk1x3RSesrgr/W7mCevK6igxAucNGQiEEQeQEqaMTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724266; c=relaxed/simple;
	bh=XSinTqMRk7WKiOjjhU28b38TxCJUDpIkM+UX2/IoucM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClblgtcvngxRDhOdBPF/I8zXvuvcQNFUYTqOcvvHeLBCd7qiEXr5x6tLzVivpV3IvJyGHsuf3Vp8lUWv/ZXif7KpKdaH2vsvdTfYKiVqergEttrMuAx+EfCM7Md/0JsNF73aClgaX7JRA4Ll4GKBg5Zu8zdO+p47if0jQuzoZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdD8hj67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdD8hj67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C959C2BCB1
	for <linux-omap@vger.kernel.org>; Thu,  9 Apr 2026 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775724266;
	bh=XSinTqMRk7WKiOjjhU28b38TxCJUDpIkM+UX2/IoucM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GdD8hj67K/1zLUxPLNVOghF+oCNsAuD1A0dy7Qh5FjOLqX82tXv2tAlxrAIL1Cym0
	 K5m24CruJ3a7d7iCtqkTcYJcWpmkbmHGSxnEfj1KSYokKqXnSVGnQXsfnRwIT2Ozfc
	 JMvBPlNOhp0hB5sd+bS4ZSx/fuwmRG7ahRrvc7CFIDWwHVd0S29Sn4+FnO8QR340kG
	 KndacjW+Lhxiu9+JMDCjKq/LkZYUrj0o2N6q017HKmWZ9+ekOhnYmpJkLgI7vkvbwv
	 /v7F6R4phc0WnpuQWxR71yFVBjasiQcESQ+4tbnbhmzOhEsXK90dUcNBF2JG9eaAQ3
	 GQawv2tQ6TdNA==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7a469383e0bso4527477b3.2
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2026 01:44:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIpSOhq3M5dynj6xj2SGRxlosuXxiDRBReRU4/NZ/JGqpggWd0VlXcMv9UHBtdNdjuUNDgPrPE2A/q@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSUaIVRIMFf3ZujrMbPD0MZs1aX7bEAD69eiDKUFchZ8ZybxH
	YstR66xq2UfaQMpZezYv4OxClMKgBh4VB+i1vj/YrtFRnd1p9YZ7HjOh7wIEmM/vENlex3dzEfY
	njHgP5bEO2cw/n/uURVY6kHqiPD5tK4w=
X-Received: by 2002:a05:690c:6610:b0:79a:bc1e:a399 with SMTP id
 00721157ae682-7adf2863321mr27613477b3.35.1775724265707; Thu, 09 Apr 2026
 01:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407235611.550515-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260407235611.550515-1-florian.fainelli@broadcom.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Apr 2026 10:44:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLm10MOYt5Xx9Am+Oqs8rOFse+L7WDOc-W_5OS5fXuSSHQ@mail.gmail.com>
X-Gm-Features: AQROBzBBIPyY1s_9tUX4DGpv6VkJc53NEDV7f7YuwDbgIlTf2tXYVbrcG7VMnEM
Message-ID: <CAD++jLm10MOYt5Xx9Am+Oqs8rOFse+L7WDOc-W_5OS5fXuSSHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Utilize pinctrl-single for bcm7038-style chips
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:PIN CONTROLLER - SINGLE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:PIN CONTROLLER - SINGLE" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 1:56=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:

> This patch set allows Broadcom STB chips with the BCM7038-style
> pinmux/configuration blocks to use pinctrl-single. This does not
> preclude us from making use of a more sophisticated driver in the
> future, should we need to.

Patches applied for v7.1!

Yours,
Linus Walleij
