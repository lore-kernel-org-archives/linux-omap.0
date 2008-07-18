From: Kai Svahn <kai.svahn@nokia.com>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Fri, 18 Jul 2008 09:47:19 +0300
Message-ID: <20080718064719.GG25099@six.research.nokia.com>
References: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31595 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYGRGrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 02:47:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, jarkko.lavinen@nokia.com, tony@atomide.com

Hello all,

On Thu, Jul 17, 2008 at 09:25:06PM -0600, ext Paul Walmsley wrote:
> 
> noticed a few issues booting the N800 with the current git head
> d3b3ae0fe6c71641da19c8de466ec366d39847e3 today.  Haven't booted the N800 
> for a while, so not sure when these showed up.
> 
> Looks like there is some LM8323 problem - suppose it could be an I2C 
> problem:
>
> Also MMC looks like something may be wrong:
> ... and then later ...
> 
> Something is also wrong with audio - no touchscreen clicks play.

I guess you are right all these controllers are connected with i2c if I
remember right so the problem lies most likely there. I could give it
also a try and try to find out when it broke.

Cheers,
Kai

