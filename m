From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] OMAP: HSMMC: Make driver support dynamic idle
Date: Tue, 9 Dec 2008 12:02:13 -0800
Message-ID: <20081209200212.GT4593@atomide.com>
References: <49267E3B.7080303@nokia.com> <20081126191109.GY11997@atomide.com> <492E5DBD.8030605@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59311 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYLIUCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 15:02:14 -0500
Content-Disposition: inline
In-Reply-To: <492E5DBD.8030605@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>

* Adrian Hunter <ext-adrian.hunter@nokia.com> [081127 00:34]:
> Tony Lindgren wrote:
>> * Adrian Hunter <ext-adrian.hunter@nokia.com> [081121 01:15]:
>>> Add a timer that is kept active by MMC requests. FCLK is disabled on timeout
>>
>> Let's keep these patches on hold until we have the hsmmc.c driver in
>> mainline, then get them integrated via LKML.
>>
>> Meanwhile, maybe you want to set up a git branch for hsmmc to queue these?
>> And then I could mirror your hsmmc branch.
>
> As you wish.
>
> tree is:
>
> git://git.infradead.org/users/ahunter/omap_hsmmc.git
>
> branch is:
>
> omap_hsmmc

Thanks, I'm now mirroring that branch in my git tree, and I've merged
it to linux-omap tree.

Please rebase your omap_hsmmc branch against the mainline tree once
we have the current mmc patches in my hsmmc branch integrated to
mainline. That way the omap_hsmmc queue will be ready for next merge
window.

Regards,

Tony
