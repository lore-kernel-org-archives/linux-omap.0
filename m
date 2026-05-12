Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3E3A05F1;
	Tue, 12 May 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594283; cv=none; b=KIBL7HtY92c1iJ6NtMyXgdGzErGVDU45dH5T62fgLAdsZfUuy+0FfmjDcCI70SpgSG5gvU8marM2Qan73cuYmSyjvejQUhs+fCg57nsLDOPr+LiYmBjA4MWaRfSea70kLRqUsZIaZv63d/MEft7UVRB+gyyAlQ9B9BkVzA7cYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594283; c=relaxed/simple;
	bh=Rc/JbSkhQh3KrrYjNEJF3TR+KAXO9DvjdINtI40/Tfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+ZbsuPNIf8gwlH2PopQht/6WB7JVxAfiTkvfItYniC+axwmPFdIgXcUVnhzegH1sGxVwSgloGAm8ys3es0EI6c7bdHCY1yRjx+sQYIHZueLrxUf6VO+Ib46Px/9SGVhUVxKGeVnkcv4fD9UerkvQ1WqTdLFJ4Ibp6g4aRIdO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0RmO0jq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0RmO0jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF97C2BCB0;
	Tue, 12 May 2026 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594282;
	bh=Rc/JbSkhQh3KrrYjNEJF3TR+KAXO9DvjdINtI40/Tfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0RmO0jqQzwPQcyKil9HUcb1QoWlKI0VQLz3v+wjcMdkUGHv/Whh/XUa47rOSRmOW
	 8Qgc82+PHXLy0rIczKBOOVDL/C+4/5o9KPYhA6FlZ3pZ6XR/TxQu/dksjUnQzmxGx9
	 yApeu3sHkH0a+AGWuJLBK44eLJ9GQ3u0pH5oQcGEnOm8ggD6aONLhcU2q/I533f1jO
	 RYFgQR6rmvPuRNXS+5eNObmXIQny8HqL1vg+ZSZ2Dxxdnmmao5asePeHrfRkipi/Iu
	 ZaNJLoej2XJNfOCjv5EDrRN8G8ypODoiXtuJR0qNOZnA3C+VEU/MRyjcb1v6cWC8B8
	 8fW9B3r4vFe5Q==
Date: Tue, 12 May 2026 22:57:57 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Make OMAP4 finish_suspend callback CFI-safe
Message-ID: <20260512135757.GB570003@ax162>
References: <20260512042341.1452-1-bavishimithil@gmail.com>
 <20260512073442.GA570003@ax162>
 <20260512100207.3d24837e@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512100207.3d24837e@kemnade.info>

On Tue, May 12, 2026 at 10:02:07AM +0200, Andreas Kemnade wrote:
> On Tue, 12 May 2026 16:34:42 +0900
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > On Tue, May 12, 2026 at 12:23:41AM -0400, Mithil Bavishi wrote:
> > > With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
> > > because omap_pm_ops.finish_suspend points directly to the assembly
> > > routine omap4_finish_suspend, which lacks the expected KCFI type
> > > metadata.  
> > 
> > It sounds like omap4_finish_suspend() should be defined with
> > SYM_TYPED_FUNC_START then? Is that the case for all of the other
> > functions that are added to omap_pm_ops?
> > 
> omap_cpu_resume: the address is written to some cpu register and
> on that way casted to u32. So therefore does not trigger CFI.
> Same for secondary_startup which is also assembler code.
> scu_prepare is C.
> 
> DO you have a pointer to any documentation:
> :~/linux$ grep -R SYM_TYPED_FUNC_START Documentation/

I don't think we have any formal documentation for SYM_TYPED_FUNC_START
(it should probably be documented via kernel-doc?) but you can read the
commit message of the change that added it for more information:

  e84e008e7b02 ("cfi: Add type helper macros")

-- 
Cheers,
Nathan
