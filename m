Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC6563FAA;
	Thu, 10 Sep 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061616; cv=none; b=nJhP1bAloi6+cd00eznT7B4pmgX4y3r5fx8c9q7odox65J/DpVobRyHW+j2qz88NPSes4Li7L5RN57YC3wCda1GjV0iAcKm43npn823WPdD5mm70K9gXisdLPj7V4JrqP6Eu9ash1YiSpYwNCf8JdIhl7W0xKktLqAk7pNjAKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061616; c=relaxed/simple;
	bh=MCNOi9xIw5iRiR3EyFN0mMplUBmpBIeLYzXFr8Rll8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp19RC0UGBn3WyZzOJtQyUfY155vCa/jx+HxcC33Bhxu4uOCknYEhnQCG7oX4OgQGTi1CrwyJ1HCU9b2VE6fgmsp5t2HWUBkLpxT1wUzFx2FezzHU7jlZLUjW9/ajeGPNFb8OVuzTrw5vBSKjCmK8mI/twH+Oj3uX79egV+Uq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr9Rrxkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr9Rrxkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A5A1F000FF;
	Thu, 10 Sep 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061611;
	bh=mc61jQ2p6vMPm9Sn/vjm/9Psk2xpnTlGysS95tscm7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zr9RrxkgLuPZ7amTj6iAzMB56dHM0XLgFYwJmbnZPBjEbC0mWN3C+hPkJMCekYy0w
	 Fhe66bjAyi9wUJ1ryaP8OrJykX1XrnmuZFzPZB6YS7pWZRDw5jvSvnO72YjmRGYROH
	 z4Tm19zswYDqKxRW7mPSyzYnvVDtHi31P0rtyk7bOg4j79nYpu/6i5lJr+v7qPzOvj
	 A3NE9iZpFHlo2ONmbI1iz6sgHB5b94cRQ2nbAOjOMeecQzhwvn77Raj2xaf8vTh8H1
	 8rHrjkWj1dDEVB8CybNDdtDUta6Z0wvbXgS7xrbJ02/j1svRIcFXRpNL7Rm+ypvtuO
	 XHn2kXvUOeFNg==
Date: Thu, 10 Sep 2026 19:33:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 9/9] docs: kernel-parameters: Drop the pata_legacy.qdi
 and pata_legacy.winbond entries
Message-ID: <aqLp4p-CCi9sVDlb@ryzen>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-10-kmehltretter@gmail.com>
 <apwKitEmOv3ZwLkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apwKitEmOv3ZwLkd@gmail.com>

On Sat, Sep 05, 2026 at 02:29:46PM +0200, Karl Mehltretter wrote:
> On Sat, Sep 05, 2026 at 11:46:49AM +0100, Karl Mehltretter wrote:
> > pata_legacy no longer has the qdi and winbond module parameters:
> > commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> > both together with the VLB controller support. The entries also refer
> > to CONFIG_PATA_QDI_MODULE and CONFIG_PATA_WINBOND_VLB_MODULE, which do
> > not exist either.
> > 
> > Drop both entries.
> > 
> > Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > Acked-by: Damien Le Moal <dlemoal@kernel.org>
> 
> This one is actually a duplicate, I just found out. Ethan posted a more
> complete patch in June that removes all six pata_legacy entries which
> commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") left
> behind, this patch covers only two of them:
> 
>   https://lore.kernel.org/r/20260607064053.195166-1-enelsonmoore@gmail.com/
> 
> It has a Reviewed-by tag from Randy, but does not seem to
> have been picked up yet. 
> 
> So I suggest: drop 9/9 and take Ethan's patch instead.
> The other patches of this series are not affected.

I have picked up the patch that you linked to above:

ata: pata_legacy: remove documentation for removed module parameters
https://git.kernel.org/libata/linux/c/a19d4f9b

Thank you for the ping!


Kind regards,
Niklas
