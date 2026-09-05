Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA63859F4;
	Sat,  5 Sep 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788630459; cv=none; b=BvcXE7o+R4YaCFkDsv1/iyplD8a8XM/iHEvOq5+F5DwyMMpLZ5GS9Ukd/J4WQXgY2wPgVg4KGTe77TBHahEZb9AmKDj49YdNMUg/SP75k7po3J4Hz5yrnIkpMDBhBcSXUdQhnwRUw+W+HEuiV5FqVw3tJWWoGfZ5xX8dQYo2G2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788630459; c=relaxed/simple;
	bh=CkJ/0EmYuXfRStYAopAldPSBIapJMn38/FN0YmwhAbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/DhFSxmL0/47NPqFEBbSN95kqMPp06CZnH1NHVhPlf6Maba5h61mJHyUKsnF2VWrzHxOLgHbJv/km6UvCHytEmU8JUPYL7RI9gSOMBMvKo0eMi8jMAXpJzobNFWO+3cCwZchwXahe9SUSEgpbk734g5CY78GNEhfmD8xXq5wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=LCbtUmKe; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="LCbtUmKe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=yJzSvffykzz4KpBF67EvSr407WyQ7fUBSQHgOIRPsn4=; t=1788630458; x=1789840058; 
	b=LCbtUmKeKIrtFYlEiB6Lvqvx5ipMuFbTjxxJJrCzJgwjgOBqAqeK+UIkE+FXw/fIT0CUHwM8pRV
	PcDjq+bzYZCMPoDknERmVk5/sUwlWMZDw24Yo5fX1T5qfGsck/THJXxYLtfLGPcStJVR5in+2ietn
	pmkLH0KizM16cqciS6TiuProQdSk/DuW1aZboa3QzrMhHFS12FHvvEtqs/86f7/EdVtsB9JJ2azz9
	ldrLHoMfRgMjpbcv3n5IAbO9OIq3+CoRK0Btb3EhZq8mPu9C28PBfukdDX7xSunj/oc/WPbbBwsE5
	s5G5rVcZfSEeVHSrrOOLH+ixInQCUsTvQU6g==;
Date: Sat, 5 Sep 2026 19:47:20 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, Tony Luck
 <tony.luck@intel.com>, linux-edac@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-omap@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <20260905194720.7033b956@kemnade.info>
In-Reply-To: <apxDtqM8UMN5KNjs@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
	<20260905094649.41996-4-kmehltretter@gmail.com>
	<20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
	<apwzmSr6b0WEkW86@gmail.com>
	<20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
	<871pb7zn36.fsf@trenco.lwn.net>
	<20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
	<apxDtqM8UMN5KNjs@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 18:45:07 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Sat, Sep 05, 2026 at 09:27:42AM +0100, Borislav Petkov wrote:
> > On Sat, Sep 05, 2026 at 10:20:45AM -0600, Jonathan Corbet wrote:  
> > > I would like to emphasize this - slow down a bit and maybe you won't
> > > overwhelm the system entirely.  
> 
> Got it.
> 
> > 
> > I find myself telling more and more new submitters to slow down. Sounds like
> > they don't read our documentation before submitting patches. Especially if the
> > file is even called submitting-patches:
> > 
> > From: Documentation/process/submitting-patches.rst
> > 
> > Don't get discouraged - or impatient
> > ------------------------------------
> > 
> > After you have submitted your change, be patient and wait.  Reviewers are
> > busy people and may not get to your patch right away.
> > 
> > Once upon a time, patches used to disappear into the void without comment,
> > but the development process works more smoothly than that now.  You should
> > receive comments within a week or so; if that does not happen, make sure
> > that you have sent your patches to the right place.  Wait for a minimum of
> > 						     ^^^^^^^^^^^^^^^^^^^^^
> > 
> > one week before resubmitting or pinging reviewers - possibly longer during
> > ^^^^^^^^  
> 
> That's for "not getting any answers" which is not the case here.
> 
> Sending a vX update sometimes feels more urgent because you don't want other 
> people to read your buggy old version. But yes, some patience is also good
> there. 
> 
Well, here it is a bit border line. You do not have answers on all patches,
so technically it is some resubmitting.

But if the main maintainers (which is a bit harder to say in this series) found
time to review, than IMHO (also seen from my maintainer perspective), improve
as soon as you find time and submit the improved version.

Regards,
Andreas
