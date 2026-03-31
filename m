Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E93DBD7A;
	Tue, 31 Mar 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945334; cv=none; b=Zsf/ohhMdnJeQ7x14g5oetuhazGYOjPdXitgJZsiK7zaFKble/cQ4g+gyFlZ89V63NYg0J5gv/HnPa7DN5kh1t6C8PfFZN/zkHnXfj7VyCTitpWj9ApZ8ZFH41AhxHJiSPtT7VgMyOCaxzK2Lr8xGydqsMrjEi+GGWZ/f+G43z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945334; c=relaxed/simple;
	bh=Hp8eMx7rftF88KA1BsTc5K5MEy6Ut8Cdy/MLrZMRTZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+0f6pYaMmOUnAn3L/ByZ9uB33+YMebDwXWVKWa1FChJDd2eW3DrvzunD+MwFDqBY/XMfJiG0Q8rdALdij8JUmV8v9FaL6Dyb62hyXZOfIV6ITIrzaVegmxCLl989L9/CMkcwF6g3QVAIUyZUpLCgnLh7mSsvKowThfc7DPxfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP5yEC0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP5yEC0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B731C19423;
	Tue, 31 Mar 2026 08:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774945333;
	bh=Hp8eMx7rftF88KA1BsTc5K5MEy6Ut8Cdy/MLrZMRTZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP5yEC0SMPSKrCNMjlPa65nmmuTnZux/DopA2PSnCiTWdoDhLHJ4EJPWieMjhJwRQ
	 4Z8f1QXlqMrzUONUs0AL1pHVw5a/aL+2bWh1Rglq5zuYUhJRkhDk2ABl6spOZX92en
	 GHE7uTUcCbxiWkpop5lH7t4m2u18+5oZ3RnU9ALxmqnwsqhiX70/1skfSg1RPVpNqr
	 NANfs2cr/+hsK9x7b+amV/GizuRPCH4jnjg/5j7K/JofsbqLFY2130+iAYR7cyca3T
	 Jrwwu9wBLckyq5QmlOvyej7cug7X2TFYQIhp1oz0/8RS3ObkQNy2n+y1hP0vq+0SbG
	 DWXln7806NiyA==
Date: Tue, 31 Mar 2026 10:22:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: regulator: ti,pbias-regulator: Add
 pbias_sim_omap4 regulator
Message-ID: <20260331-funny-impetuous-bobcat-eb56af@quoll>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-2-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330-omap4-fix-usb-support-v2-2-1c1e11b190dc@bootlin.com>

On Mon, Mar 30, 2026 at 03:43:59PM +0200, Thomas Richard wrote:
> Define pbias_sim_omap4 regulator for OMAP4. This regulators drives SIM_VDDS
> supply and allows to unlock USB I/O cell.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> index 3e020d87701b..908fbb46b5cf 100644
> --- a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> @@ -89,6 +89,7 @@ allOf:
>                contains:
>                  enum:
>                    - pbias_mmc_omap4
> +                  - pbias_sim_omap4

Names cannot be fixed, because they represent different board naming.
Why growing the deprecated style?

Best regards,
Krzysztof

