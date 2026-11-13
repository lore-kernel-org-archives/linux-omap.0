Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567045;
	b=On+5x9glM0ZkhEcqwlp9ufIOp6YXm26/zBywd8VrFaPRZPS/jb51j5Wu/iswn3Ggs0pn
	 Pe3bZegddnN6BQRMs+vep6wAmO1/F7axVK6C/gPb6SzetYYI5xwJBP/P2pOLHpt4vHhdE
	 ncIbQx+8nSBPCfRI2e8SUuvqyTTuv5bUF5olxnsoqYovddJ8TtHBESa2NsT6xSRPioeW+
	 dKKqQ+oGWbWL+rkWvJKzUWgnhksc+ZMPUolZBnmh7HPgrz7yo3W3axw6s428HmrMDJxDy
	 RjE9NVSdsZ2T230gNL5h/DX36zHxCJstvXHevOn9yoOJ77To9l60lYZ3COlQOoyk4Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p/ExtvkL9Du/wDEfGVJZOYt+XTSUX553taxUueB7Rwc=;
	b=sgTfgrz4qigts/EBLJiO0Mwi1bGmPztaY7NFInvZfi0o+r2HrNrPHRjFS+shj6R0iqPL
	 998if3QYd1JfuYde2zxfocXdb52+RaAyRaUcKLPHGgNxSX1utjdqHSohlFaDmms+t7t3O
	 T4YKSsBYApdtLi/thmHZBnzIdqGPhXNxpK8RjIaEnDgg4h+pSP1fHtcJPoT3jG43nBDNs
	 x80hwmk8nLfs1pBD7NCHVtnKmDPaBZyLg1HHS8DKFzZiCKYwLosVl5v9gagi6IWJknXYw
	 TezJvkUfYwqSpy6K8LVzux2f517Kg+/XCkeNdYATvVB+g3D0NDx1ZjO0UACS6nyhzfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PufdaYEU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77F60A380F;
	Fri, 13 Nov 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PufdaYEU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA831F000C9;
	Fri, 13 Nov 2026 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567045;
	bh=p/ExtvkL9Du/wDEfGVJZOYt+XTSUX553taxUueB7Rwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PufdaYEUiaRasFGY7nNYtuGw83vOL1Fo7dTL1mtuqMbi/Y8U7W6eof2HNdZeAxgFd
	 o9noLHGAi1V8Gh7Sml6DkJul4warfOhbecALOrzQ0QxDg07P8duBVC5C/KpWJ5aZDG
	 W2/nTlc86MHYrC6PRie5aFL9zmvFz64ARTUqZiKH7b7eJoTmjG6ojffEElGMDfpIVj
	 ykLOk4yH0lfRs4Km08/sX5uLA9/A11MjEkpAd9BM2K5vEqcc5N0deSjHKGHdv7JHaj
	 5tdnBYuU2vrIZi3KDktZqGrawCypHhhwHUnYK8HrFNlBzzTz9iUgN14fo6TVehQQuu
	 IPxc53QFJYGXg==
Date: Fri, 13 Nov 2026 11:50:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Mark Jackson <mpfj@newflow.co.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: arm: omap: document missing AM33xx
 boards and SoMs
Message-ID: <20261113-marvellous-prompt-cuttlefish-c4f1a3@quoll>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
 <20261111-ti-omap-dts-fix-v1-2-19022d1ff4b4@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-ti-omap-dts-fix-v1-2-19022d1ff4b4@gmail.com>

On Wed, Nov 11, 2026 at 01:22:32AM +0530, Bhargav Joshi wrote:
> Several AM33xx devicetrees trigger dtbs_check warnings because their
> compatibles are missing from omap.yaml.
> 
> Document the missing AM33xx compatibles (Bosch Guardian, Gumstix Pepper,
> Moxa UC-2101, TCL SL50, BeagleBone Blue, AM335x EVM-SK, and VScom
> OnRISC), add entries for the EETS PDU001 and Newflow NanoBone boards,
> and for boards based on the MYiR MYC-AM335X and Grinn ChiliSOM modules.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/omap.yaml | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
> index f694dcbf23486..c97eb4953ed25 100644
> --- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
> @@ -104,13 +104,22 @@ properties:
>        - description: TI AM33 based platform
>          items:
>            - enum:
> +              - bosch,am335x-guardian
>                - compulab,cm-t335
> +              - eets,pdu001

No such compatible, so it cannot be missing from omap.yaml.

Best regards,
Krzysztof

