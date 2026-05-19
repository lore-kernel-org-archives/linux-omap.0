Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1A30566E;
	Tue, 19 May 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207248; cv=none; b=cT4WZ39ybx7wLeOV1RHtbHP0KMXmquJLfj1oIXE/j5cgUht9PPMzj7RIk9VZ9Y35WUmpfsaKV2XlOng11AouBx+NRwle2FagkSzUH+tJzuBbZ+TMaBqnpvEITW+3Ndkv42w7pC1e0Ftl4ZneUiBTyi8HVXYtD+/p+8ZuALWG6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207248; c=relaxed/simple;
	bh=qPJmPnMjYJJv/azQe6nv3JlJNaYHrABVaCKJQZN6KBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHm1xjFeKs5tprRHfDc4e2xm2c/tDNvkoBUMoGaZjzjMGnat0n7gszIvdqu2OZM7br+67+Pn6VXl0zy/orsKsImMM8aMcFAikf7do8FoaPHF96YjQxZZHKhrm+n6vcoDc7m25W2EWkiMwECG/fzytKMLgexwvS/XIS2bTN0OKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqpf4lvF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqpf4lvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7972CC2BCB3;
	Tue, 19 May 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779207247;
	bh=qPJmPnMjYJJv/azQe6nv3JlJNaYHrABVaCKJQZN6KBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oqpf4lvFoBDVJeQnEXjx9Nc2hnL+n4Pe9rbcRoNV2a9/skeYfL+Ns4rqXW0TCRHlZ
	 ml92uJoogG94DFS5bHe7M5kbjPAzM/vdaBpAtpbaVKzvhBqn4Nz+ICLaifDoMHoagu
	 qwTXh7NsEE9ADwMzeKCTP138W4a3mR7r6afxb91XbP6LeykVyMiHzhvnEED5mOd3FT
	 NjEHVwDrFFEd3u+szn0DQvy+EKfmfBLJSwMrAkliwa/7XVyAbv/e3X0/Fq2n5FUijw
	 5zcQOSpotDCH0ecfe/YcN4MGCRcq6ZHzGU10S3LEgDUZ/1UViDcaQ8+lytnB1cHv5R
	 YLqaWY9a9XArg==
Date: Tue, 19 May 2026 09:14:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] memory: omap-gpmc: Silence clang kerneldoc warnings
Message-ID: <20260519161402.GA3527449@ax162>
References: <20260519132548.315229-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519132548.315229-2-krzysztof.kozlowski@oss.qualcomm.com>

On Tue, May 19, 2026 at 03:25:49PM +0200, Krzysztof Kozlowski wrote:
> Recent LLVM prints kerneldoc W=1 warnings, even though a correct
> kerneldoc is there:

I don't see how LLVM is relevant here, a GCC build would show the same
warnings since they come from kernel-doc, not the compiler.

>   Warning: drivers/memory/omap-gpmc.c:441 Excess function parameter 'cs' description in 'get_gpmc_timing_reg'
> 
> Drop additional inline comments for arguments to fix that.  They are
> anyway not that useful.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/memory/omap-gpmc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index d9e13c1f9b13..958d2b0ea54a 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -432,13 +432,9 @@ static unsigned int gpmc_clk_ticks_to_ns(unsigned int ticks, int cs,
>   *
>   */
>  static int get_gpmc_timing_reg(
> -	/* timing specifiers */
>  	int cs, int reg, int st_bit, int end_bit, int max,
>  	const char *name, const enum gpmc_clk_domain cd,
> -	/* value transform */
> -	int shift,
> -	/* format specifiers */
> -	bool raw, bool noval)
> +	int shift, bool raw, bool noval)
>  {
>  	u32 l;
>  	int nr_bits;
> -- 
> 2.51.0
> 

-- 
Cheers,
Nathan
