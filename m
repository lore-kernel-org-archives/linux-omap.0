From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.12-rc3
Date: Wed, 9 Oct 2013 13:51:27 -0700
Message-ID: <20131009205127.GF8313@atomide.com>
References: <20131008220324.GV8313@atomide.com>
 <87d2netbvh.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35315 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753110Ab3JIUvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 16:51:36 -0400
Content-Disposition: inline
In-Reply-To: <87d2netbvh.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@linaro.org> [131009 13:50]:
> 
> FWIW, my automated boot is doing only DT boots on all the OMAP
> platforms.  However, it's only testing basic boot so far so there's not
> a whole lot of driver testing yet (but it's coming soon.)

OK cool. For omap3, off-idle with DT needs the pending
pinctrl-single patches, and some yet unknown way of mapping
wake-up events to device interrupts. But after that you
can also do some PM related tests potentially :)

Tony
