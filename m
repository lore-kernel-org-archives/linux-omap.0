Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A739A7FD;
	Sun, 13 Sep 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296976; cv=none; b=iW+OSWmJZECzIUB88Jwv9KsTaRSzL4jNuM5v2ZOa3idorhZ6hOwNZLNlYUj2ycdpceqomXYRnUCdUpSKvnTWWRoY9GVo3i6oOPZ6woD5CXIBsce31hp1OV+eZgfJLYzWB1x1GhRThTeGexNSk/GwkoS4nQtsLLvBVZ6zBdan9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296976; c=relaxed/simple;
	bh=7ubeAAyHtUCqKkbil7Po4o09ZBnt0PzHujBmdjsk5FQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yu7looPzEPeDpqT/ALZANDesiHssB03e5JHuTQabrdN1oeod6YnbhCEHexUorf4NSu3D+3kNWpcgdXwCvewo+0rrhCNCYYTqgmXyxb29t6VtbCo2RMcAqNnPOPjuFbfYDR5USpVIuPY5/RU+uzkDlQGsIf5Fu1BV3+NvVnZjv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/sNjYhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/sNjYhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19EA1F000FF;
	Sun, 13 Sep 2026 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296974;
	bh=1E+3zT5+AFY5HsBkytRy0qAOs60eN0gIe0F3fPyn5cs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d/sNjYhIV8u8d9OTU8spf2F8kS6kn6a/61zNB87Hhk1yUlfdujBsPs6JC6rTjLhcm
	 +4yASwB5k6DuaAhQzz2NVSFnBij767CxyjI37k3cCYc/PM8I+9OGRRsDPbMESqJ4hL
	 x3zHzx/KIQUtulNa7gA7JKlo5A4RmJhbYsdHjvd7+IBdi1CpN22uayjK8Wq1oszekU
	 KuhwoyymHWnJ/c8XMdC3gHR+T3HP5JrcmV3ymRIMhwnaTReqSGF1jH4oFN6P5A5e9v
	 stMsnz7IL85DHYHIJh6SV0Ph3nkQRr1N2u/aOhZifIXlQDaQbIpOGgw+4tzWL99KKP
	 ery+l9IX4xLdQ==
From: Vinod Koul <vkoul@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Siewior <bigeasy@linutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Bin Liu <b-liu@ti.com>, 
 Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com
In-Reply-To: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
References: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
Subject: Re: (subset) [PATCH v3 0/6] dt-bindings: usb: ti: Convert
 AM33xx/DA8xx MUSB bindings to DT schema
Message-Id: <178929696522.215437.7415038223377986822.b4-ty@kernel.org>
Date: Sun, 13 Sep 2026 16:26:05 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 01 Sep 2026 04:53:04 +0530, Bhargav Joshi wrote:
> This patch series converts the legacy TI AM33xx, DM816, and DA8xx
> USB/MUSB text bindings to modern DT schema.
> 
> The legacy am33xx-usb.txt and da8xx-usb.txt bindings was historically
> structured as a single, monolithic file that documented the entire USB
> subsystem (the wrapper, core MUSB controller, PHY, and control module)
> all together. This series converts that monolithic text binding into
> proper, distinct DT schema files for each hardware component.
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
      commit: ae6ee6844d5aa621f3b807dfc1ae532e975f079d

Best regards,
-- 
~Vinod


