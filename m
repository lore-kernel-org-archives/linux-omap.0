From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Tue, 17 Mar 2009 08:38:12 +0200
Message-ID: <49BF4554.601@nokia.com>
References: <200903110518.34945.david-b@pacbell.net> <200903120222.02972.david-b@pacbell.net> <49BE65DE.90205@nokia.com> <200903161233.06166.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28613 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbZCQGhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 02:37:40 -0400
In-Reply-To: <200903161233.06166.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

David Brownell wrote:
> On Monday 16 March 2009, Adrian Hunter wrote:
>> The linker is not happy with built-in code trying to call functions in a module directly.
> 
> Hmm, I guess I mis-read something ... didn't know the MMC core
> could be built as a module!
> 
> So the workaround is not to build it that way.  And the long-term
> fix is to merge the mmc-twl4030 code into the hsmmc driver.

Yes the code should be moved into omap_hsmmc.c

> 
> Any problem with using that workaround for a while?

No problem with that.

Also vsim (vmmc_aux) is not being found.

