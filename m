Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C997494A1B;
	Thu,  3 Sep 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435988; cv=none; b=sU6EzdTAgeA+IdKGjTVNOoJNviwCpWSerAQVeRBsw4E1203Ro5xODYpOS8kFy5wpOzBQlavdZyYmcrz4Q9tGYKrsddpIufgC9xQVFZedkwEr/Xey/uvG4pPbHEfDYL92C3EcndzlLqy5IBy1b75Pti+2bMp3kFachYVK3qfnhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435988; c=relaxed/simple;
	bh=yBLGsiC5Qo5U7xVpJC95AXV9s4D/tC+FX9uG5XmguZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+p/n5U9Kfd+AkKt0N23wIWsLG8IhNqETH3dJ+ZOTW3OYCJr4GzHRLBkQW6oBB1y0YJQwsLH6AZwJX209nlUhkLCrJin+6OPDm1A79f6ILtJZfZN2B7i0mhvr/I4kwc0rFTb5JUXukGWPTrIVYKW4mYB6XOPwO7ysP1y9IJLHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvU3ngAT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvU3ngAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578CC1F000E9;
	Thu,  3 Sep 2026 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788435976;
	bh=hMqxdzKrWow7jpM0HakJLDnYHFNMOJBE2QIgHGSmMT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvU3ngATjz6jRDjc1JUWES6jaVshC5LwTusZaLg8us52Cv9XxjMgcspOcme5x0yQ8
	 k/GDanFLKF4KOzgg3GZ3p24+zS7F2SeVu31Bh6AptlWJP7qDWW0PKOTVMXrYkHT4va
	 KFfhWplD0KuS9K+jtULivEQX6BM4eX0nKCx3OIbO+WBW/Y/Wp2recyxpOYiTHtwWkt
	 RYY5x75zt9P/fq8kWHamfKRtDVnt68omeHh0aXvbhSCv2ttMpCAeIwl7uqcoMt7pWj
	 +tGc92zy8MV8r8BnW29xdmDDZDs770qfItBSZrvL/p1xBGUv/L/94tfapcLT+qSVM2
	 ZOs6Jk0cER1sw==
Date: Thu, 3 Sep 2026 13:45:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrzej Siewior <bigeasy@linutronix.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Ravi B <ravibabu@ti.com>, 
	Kumar Gupta <ajay.gupta@ti.com>, Bin Liu <b-liu@ti.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, goledhruva@gmail.com, 
	m-chawdhry@ti.com, daniel.baluta@gmail.com, simona.toaca@nxp.com
Subject: Re: [PATCH v3 2/6] dt-bindings: phy: ti,am335x-usb-phy: Convert to
 DT schema
Message-ID: <yawsbme42sxvel5ftn6urvxnqczx6hd2crdnh22abeegfigdnz@tpmzmpc2wbny>
References: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
 <20260901-ti-am33-usb-v3-2-5e15c617d2e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-ti-am33-usb-v3-2-5e15c617d2e9@gmail.com>

On Tue, Sep 01, 2026 at 04:53:06AM +0530, Bhargav Joshi wrote:
> Convert the TI AM335x USB PHY text bindings to DT schema.
> Add undocumented vcc-supply property to match existing DTS usage.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
