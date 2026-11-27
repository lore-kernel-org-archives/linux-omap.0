Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820923;
	b=Q9W2V/8sGU2Yoy3LIZo7poApqKmjdnQspbex1Iujq+QcaCmUAwVZbcgfSGUekEVUxJgb
	 OSwn1HV0/UT7SWX1nqt73CxWY25ShlA07AfUHVwDOIFKYTrioJGt9cD1XReDK9wGYgTI/
	 9w5fW1XmQr/8pRaCGgkcrffOhovwr7DieFaWpJWXk2XQImkzeTyMuL5y/9W6DZhZS3MJL
	 wNYAZylcc/E+A/HDQs8djhZdOxbVpPkmDPIOzo5y361ke0eJ+neyF/i4mlqPJZsXC3qBA
	 sSH3uCy/uCZwgtNJ+ksMo4yuqu5v8ei9ZTaqE+6AnnMxsWpntpg5SMwD52PLUnje0Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820923;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=2aKwOdGMMIB1hqfLfsxJEasVHbzKhJFSh6e5iMy10HQ=;
	b=DdfrhNysueKtCIl4LewelEY+Z9G5kNMrfniNVFuB3dLcN1q96K3JvH3cCwSiCX6EFaWk
	 xRYNoA1cuC7fg2ZIiE3K8qFvSGmC7qWZiyUmP74j3qxtpaJ215tfltuhT/d7d8bQkd2Qg
	 MWVqn8QRQWwd5k5v4UO/LqsCNsd5YlMjXzBgC8/u9g7BqJl501GfXFFxfSq4C29d8bJAf
	 JwdUO4AVOs89qBDvshK9cJM6CAVcXSC5RkgTiTTCbtxx53eAVhrxvzXDyl10BCAB3/xmC
	 L0dj1+8aOCxAfUxqAaT0bR6AmQzaccLzN2pMTK7PiMKnr9qPvAOxEH07aF1AdtaIyGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=vT7Ave8i;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=CYWR3urS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.7
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B6606A31F;
	Fri, 27 Nov 2026 23:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C7B6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=vT7Ave8i;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=CYWR3urS
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com; s=arckey; t=1795820922;
	 b=kiAqa2+5i2pDb0fY9YhOWjj/gFVLela3NTKXaiaTEfYeBEQpprT2D5r9gkTS4IW2OtLBLU+ju1
	  V+PplEs1Cn5mCY+VOGAahBx3aYbbodz/iBxcJEcy0kwThK59ew/+KBWAI0sDkCDHLuXKU5eP1k
	  gH20mbXPb2p8n84LSJU3E5w33NeqSPFMWK29IcW+V6q4fM62PB8phLtjyuH6ekNQS60X8NUy7u
	  VQJFywJD5JZgXHHN/iclqMSoUhwRPNs4OPtSpVhThfsg+HIXOmVOeGfrdphTGh9VOqEeKgMbwa
	  lvMg3H7LRaWxAM6MiQmohjibOQKaqStH9HHuccwNCmQNEg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com; s=arckey; t=1795820922;
	bh=o1K/1aTR06oRd/vtbiHXltM41hdqaZFTCTLVqvH8L0A=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=adnWQqWMlt1L3UI1SkuAp3qH1mQBbXzzhQVLdBUvUE500DSTtFDVzy7nz7p1VL6MQM0yYBtOEL
	  g84Ja9aWycVV01FIKkEF2cAD3nlZpVRtkP4ndgfUu0S3ZSP00+Z8uqgpb+ENwShV6lTiWqHjld
	  qisON4My61KYtOLMOPxmwYh8azeoBlixBdV9JfXhu2+cGoG9vA33h5soEb/l6YD+6qkP4tsSnH
	  cFuvOg+daaxZm7XfM1qxDj8m5UTVkEwyT+HEjd+gghOKI5i0uov3IQNiwKOAKrIr5L49zxWz5L
	  Gmat1+n0F6nWMKKm4k/NilLq4M8SfkVO/KgzfQEWYcsKsw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=2aKwOdGMMIB1hqfLfsxJEasVHbzKhJFSh6e5iMy10HQ=; b=vT7Ave8iStKMXeIrtb1Htl5tH7
	HZXE3r91kCqohSSirrVE2quzo1IIfgXo7BDRNQA17K4o0NKRcl5TBa0VTWMSB5MvluIE5KsLGSOzf
	QCGabS/gXetOuulCZwNIVirvwgeEyVWpOOn6iMZCjstnOc6pyng8wSMhACEDYDlF0aXs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.2)
	(envelope-from <francesco@valla.it>)
	id 1xX53Y-00000007oSR-1vpu;
	Fri, 27 Nov 2026 23:08:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=2aKwOdGMMIB1hqfLfsxJEasVHbzKhJFSh6e5iMy10HQ=; b=CYWR3urSK9eq41PG4KnR8yV7gw
	T4IXdfG54bEjjatWUnrnWMMp3UrXpqKqwVQbn2TrL6XPl3QIpbAutqlo8kIZncE6rQpN8Y5KbI//B
	o4y7wThMI3mtFhPK120TRDtnq8s+y8hHuB6vqeb0hpXKgse559RfNB3uX/z0A/2xrXVU=;
