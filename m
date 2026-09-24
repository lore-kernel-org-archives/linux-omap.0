Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DF4BE441;
	Thu, 24 Sep 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286804; cv=none; b=tkXjAd1x8uZEJGVPtiAAXSU+B0VlS2BKIErH5Ok3+4/v/g0ezahOJWHtLcx8/9Y3racFn7xydm4CBJYM1UBGfro3r5JMAGDrdb9Q66DARhCzizO/poon4SK7Yqr3zt43QhjjDUr1AQ9C74sbdRrxkk6YpmCrntiEV6nqMuzHMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286804; c=relaxed/simple;
	bh=MGzMNVhVVuAFd8wl97KcZDnOyfpU99lFpqrooHUwH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBr1Umv6hII+Q1mOkODZM621Z05vkj65EpmlyHQwXfhBUD2Qv/IbaTnq17+0DtJ/wZj17ZKb5R/ICaVofEU/lI3qRULZhU1oafYv0OIXNfdgZJyGWpDa3ywXsp7DBpsYWon5QntUONipqj+dE2ypSxronbE00W57kp30SVKFEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkoi/sO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkoi/sO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BEF1F00893;
	Thu, 24 Sep 2026 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790286802;
	bh=Ogr79LQ3rrbCZxJzcpqWXVBpLNfY+VyA7LvCCLZnVQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mkoi/sO04MomiAeKafvvlxoZSmU1xCcMWZQisp4s7UKkV2o1rfgcenihrMFiM8viy
	 wfCBFiDGLDUuTY8WgjIQJQZsF1W0Lgs2ENuA4fjrHRjsB06q9dffHq75sP8qQFIA/T
	 amJ70IgK84+BzkunwTPVSb3gqfGZ+G0G0k9puWnvma52XvaUJW7uKXZVZaKUs0m7gc
	 h35AqVpQsTgcvFgMoCAg9tfrJB4lebSTVwEUoDsaG0jgxd+RyuLcDdzHgklMDUMLgN
	 qkmITZzyWKtCdRcKjBJ6mxxG2I6gJCPXDGbS7q9dBjo7R1spsSAMO5g6LaTkiX/XUp
	 utjUvhvQPzp2Q==
Date: Thu, 24 Sep 2026 16:53:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Tony Lindgren <tony@atomide.com>, David Airlie <airlied@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <179028680032.1886779.12172352669683602550.robh@kernel.org>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916123210.107841-1-quchaosheng000406@163.com>


On Wed, 16 Sep 2026 20:32:09 +0800, Quchaosheng wrote:
> Convert the TPD12S015 HDMI level shifter binding to DT schema.
> 
> The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> and ESD protection circuitry. Document the two ports it exposes between
> the HDMI transmitter and the connector.
> 
> The tpd12s016 is software compatible with the tpd12s015 and is listed as a
> fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
> of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
> using the tpd12s016 must list both compatibles.
> 
> The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
> driver obtains through devm_gpiod_get_index(). omap5-igep0050.dts lists the
> DDC SCL and SDA lines as two further entries, so allow up to five entries
> and keep the property description focused on the ones the driver uses.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v3:
>  - gpios: allow up to five entries. v2 claimed that no in-tree board passes
>    more than three, but omap5-igep0050.dts passes five: the three control/HPD
>    lines plus the DDC SCL and SDA lines. The three-entry limit added in v2
>    therefore broke dtbs_check for that board.
> 
> v2:
>  - Reword the description: the TPD12S016 can only be used as a fallback of
>    "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.
> 
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

