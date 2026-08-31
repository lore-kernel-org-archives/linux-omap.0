Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5C43030D;
	Mon, 31 Aug 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184710; cv=none; b=GIguDuaZHQs4nJSgdlQDLWWyODvHWgputL2NYGsrNY+H2KudcM0+s46CL8CSvfUjyaTaKcH8pwHmGdzy6NC7z8Qmxu4e2sLSP1b82R4w4m0ZC68kXHFvqJnWlZN2k+L1YmvSyfpoGHF1duqLUAX4cOwjUb2NGTgWdHQwl6zBWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184710; c=relaxed/simple;
	bh=OCIkCK8GjJUPL8sS1/j/IKVAhXSxaMv1qdDC2TaZtsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4cjd8ypNf2+9MJgUyL7peVrzXb82qPW4cGAaRM0w9/iNeVx83CxoEgaWjLnAitMFw0KhJjtH+Tnn5ZjLS3NneAYg5JAVCfFonWvWQcW63PhmtJGAvNRSDiwn51gY6lm/1epuDsCa0zxYjR6Cy1cZf1o/DqBsevUMA94c8fIL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdqLaXih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdqLaXih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B861F00A3D;
	Mon, 31 Aug 2026 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184709;
	bh=r4FUrt/nYBi8xw9X/sReG04XatlbwM5ezTHAFlmHdWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WdqLaXih+4Ff/ojPfjYz1IC08U9BMeFD9FsF6tLqlbFzQQKlWW2Hw965PaYUV9LDK
	 K8UnlHVbg0TA22kD9zuR8GwH053Vj9iXmVga9JVeOq+l3rg8sHI0v7rMzD3IFeG7oh
	 8b1VcW2PQpyzAmbIXa5KipF9aDX85dkBIYWDbTUZgHpRngmFTHp+MoMCzEW/0wZcM1
	 RfeaidPUbVY13G/9/Eec2wfmML2NtZG0AYfXHeAHeSwcl+2ypWM53O8qftoU3qi8ww
	 8ekv+AcJfe/ZscLjP5CEuxeFbs7DMsDRb6TJYIxfs9yjWZWBRcBABnNBcW3Zx7ci/0
	 /mO6rrMOAqEkQ==
Date: Mon, 31 Aug 2026 08:58:28 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Siewior <bigeasy@linutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-omap@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH v2 0/7] dt-bindings: usb: ti: Convert AM33xx/DA8xx MUSB
 bindings to DT schema
Message-ID: <20260831135828.GA769102-robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260831134823.GB733140-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134823.GB733140-robh@kernel.org>

On Mon, Aug 31, 2026 at 08:48:23AM -0500, Rob Herring wrote:
> On Tue, Aug 18, 2026 at 07:58:42PM +0530, Bhargav Joshi wrote:
> > This patch series converts the legacy TI AM33xx, DM816, and DA8xx
> > USB/MUSB text bindings to modern DT schema.
> > 
> > The legacy am33xx-usb.txt and da8xx-usb.txt bindings was historically
> > structured as a single, monolithic file that documented the entire USB
> > subsystem (the wrapper, core MUSB controller, PHY, and control module)
> > all together. This series converts that monolithic text binding into
> > proper, distinct DT schema files for each hardware component.
> > 
> > Patches in this series:
> > 1. dt-bindings: dma: ti,cppi41: Convert to DT schema
> > 2. dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
> > 3. ARM: dts: ti: am335x: Fix redundant interrupts property in USB nodes
> > 4. dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
> > 5. dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
> > 6. dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
> > 7. dt-bindings: usb: ti,da830-musb: Convert to DT schema
> > 
> > Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> > ---
> > Changes in v2:
> > - patch 1: add interrupts as required property for am335x-cppi41
> > - patch 4,7: add pattern constraint for dma-names
> > - patch 6: remove deprecated property ti,hwmods from required
> > - Link to v1: https://lore.kernel.org/r/20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com
> > 
> > ---
> > Bhargav Joshi (7):
> >       dt-bindings: dma: ti,cppi41: Convert to DT schema
> >       dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
> 
> These 2 can be sent on their own.

Nevermind. I see they are a dependency on patch 6.

Rob
