Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C5446857;
	Fri,  4 Sep 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516008; cv=none; b=SsKx7fL4Hu+On8ws+t5kAMAVtC6wN6UM3vFVp8IVZPNe62DGMEKYB23QrCM0i/DbMUM5EqAkto7WqV6NfyHF3mPR1+0SSmL8pnPXO4cpw0Zobpba0HqeBDE4LaVMLMupf0xAOVslHCd1RBlN8rTJNb8dL/nNybRgGVSxJ/AE6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516008; c=relaxed/simple;
	bh=w09DMddOuGH16pShKIio3HoUGAGCtGbJiCYSRyp434c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhZ3nbpgs0QStH8VxSUkPPKExr4/XLfyXEtF24Bu5QvFtLSlBVhGqoG6OU9IKcYbeQUTW01rCAE24n5TolA2Kx3s5VXg8bTdV4AkcSixf8gZeAP+cqa5QGY8vXUY4FaPn820vGEMJvvjKKbEEzQHrRQYq69YntVFK1CD6J9vhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x2Qhj-000000001se-1EmA;
	Fri, 04 Sep 2026 09:59:27 +0000
Date: Fri, 4 Sep 2026 10:59:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de,
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kurt@linutronix.de, hauke@hauke-m.de,
	chester.a.unal@arinc9.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
	linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com,
	clement.leger@bootlin.com, justin.chen@broadcom.com,
	dlan@kernel.org, rogerq@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, rjui@broadcom.com, sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn,
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com,
	c-vankar@ti.com, horms@kernel.org, vadim.fedorenko@linux.dev,
	daniel.zahka@gmail.com, nora.schiffer@ew.tq-group.com,
	v-singh1@ti.com, oss@vassilevski.com, haokexin@gmail.com,
	alex@sverdlin.org, aleksandr.loktionov@intel.com,
	lgs201920130244@gmail.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next 14/33] net: dsa: mxl-gsw1xx: Remove comma after
 sentinel-entry in match-table
Message-ID: <apqWeTNBFzOJptkf@makrotopia.org>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-15-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904043724.2955444-15-s-vadapalli@ti.com>

On Fri, Sep 04, 2026 at 10:06:20AM +0530, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index a1104b2f92a9..347e16e9fdc1 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -918,7 +918,7 @@ static const struct of_device_id gsw1xx_of_match[] = {
>  	{ .compatible = "maxlinear,gsw140", .data = &gsw140_data },
>  	{ .compatible = "maxlinear,gsw141", .data = &gsw141_data },
>  	{ .compatible = "maxlinear,gsw145", .data = &gsw140_data },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
