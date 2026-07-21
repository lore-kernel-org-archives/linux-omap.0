Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5E373C10;
	Tue, 21 Jul 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641731; cv=none; b=jIZqHQskaUMEkJqTtT0pIFmbdB3BVdDZUQ6yfsB1u5OUbYT3TOJiDgim4XZXTtkUQFtUtBAy/NCSQjpfZsDz67Q5zY/vMVOM/ISPshHgegNWj51TsIFITHCYAlr3XyyJJiljqOFmIh9ITn1qZlR8hCiJDlXVd/jX4+WYCsr1+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641731; c=relaxed/simple;
	bh=R8hKUjFFf72sKXv72NrwNGcuwLtyG57LBbOo2mCIalA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw0n6pfqDdA/dyYudCaMZavhmUqpx/WpzCFHKQnXsNYL5oLdZlJPcjx+5maUeBzm4JwZ+e5OZSAX2Zh0Moa1R5SpOB6CdlZ3WeG5Sx0PMcJd9sPqqa3dIcE38xMNjhdxC0zC2ftAL/YuBePGFaXagQV1EUZUEf+UJPwSOYVlT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S//f9M6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S//f9M6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BAD1F000E9;
	Tue, 21 Jul 2026 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641730;
	bh=WyhWbNjeIszRI66cGBfypyk1T0TvSihAQzn41Wbu1ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S//f9M6F8N8uEpKU3adINPzSiA/cCJNb5s8Yxz7w9zSihNmP5OhScFrEc3OpP06z9
	 y9Rrl57+T62WurLNAqZ6+QMScKYAxoW4qeTFMweYMYf3btrV4vMbjvWe6v5j/9A+au
	 xcl2jLkgs/2oxfwv6xxRlJiqi4TEEB6wfezS3lZkGBkJu6LF+bbFSY6Q+hVvddbqXV
	 HHz4RgcIwF9PsEf64sqlNhIOzf0d3nwv5JourkQopUURsmnm2i999H+zePVigkdqcL
	 rjBtDLJxB1DAdr5uv3EkPM0Aa06bA1uRFB73Cj7vfcBk7qDotLGD8oKlKh024d5yEt
	 zJWU/ZHr9lPwA==
Date: Tue, 21 Jul 2026 08:48:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	daniel.baluta@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	simona.toaca@nxp.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Convert TI Keypad Controller
 to DT schema
Message-ID: <178464172918.3437827.17141697525937347844.robh@kernel.org>
References: <20260719133730.3551691-1-egbostina@gmail.com>
 <20260719133730.3551691-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719133730.3551691-2-egbostina@gmail.com>


On Sun, 19 Jul 2026 13:37:29 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments Keypad Controller bindings
> to DT schema.
> 
> During the conversion, the following updates were made:
> - Corrected the documented property 'linux,keypad-no-autorepeat'
>   to 'linux,input-no-autorepeat'. The old text binding documented
>   the property incorrectly. The standard input subsystem property is
>   'linux,input-no-autorepeat', which is actively used in device
>   trees and parsed by the kernel.
> - Added the 'reg-names' property ("mpu"), which was omitted from
>   the original text binding but is actively used in device trees.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../devicetree/bindings/input/omap-keypad.txt | 28 ---------
>  .../bindings/input/ti,omap4-keypad.yaml       | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

