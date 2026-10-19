Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921323DCD85;
	Mon, 19 Oct 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417518; cv=none; b=rKp2BaBZF5MQxbGFRCcSMvzsUNI+/pIj6MaLdKYTBZxhhklVXQkDOzGiOBHUcDzyZfeGD/h4vTZDjUVmGW+CjTGxqkNnyw4qVzroHeRIp7LXvA3DAmV9rJm3rVVPJQSH28qKtmEFuZpGt0W6xFtpezSfRsKE1dXNNQuHNt87NAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417518; c=relaxed/simple;
	bh=yaqoncugfCQpSCNIAmM/qNJTAZhZ2Gww61ws/IDHdFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z02DVdZ1VV5pnHmOZjaoOwfwev2CA5xC3BHz9efLAcmyAywEjuB5nLmhF9gw2mTWC1AUOsPa2/cxjvKOnBQQI8RBJBccqLCw864yNdFwuHecVk//IrspgyN7fVLwGWTPnsJmSFo4Azt7UP0HQI33RRLa838qkX4F8lFyGI1Ftms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=14Kci2JB; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="14Kci2JB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=peY+aObVcRc3+z92SmndUBTWbLH2yBpJPFW/B8sgqIg=; t=1792417517; x=1793627117; 
	b=14Kci2JB7JgcO0zwVQA88zYe3ujIIkoUUZV0rDtioFu0OVcOyDd5vu3dmCWvNc+vozZ09LYGjYV
	56dmAA6q5jJlhKA5oiGichf7hm1wqzj8eyUe2FWWbH9cg3zC0JPg2i81FahCX/tohybq1k0DL/gg0
	hRk5E0mOwYt0uvL92YqyYe2kFV+oXuFgNUSuSlfI6uGBMSriXc7fnWcKCbiFqcUwmBRenPhkiP2aq
	rJk1WncSr4CvPgjhMTsI/LvOwXrq3/2iH+zs9MrKVjn1SUyCORkNd3eVG4OpzujzV6PObyH6xaH+T
	+bohyKQC/T3mJFW1BUJoucyqb9Mu33R76UtA==;
Date: Mon, 19 Oct 2026 15:45:03 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ettore Chimenti <ettore.chimenti@linaro.org>, Paul Walmsley
 <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Rouven Czerwinski
 <rouven.czerwinski@linaro.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM: dts: omap: dm816x: Update USB node
Message-ID: <20261019154503.2111a89c@kemnade.info>
In-Reply-To: <8a8313f1-d525-45d3-9044-b5f7a00b256d@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
	<20261016-patch-ektor5-dm8168-dts-v1-6-b4ce30217028@linaro.org>
	<20261017083957.7c2696f5@kemnade.info>
	<8a8313f1-d525-45d3-9044-b5f7a00b256d@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 10:36:37 +0100
Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> On 17/10/2026 07:39, Andreas Kemnade wrote:
> > On Fri, 16 Oct 2026 16:41:21 +0200
> > Ettore Chimenti <ettore.chimenti@linaro.org> wrote:
> >   
> >> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> >>
> >> USB node was not working correctly with DMA enabled as the supporting
> >> code had been updated without updating this SoC's device tree. Bring the
> >> device tree more up to date so that it works with DMA enabled.
> >>
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> >> ---
> >>   arch/arm/boot/dts/ti/omap/dm816x.dtsi | 41 +++++++++++++++++++++--------------
> >>   1 file changed, 25 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> >> index 7f3ef3a00ab8..5be9efc60785 100644
> >> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> >> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> >> @@ -574,18 +574,27 @@ uart3: serial@48024000 {
> >>   		};
> >>   
> >>   		/* NOTE: USB needs a transceiver driver for phys to work */
> >> -		usb: usb_otg_hs@47401000 {
> >> -			compatible = "ti,am33xx-usb";
> >> -			reg = <0x47401000 0x400000>;
> >> -			ranges;
> >> +		usb: target-module@47400000 {
> >> +			compatible = "ti,sysc-omap4", "ti,sysc";
> >> +			ti,hwmods = "usb_otg_hs";  
> > 
> > Why do we still need this? It is depcrecated.
> > 
> > Regards,
> > Andreas  
> 
> Without that line we get the following on boot and USB does not work
> 
> [    0.110148] omap_hwmod: usb_otg_hs: no dt node

It is somewhat odd to use both ti-sysc and hwmod. It looks like a
half conversion.

For an example how usb_otg_hs was converted to ti-sysc for omap3, look at
42a79edd4a3dc1bb8e89fd2849f9e8e1e1c13977...v6.1-rc1

It has no hwmod stuff left.

Regards,
Andreas

