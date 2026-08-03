Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3478F39;
	Mon,  3 Aug 2026 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795447; cv=none; b=Awh0bAWFpUquLQWTqoN6B21HAyaJXRJgJJ0m6EGHKMHIGxIOV7fYIbf8nNw+Zj/L6q6+1N++D2B80edWT0kvRgHBAv7aaT6q0FoeDjus0jO0HM+HydlsR+Xx0OJ1y3z/ss341TgFPi0mCbAJSHTQwzJvirnuBzhhieiMgpXQlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795447; c=relaxed/simple;
	bh=6XzzIxTML45VHMRREzLkhjMtOFwy0FLglt1nKSpd+G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gToHS9Y9vxy3Jv31sXFuunZIa7WUq1iD10Efx0bTQieQICZRaE+/GI1iw22RCUzXBHz4iEhyxv8lEb3N5Ok7H7NJmAZYjXZSfNS5PDWD/2bEsEI2te/QsYLOp5UgXE2hJNyl4fi+GrfM8CA5zAxkChJeJli3kUfgkNCs0/52vII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Ec4Kpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Ec4Kpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077141F000E9;
	Mon,  3 Aug 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795446;
	bh=3WeJos72ttiJG8idgzFWMe7RMdPcnTN0tGN50tPiISI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q8Ec4Kppwy2DajK8Q6p+5cIVr2Fj092lxSRbM4bh2aYT2xBlhsWk2M+8Eo0oRVwwu
	 axos48ewmWTJUe2+9y66NM/iDbO8DIksCuVi7GkncoqQXKEhWI2NVIWlf3GjrwLfWn
	 4yzAguu0MpNmEsN7N5YySv1ek7CzP7ePA4xe7fbYPMk5IwDr6XQi5GkBtyiBNvTSfP
	 VFtTCJDWuThG3cQYOyF+bHf64y/NUhPvNe0IBk+K080MozQ+ezSh/AgjIo650PhITE
	 7Hq5n/yefGZvBkxRFUIH++F2Qt7+wRcp23IEij4oL6/Ih/0uXdC2wjre5J8vP34IcD
	 wroZ94RwUKxgA==
Date: Mon, 3 Aug 2026 17:17:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	simona.toaca@nxp.com, daniel.baluta@nxp.com,
	Kevin Hilman <khilman@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>, goledhruva@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, m-chawdhry@ti.com,
	linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Roger Quadros <rogerq@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti: Convert ti,tpd12s015 to DT
 schema
Message-ID: <178579544500.726225.3201826985280204584.robh@kernel.org>
References: <20260730092245.52034-1-egbostina@gmail.com>
 <20260730092245.52034-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730092245.52034-2-egbostina@gmail.com>


On Thu, 30 Jul 2026 12:22:44 +0300, Eduard Bostina wrote:
> Convert the Texas Instruments TPD12S015 HDMI level shifter and
> ESD protection chip bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Added the 'ti,tpd12s016' compatible string, which is used in
>   am57xx device trees.
> - The 'gpios' property now allows up to 5 items, as the
>   omap5-igep0050 device tree routes additional control pins
>   beyond the standard 3 documented in the old text file.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

