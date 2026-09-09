Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956243AEB2C;
	Wed,  9 Sep 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967939; cv=none; b=fACxqn+JVlc0Bogol5Knm2F0tY6ltQoKAuZD5G2WdO16LM6Bi1vyeYA89RszYyKin9K0+Uuz4wXX3o1y0rl2l0uhNViySXyfUVrTz/ps38m/aAvjDFDy2OuaOw+S3frdYo/2zqB1KoPOBn4ejjae1l6cUKu5kO1YNyNec7s21/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967939; c=relaxed/simple;
	bh=XGeiZ9dLZLsr9DS2/J/+J3Y0FtcWfQo3TB5UJ2Y7SNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Crn41YrwUxUIns3TnHPyn6iVEHh6ChKZ4Ruwwj0Z7wHsgDmQStWLjpNXVwDIrFlfnMPeipCoGY8MXnuGQZrofNz1NrEv0xG4BdoyImP/Spl3kUSh6GhgLJ0vbZaxHJV7CQy7YCcBjueScXuUlrlkTIXm7zbk8ixeGdjlSkfNEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABQ99Fcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABQ99Fcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CE1F00A3A;
	Wed,  9 Sep 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967938;
	bh=IzQ4BNbF6faCBeB/IFPsIGfhclYL1yNQY5hzJO1XqG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABQ99Fcr8z6PssIHhGeNIOA/6HUbkQzaWVgO6zSij2p6NYH7OmNRNz3AVuDosKmBs
	 1JNogt/yg00/i/cMm5P/kBQQEMczqsp8eP2H+w52XZ4cPzIserfY9oa5Vh8qLs76pk
	 SuiIEskCsG8ElEFvueS0iCgg9TnVVYM8YEPvx/SCZCkl2eh5G5n/XhfBY5EQpj2bVx
	 /DwaaLm+v4SvMn+rX+l8XyWdF8k5QQkt0t/8Cjp5P1af27FsO6NdqmnIO7B/6+/01z
	 dHRa59ZxK8pf2P6Hr5mmVgUNclXsS7l1qhHL5SACfOtkCkc822XNTwgEvo/xudpxvH
	 vvM7goXuY0qfg==
Date: Wed, 9 Sep 2026 17:32:09 +0200
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
Subject: Re: [PATCH v5 3/7] phy: cpcap-usb: fix IRQ teardown race
Message-ID: <af7ikpyy7rheb5d46wpwn6v6sfwh4ncmgb2bcwzbl5flyikseu@mj5q24u4omun>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-4-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-4-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:06PM +0300, Ivaylo Dimitrov wrote:
> there is a race between IRQ handler and remove:
> 
> IRQ thread:
>     ddata->active == 1
> 
> remove():
>     ddata->active = 0
>     cancel_delayed_work_sync()
> 
> IRQ thread:
>     schedule_delayed_work()
> 
> The IRQ handler can therefore queue detect work after it has been canceled
> during remove(). Free the IRQ handlers before canceling detect work to
> prevent new work from being scheduled during teardown.
> 
> Reported by Sashiko

Add a proper tag.

> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/phy/motorola/phy-cpcap-usb.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
> index 7cb020dd3423..741145c89e5b 100644
> --- a/drivers/phy/motorola/phy-cpcap-usb.c
> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
> @@ -393,6 +393,19 @@ static int cpcap_usb_init_interrupts(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void cpcap_usb_fini_interrupts(struct platform_device *pdev,

s/fini/free

- Mani

-- 
மணிவண்ணன் சதாசிவம்
