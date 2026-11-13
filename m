Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607413;
	b=n1n8eFgYTh3nFnls4h3ac4vAXD9QSAjawLkCrMzJWkCqM5Pg3C606jinzihJ6S3bQKBG
	 UHmw2CezwGzejuappy//DTT/EtIBZlbiB+xEjxhh/oj0Ib4151cuBuAo8K8JmebE/RTYw
	 nmiGv0myuNHg/r0th9LAb5zG4/voz71HEQzAA5kBpO1BbaO/qEmtYbOR7d/G1VQWyYqbE
	 0atl/ZoW4Dd3JEx4eLPFXhgH5sa1IRA9cLtVHEaK+RR38X2ZY9moWMuDJB+Z7hp2im7Sh
	 zQQv/AbXBysfzpt47bE3HjqlckLgsPh/0vu8Zut1cKmfccDFKbPEwy/302/Vll/NCTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607413;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FcupKOGqfpw0UNQH/cvoTfEyJODmJfv3s32n2xsq6tc=;
	b=0z/rykEK19T8Qw43B4jX7O4lVYWVw0asJzJ+TYrMRfyQQXv/nEQKxkGWYr3a50dPr0/x
	 5Ab7AG2E042O1LOL8pg0YB+HLLD9HIzGYgbUe3oGrtRUG022XS0/cMXATtqyMpgQa8e97
	 WoAdFfImJzIOLoRJFcobfFFGpfM6Bp0MFYFrRN/03xBBPWQjjf2b6VxhnGiCPAGkyFhR0
	 csBoBOwH//DgBazmhquhhw8E2R1nvgIGjA/DtS5s5TYE3Qb1gMjbbjlCtVbI2t6JJGXjk
	 qE12JEjAKy7Z8shNS9hb2NLPPBELah/z9qtOgsxQyfuy9GnIZGZm3I6Hrgsw9DqwI9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=WTcF5h3A;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAD606A334;
	Fri, 13 Nov 2026 22:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAAD606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=WTcF5h3A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=FcupKOGqfpw0UNQH/cvoTfEyJODmJfv3s32n2xsq6tc=; t=1794607412; x=1795817012; 
	b=WTcF5h3AOOpUMW5KkWJxKDXVXYIh7gW4I7Cx8Dh6TfCtMj2hZaDVN+yV02G8hQ92S8FDQlMsSFR
	hEXYkpYGR7yv/pEnY5AaoQaq5fsZpGhOjY1wvn5g942Xr4PhuC6Fic8CCYJ+ilezTWWbpEAJxSiMO
	wQB7qLt5JLAnAl6OzAHmh9bPNsHkNqbrPtaoXJbtm6RLTUxbK9M8EJDRDxKmcfBVqphlGL/Q0E3Dw
	7LVFMwuEgUQ4ccbckeA15qWVXT1UF9l4vjDNzE1B3bCSGfT5gwqDRFccD6+GuQdEPLLWwzti95K4W
	CTuAQStTJcbiysEDOgsUeTyup9NuDk/t1uWw==;
Date: Fri, 13 Nov 2026 23:02:08 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Rouven Czerwinski
 <rouven.czerwinski@linaro.org>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] ARM: OMAP2+: ti81xx: use non-scalable voltage
 domains
Message-ID: <20261113230208.68ec07dd@kemnade.info>
In-Reply-To: <20261113-patch-ektor5-dm8168-clk-v3-4-a42cd1edc5f3@linaro.org>
References: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
	<20261113-patch-ektor5-dm8168-clk-v3-4-a42cd1edc5f3@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 22:30:50 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> TI81xx SoCs reuse omap3xxx_voltagedomains_init(), which registers the
> OMAP34xx/36xx voltage domains for every SoC except AM35xx. Those
> domains are marked scalable and reference OMAP3 Voltage Controller and
> Voltage Processor instances, which do not exist on DM814x/DM816x, and
> no PMIC data is registered for these SoCs either.
> 
> As a result, omap_voltage_late_init() tries to set them up on every
> boot and bails out early with:
> 
>   omap_voltage_late_init: Could not get sys clk.
> 
> Adding a "sys_ck" clock alias would only push the failure further into
> omap_vc_init_channel() and omap_vp_init(), which then complain about
> missing PMIC data.
> 
> TI81xx has no voltage scaling support in mainline, so, as done for
> AM35xx in commit ddf536d0d7e1 ("ARM: OMAP: AM3517/3505: fix crash on
> boot due to incorrect voltagedomain data"), register the non-scalable
> voltage domains instead. They still provide the "mpu_iva", "core" and
> "wkup" domains needed by the powerdomain data, and
> omap_voltage_late_init() now skips them.
> 
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> index e98a3f289c27..478f5eb2a17f 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -119,7 +119,7 @@ void __init omap3xxx_voltagedomains_init(void)
>  	omap3_voltdm_mpu.vc_param = &omap3_mpu_vc_data;
>  	omap3_voltdm_core.vc_param = &omap3_core_vc_data;
>  
> -	if (soc_is_am35xx())
> +	if (soc_is_am35xx() || soc_is_ti81xx())
>  		voltdms = voltagedomains_am35xx;
>  	else
>  		voltdms = voltagedomains_omap3;
> 

