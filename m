From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/33] add tlv320aic23 driver
Date: Wed, 3 Sep 2008 18:40:55 -0700
Message-ID: <20080904014054.GO23085@atomide.com>
References: <1220116593-862-2-git-send-email-me@felipebalbi.com> <1220116593-862-3-git-send-email-me@felipebalbi.com> <1220116593-862-4-git-send-email-me@felipebalbi.com> <1220116593-862-5-git-send-email-me@felipebalbi.com> <1220116593-862-6-git-send-email-me@felipebalbi.com> <20080901102228.02db1230.jarkko.nikula@nokia.com> <20080901080158.GV9887@frodo> <20080901111312.176e3a4c.jarkko.nikula@nokia.com> <65e025470809010802m4c12a6eeh9cf5d3a3643ff5b8@mail.gmail.com> <20080901151923.GB6654@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64171 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYIDBlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 21:41:02 -0400
Content-Disposition: inline
In-Reply-To: <20080901151923.GB6654@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Yuri Jaeger Monti <yurijm@gmail.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [080901 08:20]:
> On Mon, Sep 01, 2008 at 12:02:44PM -0300, Yuri Jaeger Monti wrote:
> > We're still using OSK here. The patch compiled fine, although I'm still having
> > some troubles with the audio in the board.
> > Unfortunately I still don't have the knowledge to develop the ASoC driver, but
> > I would be glad to help.
> 
> Please do, take any of other ASoC driver as an example and try to make
> it work with tlv ;-)

Let's get rid of all the old audio drivers once osk5912 ASoC driver
works. I'll export the old audio code into a patch on my website for
references in case anybody needs it.

Tony
