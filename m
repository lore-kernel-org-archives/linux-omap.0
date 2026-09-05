Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2F367F41;
	Sat,  5 Sep 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622466; cv=none; b=nMM27dSLv5HUcyrkKpps7Cjp3E9sW9Z2IC2jHynNz2uprV8mrsxRbi45Xewmodv8fbqk+VN+KxVRR0yXWG9LWQAUHRBYVp6NHbwYvMlFE9U94PuNJfztvUgg4E+eHLCgpd8IfADj0GoA9SHWe3iRfcwefhe7V6T5yoN4SUOlW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622466; c=relaxed/simple;
	bh=Rl6nFKx3ixn0IjNS7sUjrCBuTyy5Wi14vvgdemM8Bgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj3fappUfG8snwmx+kJzeNb4dxvRTKZCvVeo65bEqvTmpZ6BnUepN356tZH//zBTZBG4shmLejDpbjw/LOtp8BO4u312BAE35NFjPZ8xY0yENx3dipOMWeAO7l+fRTkk4WkHjAZZ5s+6HJ5Mmdz3ayAoYKdqUN3k2wck1tukGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TGQCkVys; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TGQCkVys"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 837B340E039E;
	Sat,  5 Sep 2026 15:34:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ULOSdY5268Q1; Sat,  5 Sep 2026 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788622452; bh=C5qV9YRKbU///+gaY6staRDNAJPfLuOO2/9JFJF8rhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGQCkVysyMXAB87/+ol43xmiMSwThSsWet9I4UIylepz0fV2xir/vYc2o4DQnINpi
	 4Vk4QVlAYCNhr22LajTQN71xRDL5fZpQDj8OOGMXA5iKczt27qYfb+OCqX6muSriKP
	 ywQBrjTJPehGG9DwpYm/KRlD3wBUi6UjgVq82SiJZNR/EAPMIiKycHSk/oH33tM4/k
	 116rLuX0d6+qAIHpe+WMrrmSO5QpdDXzCalcGGJPp330gQJ/f9q+8THqwfzZYOs3IW
	 q8rheoYvdHhHSuN6fLU1DU0aSwx4/rIuZQHhEqXWtSntzGBt9a+7RL6EPMjeFFvSJm
	 hjmUatERnV4DmZ1U99TGxewY8+zBAKUg2Zwv419UMnh8DzuZBvhokTa8mLmk7tQKNL
	 BkRP/8r+GpeK+ccBD6XPO2t+SeTsMaobf1Ae5docKjcwC1ygAG2GuE1zIfoPurg/g0
	 UiTn2mIkHpgKEgfl0ilxntuQfA5vEykAt9OXDIhs6eQiXcwRNbd++QEQUcrDv2zVja
	 vJggKDyAgK2aRTSpxNSPEkvGteH/47g5zbjcq10XJRvvKa9rNBnSbJMYTYUb84rrYB
	 3ZsBNc61jaopJ+j/I1afMVPDhfvXiG2dEpu6eZNvikLNVAaRDOMUHgkh7cLxGHa2jb
	 zxv+hR1sv0OpkE/XW5atFbFw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 950F140E03BE;
	Sat,  5 Sep 2026 15:33:39 +0000 (UTC)
Date: Sat, 5 Sep 2026 08:33:36 -0700
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
Message-ID: <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apwzmSr6b0WEkW86@gmail.com>

On Sat, Sep 05, 2026 at 05:22:33PM +0200, Karl Mehltretter wrote:
> Good catch! I will send a v3.

Just don't send it immediately but wait a couple of days to gather review
feedback first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
