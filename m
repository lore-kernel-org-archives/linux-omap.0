Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413B54EEA6;
	Mon, 31 Aug 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184006; cv=none; b=bHLW1PT206qsgv6rYbuacQ0Axja6BS0TGT5kZH+fCX6dH/noQZO9qds2cuOZw/7/vEAXxuPzqtctFLii4kyGqTsFAlHTVGZ9G7bnmdHw5dajnbY82mSWzwHmFLwk/Ukfg/UzM8ygY2asSjInAepk9kfC/LN4XBjLqEz7sUopgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184006; c=relaxed/simple;
	bh=2hvUmCUeczZoDp0Wb17DcBhCwCeyXPHgaiSzkZow97w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdOGU/BP9OiiP/uP149yyejVvqzaSXNu3xnmX9ZMCnNK/JiRKN769rNJbL60lfdQ3PholkfYhe2tI16m/dB7rd0iY9YY8YnmE5RNA6vHQV/Onb40Dz4jWXsTcfngTW3ZqOlt9UMXYMbaU3upDSafTQnicr6iKRe10KEYJjFc+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBoz5sCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBoz5sCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5531F000E9;
	Mon, 31 Aug 2026 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184003;
	bh=WuuL/Qia19Bav98lglkQeSacGNdudIifkXA5RTiAvGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gBoz5sCvkTv+IpxgCjINmfQLI/+nsk3JGndSv/TnO017Aow/q0iVSC4mAbHpfGpx/
	 bPpsW51y9o7HUjUpNrswwauwEqUuOJx4UAfz+5LiGD/LgbuMBHFp7UG8d2mG5ARuZq
	 V+WMI4E2L78Skuz+5Lt4UsXQtxM60qEtvU1jchU35LFuicOTCT0C20hNDhMIutv4F1
	 NcjNhrwXVaZ2U/ZZVfXHZ4wSXZw1q+xrPGlPuRJrY/T/rZLCXegOBcHhgXSJF+R4k0
	 oyziJoxgDW8+BPV3Lx4X0WJecnCVhB8En8KzMh4gU64E+eUDN4ipQXmXPexxgTxSfn
	 x2z76c9gTa4MQ==
Date: Mon, 31 Aug 2026 08:46:43 -0500
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
Subject: Re: [PATCH v2 3/7] ARM: dts: ti: am335x: Fix redundant interrupts
 property in USB nodes
Message-ID: <20260831134643.GA733140-robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-3-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-3-66fd44d66824@gmail.com>

On Tue, Aug 18, 2026 at 07:58:45PM +0530, Bhargav Joshi wrote:
> The am33xx.dtsi defines a single interrupts property for the MUSB nodes.
> Several board-level files override the usb0 node to use
> interrupts-extended instead to include vbus interrupt.
> 
> Since both interrupts and interrupts-extended cannot be used
> simultaneously, Add /delete-property/ interrupts to the overriding
> nodes to resolve the schema warnings.

Actually, both should be allowed. In theory, an OS version not support 
'interrupts-extended' and 'interrupts' is also needed for compatibility. 
Though in reality, we've now had 'interrupts-extended' defined for a 
long time. I'll look into what's causing this warning.

Rob
