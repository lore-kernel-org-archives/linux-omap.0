Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CD345ED0;
	Wed,  9 Sep 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967207; cv=none; b=JWJzvOc7zX4j5mdaoQeG49wVvWa2GReFn0aCw6hg9VkGjpl0pvevnc9+Yq+dr+lTTOvnbCBcLuQnmXSf2wuahwkMTbgPzWX7jzBhhLQbiHyMfK7UHimiEidlIXlGGu76S2HLUVX2fgW/xqmp0I46FNY3mBKJ8lftwHG04TfcJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967207; c=relaxed/simple;
	bh=KmN7W4y7IaXOMBm1H+2QxlAd6Kf7FbOwJUq06cAzNFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSEjD5AsjyOM+1kPAaY95KdvRYjakLH840uhUxh8pw8ViZ5oT/XOKFeEF0UBsjWRuEUYuie2hJlkf71zD0LO5ZIg6N6R0Nu69iv+SyZ2oIwmhPGG4dHCmqByCkBWt++fRC2/OuwcwmEF/0xtsgQdYuuua5OjmlX4MM2rDSbsUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeC8LSHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeC8LSHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927A71F00A3D;
	Wed,  9 Sep 2026 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967205;
	bh=BCrgQdZDo3aLB7xh/LkoFLAu6AOAJTFKPiP9EgRixRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PeC8LSHLI5XHUn2A06mQpcJs5ZdXNvUNb3idIWAJsDTh9QQxbPGDGTozG1i8azmYA
	 jFtoAKTgM2ToU7+E3Itjsn/88If/it86QQ2g9Ef80U8ig+mENAvX5HVcWPrOQCfIFg
	 0blWn0cCVYG9EEbd6cVN92eRVafHnhRZjpbHVp9cUehnVIZrgotHJC/Ns78zw72zyG
	 ff86mR7Db+lMB5+oIun531Q/+iq3IJv+OCwsnuZKE6I1QhLlypm3NFu62AGf3R5es0
	 u+SVtihCUii2hW82R3HElQ95Ok+SKrp68hYpORU0un1EVzgq/xRmsW9kbizr5hsXaR
	 ejZ/Vo6XMnjZg==
Date: Wed, 9 Sep 2026 17:19:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 0/7] phy: cpcap-usb: improve charger detection and
 export cable state
Message-ID: <bb6uewt4jilrgeruehxl44ewuvkqhnl47ujgglhdk77zdvawas@avmjll6c6bgg>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:03PM +0300, Ivaylo Dimitrov wrote:
> The Motorola CPCAP USB PHY contains the hardware state machine used for
> USB cable detection. Besides distinguishing USB peripheral and host
> connections, it can also detect dedicated charging ports (DCP).
> 
> This series extends the CPCAP USB PHY driver to detect DCP connections
> and export the detected cable state through the Extcon framework. It also
> makes the idle UART mode optional, allowing the PHY to remain in its
> default USB detection configuration unless UART support is explicitly
> requested.
> 
> The series updates the Device Tree binding for the optional charger
> detection interrupt and the optional "safe" pinctrl state. Corresponding
> mapphone Device Tree entries are added to describe the charger detection
> interrupt and enable the safe pinctrl state.
> 
> The charger detection interrupt is not currently used by the driver.
> However, it is added to the binding and Device Tree because it describes
> a hardware capability of the CPCAP USB PHY.
> 
> The series has been tested on Motorola Droid 4 hardware.
> 

Due to mangled CC "--cc=linux-phy@lists.infradead.org" PHY list was not CCed to
this series. Please fix it in the next version.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
