From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 00/14] McBSP cleanup and generalization
Date: Thu, 8 Sep 2011 00:53:31 +0200
Message-ID: <201109080053.32129.jkrzyszt@tis.icnet.pl>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:32859 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab1IGWyY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 18:54:24 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, 31 Aug 2011 at 17:22:47 Jarkko Nikula wrote:
> Hi
> 
> Updates and continuation to my McBSP cleanup RFC set I sent before
> vacation period. Motivation here is to get rid off all is_omap and
> CONFIG_ARCH stuff and to make code a step more generic (and for
> preparing to move code out under arch/arm/).
> 
> I hope this version doesn't break OMAP1.

Works for me on my Amstrad Delta.

Thanks,
Janusz