Received: from [79.28.115.6] (port=63978 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.2)
	(envelope-from <francesco@valla.it>)
	id 1xX53S-000000007uk-337N;
	Fri, 27 Nov 2026 23:08:34 +0000
Date: Sat, 28 Nov 2026 00:08:33 +0100
From: Francesco Valla <francesco@valla.it>
To: shyckless@gmail.com
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: omap: Fix cleanup after timer start failure
Message-ID: <awoLFmA_kZe2XXwt@bywater>
References: <20261118-omap-rproc-v1-1-c2824060fd10@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-omap-rproc-v1-1-c2824060fd10@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c850323f0239a426b9b9aa71731776c9
X-AntiAbuse: ID - c850323f0239a426b9b9aa71731776c9
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xX53Y-00000007oSR-1vpu-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Wed, Nov 18, 2026 at 03:38:25PM +0000, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> When omap_rproc_start_timer() fails in omap_rproc_enable_timers(), the
> error handling has three problems.
> 
> First, the stop loop also stops the timer that failed to start:
> 
> 	while (i >= 0) {
> 		omap_rproc_stop_timer(&timers[i]);
> 		i--;
> 	}
> 
> omap_dm_timer_start() drops its runtime PM reference when
> pm_runtime_resume_and_get() fails, so stopping that timer calls
> pm_runtime_put_sync() once more than it should.
> 
> Second, the loop leaves i at -1 and then jumps to put_node, which falls
> through to free_timers:
> 
> 	while (i--) {
> 		...
> 		omap_rproc_release_timer(&timers[i]);
> 
> With i == -1 the condition is true and the first iteration uses
> timers[-2]. The loop then keeps going through negative indexes.
> 
> Third, when configure is true, put_node puts np again. The parse loop
> already put every node it got, and np still points at the last one, so
> that reference is dropped twice.
> 
> Only stop the timers that were started. On resume (configure == false)
> return the error and keep the timers: they still belong to the driver
> and are released later by omap_rproc_disable_timers(rproc, true). On the
> first start (configure == true) release all the timers that were set up
> and skip put_node, since no node reference is held at this point.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: e28edc571925 ("remoteproc/omap: Request a timer(s) for remoteproc usage")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Compile tested on arm with clang (W=1, no new warnings). I don't have
> the hardware, so the failure path hasn't been run.
> ---
>  drivers/remoteproc/omap_remoteproc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index f52a531877ae..d50f2e993c4e 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -418,11 +418,14 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
>  		}
>  	}
>  	if (ret) {
> -		while (i >= 0) {
> +		while (i--)
>  			omap_rproc_stop_timer(&timers[i]);
> -			i--;
> -		}
> -		goto put_node;
> +
> +		if (!configure)
> +			return ret;
> +
> +		i = num_timers;
> +		goto free_timers;
>  	}
>  	return 0;
>

Reviewed-by: Francesco Valla <francesco@valla.it>

Regards,
Francesco

