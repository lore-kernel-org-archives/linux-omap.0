Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2430CD9E;
	Sun,  6 Sep 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682766; cv=none; b=rwTWmvVCyASDdpxG/mSWJM63UIEue7a3Z2JUWgXYp+RHrVZ/FNrdtP9vMVP9voxaDNF2PkWLZUqEJW7yCrfLxIyYKH9jbR0g0BvJe94QdGDgE5Sf3bvD8yjN0/SPGvRs5DKwwJfhZ3W8IGqKYO5FhVi3toPuDQus0tir00zf0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682766; c=relaxed/simple;
	bh=L5srEMJP1B5M0FdrqGNhOEFicz2UgHY3O0TahFjuZNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNSqKwks7cPTF/mYWT7y/bzx2yIt+gRtAMjbNQDJI5GrQGLenn0XEvI7Yt6SEly1N03Os3/tf8eXUC48e1NLcpkJ0AHqoFSAWxS4odFHg2agFII+sOUoelj+Yt72y49zdZ5Q0D4Ay0Lbki8jkTTkRy521WrVpogrmzMH9TAtZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=wo6/G8dN; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="wo6/G8dN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=qVqBaro4u6j4vDM7zRBqf26XGAFIlsvWCm284+Ot/Vs=; t=1788682764; x=1789892364; 
	b=wo6/G8dNlvO19ndW8r5EKUPJU55fREq9XbZnwqmi2UI5H9VtIpSoTd4YB45Eh65kTjGHfh5OPOs
	1xGZoCDHEmEyLss3xDq0fzrpmgw4e9SAxyM+gVPRBY1VXwPk8Pp8e1sN5FP57ZjX65nW25ihHJRip
	1j7Je0Q2O0Lkp276MmHhDQisv7mZMuPykCFrBd1mO/32x6L54pb5lqbiE0+fWJ8IHLsJCOmJdDdfV
	S5iurhY0IRFxWpLqbOh1/mg57KJ9aRulrTP0+s1/+dapHaVjZTSlWHOci7Nmph/YJeKaDrahZQk0m
	lFnav5vk7UAQnd16UeLzpUyMF+QHRM7BIS6g==;
Date: Sun, 6 Sep 2026 10:19:10 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Borislav Petkov <bp@alien8.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
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
Message-ID: <20260906101910.588d055e@kemnade.info>
In-Reply-To: <20260905185037.GDapxkfbPNUxJgaMH8@fat_crate.local>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
	<20260905094649.41996-4-kmehltretter@gmail.com>
	<20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
	<apwzmSr6b0WEkW86@gmail.com>
	<20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
	<871pb7zn36.fsf@trenco.lwn.net>
	<20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
	<apxDtqM8UMN5KNjs@gmail.com>
	<20260905194720.7033b956@kemnade.info>
	<20260905185037.GDapxkfbPNUxJgaMH8@fat_crate.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Sep 2026 11:50:37 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Sep 05, 2026 at 07:47:20PM +0200, Andreas Kemnade wrote:
> > > That's for "not getting any answers" which is not the case here.  
> 
> No, that's the case ALWAYS. If you spam maintainers with too often
> submissions, you end up achieving the opposite to what you're trying to do.
>
This particular set was sent too fast, I agree, but reading that document again, it
sounds like the summary is being patient with busy people.

Some subsystems even discourage waiting in such cases:
e.g.
https://docs.kernel.org/process/maintainer-netdev.html
"Do not wait too long (weeks) between postings either as it will make it
harder for reviewers to recall all the context."

[...] 
> > But if the main maintainers (which is a bit harder to say in this series) found
> > time to review, than IMHO (also seen from my maintainer perspective), improve
> > as soon as you find time and submit the improved version.  
> 
> If you want an earlier submission, feel free to ask the person.
> 
> In the general case, though, one should do a good testing before submitting
> and all the issues caught after that, one can work in in her/his next version
> locally and perhaps even state so.
> 
Hmm, maybe I was misunderstood. Just to avoid that I accidentially provoke
patch-flooding with my comments:
The next revision should come only after you have finished your homework
(improve according to review comments, tests,...) and any further review
comments are unlikely.

Regards,
Andreas
