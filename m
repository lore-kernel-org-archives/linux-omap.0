Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC153A6B77;
	Tue, 31 Mar 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951931; cv=none; b=rLDw+OXuymfADl9Ilc7BERXN6h9Q8nNAuDYrh2FlV2Cyhc8ryDI1ZmQmf8BGCpqT+YT14Mc64pqYx4CoXIY3Y4P/E/TsOAzzX+3a/ZcX0Jiq7Yj+cfVcJBxapbZVCfEoNHO+r0EMws7aUOpF8ha6vCvdfjVZuUCx8nmv+OtWbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951931; c=relaxed/simple;
	bh=HuZ9XGoQtldmCzvMR9gactMeYCZzEsjf+eC61YzxUVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDGMZPpUUFSV0AObEGS/fXg5Bu6TXiOwBuHuVt7uAITpQ7NkdfV9U61Rr1vvm9F/4jxJifWQu5RTA3hG4fTJNv2S1ZIgmTCS6D299yYfMcoI6acUJh2zbZcaMXnyFid57FkwYxdGMLlodAaM1k6ElSmk9q3b7L29skU0GOM9/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSIKhHvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSIKhHvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C368C2BCB2;
	Tue, 31 Mar 2026 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774951931;
	bh=HuZ9XGoQtldmCzvMR9gactMeYCZzEsjf+eC61YzxUVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSIKhHvnNVzyDB7Dbvcg/JqcpGEsuEKR1WQoJEpntULphGGp5lkEGIzKX7pp4Zfw6
	 6wo7s8y0LBbabPjtdS+e+qDBSAC/JlZ4L9wxviznwYPHOwTetC3QqgB6QuC8bNwcbD
	 6ujNKPxHwNC/8NY/Mr/wa2w9LUd/pByQT8Pjrye/7KtvT2gkjGELofJ4W6Qv5z3K7G
	 /YM4vuPuLm9PdXo0fhQIEtkPH4V1wPjiJIdzdCtPxbqi2xlHTg+4e8v0CDTX28MfFc
	 VwjCuhJJsxwt/9aD3QzApBcLwb03siv3rNEXVmPljUloc63KdNzOEV1Rv/8RqfCUk4
	 3Ai2u6sR9BQQg==
Date: Tue, 31 Mar 2026 11:12:03 +0100
From: Lee Jones <lee@kernel.org>
To: Akashdeep Kaur <a-kaur@ti.com>
Cc: praneeth@ti.com, nm@ti.com, afd@ti.com, vigneshr@ti.com,
	kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info,
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	s-ramamoorthy@ti.com, vishalm@ti.com, sebin.francis@ti.com,
	d-gole@ti.com, k-willis@ti.com
Subject: Re: [PATCH v2 2/2] mfd: tps65219: Make poweroff handler conditional
 on system-power-controller
Message-ID: <20260331101203.GA3795166@google.com>
References: <20260324101419.95616-1-a-kaur@ti.com>
 <20260324101419.95616-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324101419.95616-3-a-kaur@ti.com>

---

On Tue, 24 Mar 2026, Akashdeep Kaur wrote:

> Currently, the TPS65219 driver unconditionally registers a poweroff
> handler. This causes issues on systems where a different component
> (such as TF-A firmware) should handle system poweroff instead.
> 
> Make the poweroff handler registration conditional based on the
> "system-power-controller" device tree property. This follows the
> standard kernel pattern where only the designated power controller
> registers for system poweroff operations.
> 
> On systems where the property is absent, the PMIC will not register
> a poweroff handler, allowing other poweroff mechanisms to function.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  drivers/mfd/tps65219.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 7275dcdb7c44..6fa202339a0c 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -541,13 +541,15 @@ static int tps65219_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = devm_register_power_off_handler(tps->dev,
> -					      tps65219_power_off_handler,
> -					      tps);
> -	if (ret) {
> -		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
> -		return ret;
> +	if (of_device_is_system_power_controller(tps->dev->of_node)) {
> +		ret = devm_register_power_off_handler(tps->dev,
> +						      tps65219_power_off_handler,
> +						      tps);
> +		if (ret)
> +			return dev_err_probe(tps->dev, ret,
> +					"failed to register power-off handler\n");

Couple of nits to fix.

The `"` should be aligned with the `(` and the `failed` should be capitalised.

>  	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
