Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1033E360;
	Sun,  6 Sep 2026 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667135; cv=none; b=o4TZJ82YIE20oDELjk+Pd7uNLbGV4MbLyLT5gHr2k74ESLz1MKcNkjwl3w+dv/Hv2fxHJ3gre0NvAdJ613ntnAtlXytLshdmGrFCqf1HNMX02uPxRqLQQXr0TXCwRmpQOoS9Oy5NoRxQnRIOd2kH4Syx0gbVIQZGJiURwoXGAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667135; c=relaxed/simple;
	bh=vvyAxBwYRuSuFr1Lfde/jLWfJLW5ponsOXKY2bOsW2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFuArtvUBnkTKVsVBD6e1xk4gmVknkGgFsufL3z/rpUBAUQuJ2RGNfqDuUf72bVJ2PJqB/r7qijA9Fro5QLw+DLS4jnca5yvWxRbLoZHOUxJxRXklpo8iftv0B5dHNctLcZVHJUznXqSVZH+bGA24dfSXGl/T7RRsii5pdr3x6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0N2GaVta; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0N2GaVta"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0HkFo0ybA+orVFH/u7Fk4Ze5CEEmhF31UK62O8mlgwM=; b=0N2GaVtaoti9ntZUVjraUk/TwS
	zA8FVp8lzNBR2HsnmRGGC+MadsLt1fIXrbhnQePRLjD374qnAommHTW7fhlrvbV5vyvdaoWEjnO0n
	KNWc9m8l0qcTsQF0tnL1DxxznmoXytuzdQSq4KolMxbAc2v/BY78G7Q8LnAL/Hl9BdANR9meNTaIt
	/rKx9NH8XePfZUmzfEX4Abjvj89pFQyLSPP2gZAijeNsL6l2HB/N5OTYv/q8jmmNrDxlirrPI/G6Q
	i2zM97uJb1DXPy1u1aBpQJij0dY0uOfY9cg5txILtiHQo16jVXZUGayAKMhiDogZSG4iiT+wqqsB7
	LONEM9PA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x341k-00000004es3-2eE6;
	Sun, 06 Sep 2026 03:58:45 +0000
Message-ID: <f241beab-4c83-4f18-bb02-9d6e3fd5ecc3@infradead.org>
Date: Sat, 5 Sep 2026 20:58:42 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for
 parameters that no longer exist
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905094649.41996-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/5/26 2:46 AM, Karl Mehltretter wrote:
> kernel-parameters.txt still documents ten boot parameters whose parsing
> code was removed with the drivers or platforms that used them, one of
> them (atarimouse=) since before the git history. One patch per
> parameter, each with a Fixes: tag for the commit that removed the
> parser, so the maintainers of that area are on their own patch only;
> the two pata_legacy module parameters share the last one. Each entry
> was checked with git grep for its __setup(), early_param() and
> module_param() handler and with git log -S for the removing commit.
> 
> Changes in v2:
> - patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
>   separate pata_qdi driver and not the pata_legacy parameter; both
>   parameters went away in 3c4d783f6922 alone
> - collect the Reviewed-by and Acked-by tags from v1
> 
> v1: https://lore.kernel.org/all/20260905070347.25902-1-kmehltretter@gmail.com/
> 
> Karl Mehltretter (9):
>   docs: kernel-parameters: Drop the atarimouse= entry
>   docs: kernel-parameters: Drop the bau= entry
>   docs: kernel-parameters: Drop the edac_report= entry
>   docs: kernel-parameters: Drop the enable_timer_pin_1 entry
>   docs: kernel-parameters: Drop the mini2440= entry
>   docs: kernel-parameters: Drop the nomfgpt entry
>   docs: kernel-parameters: Drop the omap_mux= entry
>   docs: kernel-parameters: Drop the pcmv= entry
>   docs: kernel-parameters: Drop the pata_legacy.qdi and
>     pata_legacy.winbond entries
> 
>  .../admin-guide/kernel-parameters.txt         | 67 -------------------
>  1 file changed, 67 deletions(-)

For patches 1/9, 2/9, 4/9, 5/9, 6/9, 7/9, and 8/9:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
