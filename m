From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 1/9] OMAP: HSMMC: Make driver support dynamic idle
Date: Thu, 27 Nov 2008 10:43:41 +0200
Message-ID: <492E5DBD.8030605@nokia.com>
References: <49267E3B.7080303@nokia.com> <20081126191109.GY11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34915 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYK0Iem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 03:34:42 -0500
In-Reply-To: <20081126191109.GY11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>

Tony Lindgren wrote:
> * Adrian Hunter <ext-adrian.hunter@nokia.com> [081121 01:15]:
>> Add a timer that is kept active by MMC requests. FCLK is disabled on timeout
> 
> Let's keep these patches on hold until we have the hsmmc.c driver in
> mainline, then get them integrated via LKML.
> 
> Meanwhile, maybe you want to set up a git branch for hsmmc to queue these?
> And then I could mirror your hsmmc branch.

As you wish.

tree is:

git://git.infradead.org/users/ahunter/omap_hsmmc.git

branch is:

omap_hsmmc
