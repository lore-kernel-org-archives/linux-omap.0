From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap dt fixes and and clocks for v3.16 merge window
Date: Thu, 29 May 2014 12:44:23 -0700
Message-ID: <20140529194423.GI18481@quad.lixom.net>
References: <20140528175838.GA4707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58002 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbaE2ToL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2014 15:44:11 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so90113pdb.38
        for <linux-omap@vger.kernel.org>; Thu, 29 May 2014 12:44:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140528175838.GA4707@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, May 28, 2014 at 10:58:39AM -0700, Tony Lindgren wrote:
> The following changes since commit d712ff63b18309c939396f593510fbcccbafb9e4:
> 
>   ARM: dts: Enable mcpdm and mcbsp1 on DuoVero (2014-05-19 17:20:31 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/dt-part3
> 
> for you to fetch changes up to 43369f0fe81044427f6b1eedeb16bf8c74c86d48:
> 
>   Merge branch 'for-v3.16/clk-dt' of https://github.com/t-kristo/linux-pm into omap-for-v3.16/dt-v2 (2014-05-28 10:14:48 -0700)
> 
> ----------------------------------------------------------------
> 
> Most likely the last pull request from me for omap changes for
> v3.16 that's dts fixes for clocks and enabling few features
> that were still being discussed earlier:
> 
> - A bunch of omap clock related dts fixes queued by Tero Kristo.
> 
> - Enable parallel nand on am437x that was not merged earlier as
>   I requested more information about the muxing for it. And
>   we need to also enable ecc hardware support for am43xx.
> 
> - Enable the modem support for n900 that was dropped earlier
>   because we had to fix the related hwmod entry first with patch
>   ARM: OMAP2+: Fix ssi hwmod entry to allow idling.
> 
> - And finally, add the omap2 clock dts files. These will allow
>   us to enable the dt clocks and drop the legacy clocks for omap2
>   with a follow-up patch once the related clock driver binding
>   changes are merged.

Merged into next/dt. Thanks.


-Olof
