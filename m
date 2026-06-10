Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAF37C918;
	Wed, 10 Jun 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121420; cv=none; b=JYM76MWC15KZVzBSxLCuT4eQiob/dVpUlaPibmNau2vHU/xIdQ5u8h7pZqJakW+nC8JPfrLNgUnlfJ76uw1ymY06xF3OjVSDCrOxxpAn9XAwvN6+4bpi5ETAAsvw13KY8NhfK8uXc1mRhpy47iELzcjmNh5Mx57BUfNPtlmQa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121420; c=relaxed/simple;
	bh=60m14k3ug7rkjZ5HNntZVgjfoJWPTbaV6FQBG5ZBaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7mS3vHP9H6f2/4TCQpLbNPB9VRqrNEIvXqc/p3C2QL6jqY0nIoXBHUqjpUqOdJDkISZz4XvZlNBoF2j03Y6Mkwmf3b3Hkg8kazXkQbMXnQQ8eGRmBQMOS0t0nNdCV8fxdIGSAIgaCD17J+ULJdqJ0KLbguRCcKqsJHyegf90fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZD7IH/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZD7IH/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E38E1F00893;
	Wed, 10 Jun 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121419;
	bh=PsXWJz3pz2YehjlcQAeEKNoP1bN13bnKJ9sSW6nurTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZD7IH/PKVpckmynPD1mcJ8fX6ua5wYxioTISIEorcXzlVNFZLyLebpzRK99Frylw
	 Cd6um5oXylE89B9FEj0WKc3QKPwPFEPeHcGXrOO1OK0uM4df9+LjXyxsyBZsmH1YoB
	 Sg1LJJd+Pj2e76m/Xu2iMbkYr1kgZzK9WeAQfvOoAEmVH95M+Nbrne1p80VLXrh/9Z
	 nxf3EoSpCgMevN8ZDVCKLp1bs62Gg4/Q+4E/nJdGlGjTVoyg7rljCLyHv3C+U+TWko
	 oaxaUkuvC7ZTZMKO8sVo/4RUMcfIz2RATCRg3YpvQ1vhBuP9ry9oC1tBwFH7hb67Da
	 CvjzqQRyWYUWQ==
Date: Wed, 10 Jun 2026 14:56:58 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Sricharan R <r.sricharan@ti.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com,
	daniel.baluta@gmail.com, simona.toaca@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: ti,irq-crossbar:
 Convert to DT schema
Message-ID: <20260610195658.GA702518-robh@kernel.org>
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
 <20260606-crossbar-v1-1-f67f7cb9ee50@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-crossbar-v1-1-f67f7cb9ee50@gmail.com>

On Sat, Jun 06, 2026 at 02:26:10AM +0530, Bhargav Joshi wrote:
> Convert TI irq-crossbar binding from text format to DT schema.
> 
> As part of conversion following changes are made:
>  - Add '#interrupt-cells' as a required property which was missing in
>    text binding
>  - As irq-crossbar is interrupt-controller. Move binding from
>    bindings/arm/omap to bindings/interrupt-controller
>  - property ti,irqs-reserved is defined and used as a array but other
>    binding ti,pruss-intc.yaml uses same property name as a unit8 bitmask
>    which causes erros in dt_binding_check. Update ti,irqs-reserved
>    property name to ti,crossbar-irqs-reserved to resolve duplicate naming.

Defining a new property breaks the ABI. We will need to fix dtschema to 
handle it. What's the error?

Rob
