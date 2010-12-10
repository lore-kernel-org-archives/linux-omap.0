From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for
 multi-omap for 7xx/15xx/16xx
Date: Fri, 10 Dec 2010 09:41:53 -0800
Message-ID: <20101210174153.GU3054@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <20101204212554.GM17222@atomide.com>
 <20101207232315.GE17435@atomide.com>
 <201012101704.37054.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36056 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab0LJRmF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 12:42:05 -0500
Content-Disposition: inline
In-Reply-To: <201012101704.37054.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com, Cory Maccarrone <darkstar6262@gmail.com>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101210 08:05]:
> > We need to divide the 15xx/16xx offset by 2 for 7xx. Use bank->stride
> > for that. This allows us to get rid of the duplicate defines for the
> > MPUIO registers.
> >
> > Note that this will cause omap-keypad.c driver to not work on 7xx.
> > However, the right fix there is to move over to gpio-keys instead as
> > suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> > Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.
> >
> > Cc: Cory Maccarrone <darkstar6262@gmail.com>
> > Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks, will now merge the gpio into omap-for-linus for the next
merge window.

Tony
