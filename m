Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E523EA8B;
	Sat,  5 Sep 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596516; cv=none; b=HVJVgZbSouIFBN2WRtAlewPpsNYVd4ikwd6d+HbFlZQymzjaL/bkJVJvQ+McQmh94wLuDEC6w3Rwjrx1iOcxx1vf6npzWcF7TvhLHdGOY8jm5Fi2MjMujFSBCC6CTMgJGtZANJVNG/oyypOXtXpjP8/dYd3se1eQmGhRTqLVpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596516; c=relaxed/simple;
	bh=fn4NxiT4jn6QUWX8zX732tVu6ZhQloWWXrxTG6Wqax8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d98HLU8Vrveyrv99pFjD4puxPDtwj7Lssw1eWsdoeh8inJhH/nG/fyZR+6TcKw5z3UTVCCgZRA2UMvIbzwdaeFO3GJquD22ORZ/Hk2PMxnb0prgI/dLlFWEF1ZbCq67Sssfpr4qoV4OVa8Lf5dbH/sTE/PsVYNxv8AAXh3ywbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GW0d1A4n; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GW0d1A4n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=pVISZRhqeUbbG63nkEbrVHxYxMTirBscwLs3Wje3fLI=; t=1788596514; x=1789806114; 
	b=GW0d1A4nZiuH6M7yc7pEFUp0c2CjZDav9+HrWCCWJ9gQhUCOtPoYP1UGFOthgjFaB6rdanxZ1MX
	MnaJ5OdvxWO393utNbT35qN7oEVMkPiFvb7JpSWY1BSiMoLAjc9yucFfL7OXoS1DqYUfl7Vozhdqo
	2EvsFIm5r9OKahM7Pg+yGy0rivrH9dbjDhgPIj9xu0vpTxMvW7YO+YpO2hyGiaa7+4OUc51HJS+Zy
	VfpuyZDyYxslNjNQNmdZ5iZGmAUmrsdUID1ts/Z/zWjRWhjletGb2+P3T0TXPZMC37F/mv9JfiEAn
	PHqVlV1kCHTIaeOwY54zPWeOpW/T9zlkutoQ==;
Date: Sat, 5 Sep 2026 10:21:34 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, Tony
 Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-omap@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
Subject: Re: [PATCH 7/9] docs: kernel-parameters: Drop the omap_mux= entry
Message-ID: <20260905102134.69ef3092@kemnade.info>
In-Reply-To: <20260905070347.25902-8-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
	<20260905070347.25902-8-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 09:03:45 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> omap_mux= went away with commit e9f5f1e45608 ("ARM: OMAP2+: Remove
> legacy mux code"); nothing parses it any more.
> 
> Drop the entry.
> 
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.
> 
> Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d44728a45506..48dd273eaf6c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4765,11 +4765,6 @@ Kernel parameters
>  			waiting for the ACK, so if this is set too high
>  			interrupts *may* be lost!
>  
> -	omap_mux=	[OMAP] Override bootloader pin multiplexing.
> -			Format: <mux_mode0.mode_name=value>...
> -			For example, to override I2C bus2:
> -			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
> -
>  	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
>  
>  			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]

