Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F523C0A08;
	Sat,  5 Sep 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621278; cv=none; b=rYPq7URhOHfbx+8FlTBCOtGHzqE6RmvUxmf9lRDQklC0QzQ/AlZLIku7QoXupkSohiar6uI6nSgGDnKqF/nsJa2VqBV2uD0O47fjI+rL+SlH45sX+FrUyoa2lV8J74FD2bKOROcT534W3Dc7lFw0b1gatlVGWof8beB+Lm1g/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621278; c=relaxed/simple;
	bh=ptQDlIgbLicnK80Gpqy0tzeZDRrQTFqIIQk9THXhks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwZMSq20iCpqV04XF4Wm5wcZdD3ud++wM8s1WpfPdtR1oKnmW0PO+wCLrTFwr4c0F7LLTyAa90B/whYQBMSFtNfsccNKtAV99WbM3GtzVk3QYBpLZt9ZiRRaiQcV+QkPLAUz9YH0UWxKCGqH3Kcs5sbZlh9s9xSktOHlpLxSVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sqc2kxW5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sqc2kxW5"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C914D40E02C2;
	Sat,  5 Sep 2026 15:14:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1HIhP_I34F-L; Sat,  5 Sep 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788621261; bh=FONSvainkhZyR+GqgqzxbgjHLuUUwJa+U3QdoTXH0vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sqc2kxW553DlZwdvzxxQAZLrbuEWzoW053Da06kVpvIMhG/w09Utt1KsME6FE8EA7
	 4bmXqAlMUyiS4uSmS1AnVyUiRLtwqPt0nl8K3fVENBlwp7sgw/Tw0nEzcEG37loFCB
	 mgS1PIm7zCP/0Ssn/kzUdG66hBPSm0DNJe9xDVY4AE7kTwhUz4YRybbAUhHTl4CDIH
	 K+Y0Dh/gls5JwcexaHzpg1TJ69xD4QC1wBX0Ck1liC07o2RjsQ8z1rDigOfOrZXaRK
	 g6mIAqrcmv4C2IjahRW7eWbaabrLpCqDUIf4zRGzXQzJknEeGu+AgcZvvP4xyYOIF3
	 T3O8Fli+So/ZctqpvNK4agzCRKsqhdI5ZK/35dqJOlU9pZTgGG1waZhUSB+9pdm2ll
	 2YsxS8nxe2/Wrl/GPvOOi8Ms+eJriGvs2xcuQJ5PufEPjZLGuWFAgsnBZEAmFifz5P
	 OKSzs9s82ckTztlOpPziAO9GwuTvz+/g0aq3IweKR5/LpyQOrFiBzriR7ifp4fLMLR
	 fcL3Dg2ckoPZpiK2BRFnc/3Js/PS4aQpBlni4PLwUgCM5zVYdOTcJnbb08M+iiG4BY
	 Z4sS7sWpWoQ1FLxQRaX0Cq2oNJM4MaSH62nXcMiK2+xut+yoH2jAR+KL1eu0JokBJe
	 Fop3BulcRULz8wF9jjCR7eag=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D53D940E0301;
	Sat,  5 Sep 2026 15:13:48 +0000 (UTC)
Date: Sat, 5 Sep 2026 08:13:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905094649.41996-4-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 11:46:43AM +0200, Karl Mehltretter wrote:
> edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
> edac_stub.c"); nothing parses it any more.

Nope, it was:

7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks")

> Drop the entry.
> 
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.

If you look at fee27d7d9788, you'd read:

    Move the remaining functionality to edac_mc.c. Convert "edac_report=" to
    a module parameter.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
