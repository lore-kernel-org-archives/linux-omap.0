Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1504AA41F;
	Fri,  4 Sep 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531672; cv=none; b=LXK5Cv5I2Tn5sEYZpGfRzm56T9UAx5Ht4Vd0BNmZuo/i6fynJTf2pPWrPPV5s4c1gazVhLKYNpRlNbQmRwhGXr7P5X3hqRjMqwP3aI66A69IHa4B8jAR5Uzr8oV/50Fmt837G3wXmbDlC+gEe8unLglCOvNDmS3jvwFd7GCJvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531672; c=relaxed/simple;
	bh=NMqR8rOzZ9pIXQI46p/r7yGV/Ufqh7GeI8P/WtA7WK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUR2TFZV6srcYhBJoEK4jRQy9Dg/+56rNs5IjSM2l5WYo7ENMp6SHpY914sXDQXEbcmhoPVhpgOhg0v45Yynv7gR2AWZJfZMa8Tl75+4oGh4YKucPsrdzVM9znG+sMhKCIfE6iMD9rdW5JCTb+YC20V/6pwzkg1jZnnDqXRC4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.113] (unknown [123.118.210.34])
	by APP-01 (Coremail) with SMTP id qwCowAB3Se1v05pqrLYrBw--.65223S2;
	Fri, 04 Sep 2026 22:19:28 +0800 (CST)
Message-ID: <da1da563-1011-4b0c-a480-9d3d3acb6441@iscas.ac.cn>
Date: Fri, 4 Sep 2026 22:19:27 +0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 25/33] net: spacemit: k1_emac: Remove comma after
 sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, mailhol@kernel.org,
 msp@baylibre.com, florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kurt@linutronix.de, hauke@hauke-m.de,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
 linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com,
 clement.leger@bootlin.com, justin.chen@broadcom.com, dlan@kernel.org,
 rogerq@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 andrei.botila@oss.nxp.com, amadeus@jmu.edu.cn, kees@kernel.org,
 tmshlvck@gmail.com, c-vankar@ti.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, daniel.zahka@gmail.com,
 nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com,
 haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com,
 lgs201920130244@gmail.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-omap@vger.kernel.org
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-26-s-vadapalli@ti.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260904043724.2955444-26-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAB3Se1v05pqrLYrBw--.65223S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW5ur1kJFyxAr18Xr1UZFb_yoWkKrbE9r
	1fXas3Jr4DCryv9a4akF1avrWkKrs8Xr48Was7KrW3ZasrWr1kArWkCF97t34furWrXFZ3
	GrnxKF48Aw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUnGZX7UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 9/4/26 12:36, Siddharth Vadapalli wrote:

> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index f7f16397a2c2..29385d78fc4b 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -1161,7 +1161,7 @@ static const struct ethtool_rmon_hist_range emac_rmon_hist_ranges[] = {
>  	{  512, 1023 },
>  	{ 1024, 1518 },
>  	{ 1519, 4096 },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };
>  
>  /* Like dev_fetch_dstats(), but we only use tx_drops */
> @@ -2066,7 +2066,7 @@ static const struct dev_pm_ops emac_pm_ops = {
>  
>  static const struct of_device_id emac_of_match[] = {
>  	{ .compatible = "spacemit,k1-emac" },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, emac_of_match);
>  

Acked-by: Vivian Wang <wangruikang@iscas.ac.cn>

Regards,
Vivian "dramforever" Wang

