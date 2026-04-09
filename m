Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1235B632
	for <linux-omap@vger.kernel.org>; Thu,  9 Apr 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724237; cv=none; b=GFQB0Fa5Q48LBKiCwShnFt89iPdGaYCOp2obdUQgYojPWI0iGnXQqsj2xmxXO0anEzuQTLlSaVH8O7Suw2jyzrpMyfXFz6vPVVsaNA7DFE69apm2G379462mKP5K3p6DBWieTugPfrjc8hGZTjvTsGuT08324rWKfKOiRmIXBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724237; c=relaxed/simple;
	bh=NcyBxEdC83CwSQVeqd/+ifnZKhBgjInw+UKqA5lU87o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/c3WFPVm2c/CkL/eoJVBSkQ+FOwaMAj8iTA1RAHcm0NyzZ8Lhs7EptAe7pCmUaoqgzFCl+UmTS1I9w+S0U+6UDNoHFiGSAZzxFu9H661c3EByQVDx/2iLbu/XmudiZ+hHkqQLlqIVWcYEsCakxGUQa/zvpUqJ/5KIFRhULjtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU4LpRfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU4LpRfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B344C2BC9E
	for <linux-omap@vger.kernel.org>; Thu,  9 Apr 2026 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775724237;
	bh=NcyBxEdC83CwSQVeqd/+ifnZKhBgjInw+UKqA5lU87o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YU4LpRfW8wM1HKoklft4RZo7//H5bYshqeN+VLfxQe1XinC9HQc2AWsbwGcIHCUDs
	 quPgrBjlSciM/uAzKHsVfiVGeImXpFnt3YsQ4HgdZIEXBCicGS+j8nuXtCRnJlBX8U
	 mM/vylpuUtEspWgAalnOfegWCz+VWTZ8UUoYFKntTw8Tr9OE/m2fri4MlQ44uSiOPP
	 2lCbaH1kdnjTm44cWrXrAt0k2oS4t7XH5h2xBdm8LaDWJaCQdgg7o8nhWv3D8kBce7
	 FaweX4FatQYKLA+CwgIXN4KIsF7D8GugYPHHFDu8Z0wVUWM6KqLUU33DkV9L5AdrF1
	 Gdlx1mgjwuuZA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7986e538decso6538727b3.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2026 01:43:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULKyjkwlck6YbL3fxaxGTzDzRIRFTAGjTafjkCQrVwrqOfyEH76R9i1nVEZYpZSRUM7qAmliMjFbk1@vger.kernel.org
X-Gm-Message-State: AOJu0YwpD6VLFfHQp5M2597KwzBqxXXTRy4AJR+gRuFPc1+Xcx3oRdLx
	pCzodGLQgt+N1H8cbUdXjx7QQKSuEZZDkDJ4ZslqkrYPFAsc7Qjr0zSk92NAISvuX38zCAPZ7jA
	3RXnQx+AhGyvh5YjD0bo9zMcr4i3Tkuo=
X-Received: by 2002:a05:690c:6d81:b0:7a0:4146:6ebd with SMTP id
 00721157ae682-7adf1885749mr30709357b3.24.1775724236613; Thu, 09 Apr 2026
 01:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407235611.550515-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260407235611.550515-1-florian.fainelli@broadcom.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Apr 2026 10:43:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLkDViw++2z0zU_kJ34MSn6vbBODjGFvdPU9mtRZKF=iqQ@mail.gmail.com>
X-Gm-Features: AQROBzCTxnAq_MMXyVcVYXsPtjsQhejsVfqwYdrCEdCdgzSYiyyw7RR-hhoaEGI
Message-ID: <CAD++jLkDViw++2z0zU_kJ34MSn6vbBODjGFvdPU9mtRZKF=iqQ@mail.gmail.com>
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

OK that's one way to do it. I wonder if this approach also works for
BCMBCA given Haojian's comments on my previous patch attempts.

drivers/pinctrl/bcm/pinctrl-bcm4908.c would then be phased over
to pinctrl-single, or does the MSB/LSB register layout create a
problem? If we always write 0 into MSB I guess we could just add
some quirk...

Yours,
Linus Walleij
