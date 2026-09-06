Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3B30D411;
	Sun,  6 Sep 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680472; cv=none; b=IeAKczDDhznG1J6N1ec6M5NBoSBOtN9WwaC2TJ0IGLK5sfqozx2c4vppPJ/vRRdRVo7eCM4kKujkyYNs0wpk0luE4E6zrPVHadmShiRul/Yxv1GxrtgUnByykyiHR+ET9oocNHUIntydqFtWwzEW3Vj1X5OassmVjpUykVuzBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680472; c=relaxed/simple;
	bh=4xpTTEyla48IxLsIEqP3kWvyfXr/IGLbqWGu48o68RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVUiqxLk5a6Dl78WpUmhfydHIe9+GBrcdETvzQNMNkRD+lWHfi7f/kLesgpet+j5gqBYieL1gOk12eb72nYHYxPvsUlOry6IIhNBZej9Qa8GpIOvTTnLu01Fp3U959UThz72Ezcax1JrcN+D5AiFuurJQMwqxQLgeKEbDhi0eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dfqRBLCl; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dfqRBLCl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=milCblzzV22WWnRAsPChts+TblEkiAOBKPefNK0F9Xc=; t=1788680470; x=1789890070; 
	b=dfqRBLClf5Wmj2AW71MN5j5gtAJd9fDjzF7FFIQHr4O1L+iglUVskg9Pe/WWaLOaRz5mg/jCO4z
	f3egjozzC+gQ7eEQanfer6zr0xLt4pqkLaL92E+jxldNqXplem0aV9u8W8Y67sQLmbunmZ2hHrKhP
	GPjycJyZpA3iTI7z2yqlT6hdDZUIftuWQ4ndYTThxMR3y1Z6JzY6IhaO8JXIcLrQV9AhzqCQ0oyKE
	XPI9A+/lfp+OW+SvuQIhWIVBpdi9eIXwtSh9A/ShBD7en4TetEQlSTc+JC+wkmdofjW4cW4d1UkOc
	y1lnO5c1r3+NhLrrBzH3S+zgfr+0gap025Xw==;
Date: Sun, 6 Sep 2026 09:41:06 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andrew Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Kevin
 Hilman <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] i2c: omap: Remove unused is_rdr and is_xdr
 variables
Message-ID: <20260906094106.41f8d2e7@kemnade.info>
In-Reply-To: <20260904131252.2126353-3-afd@ti.com>
References: <20260904131252.2126353-1-afd@ti.com>
	<20260904131252.2126353-3-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 08:12:46 -0500
Andrew Davis <afd@ti.com> wrote:

> These are passed into omap_i2c_{receive,transmit}_data() but are never
> used, remove them.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 72f979eec7311..68b0a043f1e51 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -993,8 +993,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
>  	return 0;
>  }
>  
> -static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
> -		bool is_rdr)
> +static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
>  {
>  	u16		w;
>  
> @@ -1014,8 +1013,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
>  	}
>  }
>  
> -static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
> -		bool is_xdr)
> +static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
>  {
>  	u16		w;
>  
> @@ -1119,7 +1117,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
>  			}
>  
> -			omap_i2c_receive_data(omap, num_bytes, true);
> +			omap_i2c_receive_data(omap, num_bytes);
>  			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
>  			continue;
>  		}
> @@ -1130,7 +1128,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  			if (omap->threshold)
>  				num_bytes = omap->threshold;
>  
> -			omap_i2c_receive_data(omap, num_bytes, false);
> +			omap_i2c_receive_data(omap, num_bytes);
>  			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
>  			continue;
>  		}
> @@ -1142,7 +1140,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  			if (omap->fifo_size)
>  				num_bytes = omap->buf_len;
>  
> -			ret = omap_i2c_transmit_data(omap, num_bytes, true);
> +			ret = omap_i2c_transmit_data(omap, num_bytes);
>  			if (ret < 0)
>  				break;
>  
> @@ -1157,7 +1155,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>  			if (omap->threshold)
>  				num_bytes = omap->threshold;
>  
> -			ret = omap_i2c_transmit_data(omap, num_bytes, false);
> +			ret = omap_i2c_transmit_data(omap, num_bytes);
>  			if (ret < 0)
>  				break;
>  

