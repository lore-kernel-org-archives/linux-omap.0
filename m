Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7C27AC45;
	Sat,  5 Sep 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625713; cv=none; b=OEVyQMMrBF9vOANJT6gLCygEpir8ihng7wJMuEQEcsg5O5djdWh0Ikh+RiTaPB22QgaRglJYnHx810d2mipIB5kpfnlhMPq4LD7aQOJIuB6TtCVdRAgrtVl60nyCcLuQrvsoj70y2QX4CDqRBMZkbZcTPqjWrOe0pIHoajUf5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625713; c=relaxed/simple;
	bh=OhXLizX0m9zLkQKnxZCjv0YfEAHWHdlocrVXMfwo7/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB3rn08GbfiSG4N5MFZ432F8f2/ARIsBja12B01/SUjEIzolq4Z/L/x4AqwUswtus5ZVC3DyX1FiAvJfQlIchjc0bOEE9iL/MIvrfOKYrBZ848UrgNzO1QDixmjFzvZoDFq2fKYUOkuFplHre/68fTKBwmroBBP4Fkv8kCbGzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d0xUPj+b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d0xUPj+b"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61AA340E03BE;
	Sat,  5 Sep 2026 16:28:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ryxtbjdsg3ct; Sat,  5 Sep 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788625698; bh=wQbP18NxStEguQ/2r4ys92c7gh9AHepmmceGusfJnc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0xUPj+bqY1PiY5TUTW3x8RDgTao6NbfLq0l2/8TD7o/zmhzVKY1fOA+IKKeNJJvu
	 KxKUG3YnccE18UX8B0EBrUsUIOuUmZd4fw4rKiHST6dNh2mHM84ZNeTCISAfxrH6yD
	 SDbz3J3jNszu9T4N3Kh+QVBwiMnbMMWJfZieNHX99ew2H1X3WuGyMy4+EY1Vh1GaVt
	 p4sHfVl/TOEfaE5Nnzm6eIIPpynk+tXuO0b7NbZqEB1rYy9E0w+ncW2R1eBwM4wJ2H
	 CFHvCii3rdnM5ch0UkvYAA99k94pjf+lQro8K1D8iXgCKGAxKfiVE9egAu8rYT+WCQ
	 0mN3OY7dhbGruStBRSfqDzzKixZ5gHNAevFlPGjO10JMOJysdartn6xQ2c5w5sBl5s
	 DLT3rWcWgCoYpucvscpErR3fY//cvbFhuV8gQcRtOPBnE++IS2HuSH696x0xSDCur0
	 pVxXTF+fGJILGCp7BxwM8lnV8MlAnRm8K2yrEUtvafLTLj4zgrpBIF3unhZWxGxG/Y
	 Pc+77s377e1k0+ldgN2DzmoA1bdiHjRB88rApjeZexHOEtMLYxGRaav4RK35AWRyMj
	 gIwBGjr2touhO1S7jGFamw4Eyzc6Jf8EXxh5uU971BLx2xRqJUEpwwVr8cwjih/rGx
	 7814bmme9Atcl0KR1vzyyuWY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68A9B40E02C2;
	Sat,  5 Sep 2026 16:27:45 +0000 (UTC)
Date: Sat, 5 Sep 2026 09:27:42 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
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
Message-ID: <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
 <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
 <871pb7zn36.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pb7zn36.fsf@trenco.lwn.net>

On Sat, Sep 05, 2026 at 10:20:45AM -0600, Jonathan Corbet wrote:
> I would like to emphasize this - slow down a bit and maybe you won't
> overwhelm the system entirely.

I find myself telling more and more new submitters to slow down. Sounds like
they don't read our documentation before submitting patches. Especially if the
file is even called submitting-patches:

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^

one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^

busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
