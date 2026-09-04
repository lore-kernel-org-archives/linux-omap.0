Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B144BCB4;
	Fri,  4 Sep 2026 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516013; cv=none; b=loid03LXloZkRuYa/26C4Al7uHntQsq5SvB/vcQIy/bnpYj2hbi+jT5ExCE9xkPBhlJFBkIFjMT0e2IUMsYLhoXOPludsxuSjDtUoV70TYRIxVXbZIUz1zFVAgRkzSxFpZsIbqVSWncoGmvRCeccXE+YIMqZAqK9pauFtjors90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516013; c=relaxed/simple;
	bh=4vIUmkA6Pe9QUAFpPsHhWTe8LIuufy8nVnd/oha/RPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prZdHStyGeHbcxofOeDNkc/cM3uax73nIu8FNBGzYVkzXjyEeT8WuNnmabJu4/bNOIU3+k+a8hMFmzl6CoCVl5H5ZGuYHEYRQyCpFjLugZJO9tzZtTYa0PrKIB1TKBfWUJMtJQFt/uosO80WZ6JFAZeFr2Yq6NmpeuGJb6uUsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x2Qi8-000000001t9-2vtc;
	Fri, 04 Sep 2026 09:59:52 +0000
Date: Fri, 4 Sep 2026 10:59:47 +0100
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
Subject: Re: [PATCH net-next 16/33] net: dsa: mt7530: mmio: Remove comma
 after sentinel-entry in match-table
Message-ID: <apqWk8Fh3WhEjzuI@makrotopia.org>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-17-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904043724.2955444-17-s-vadapalli@ti.com>

On Fri, Sep 04, 2026 at 10:06:22AM +0530, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/dsa/mt7530-mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index fd68b1cd0630..cf3bdb23a2d5 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -14,7 +14,7 @@ static const struct of_device_id mt7988_of_match[] = {
>  	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
>  	{ .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },
>  	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mt7988_of_match);

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
