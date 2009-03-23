From: Tony Lindgren <tony@atomide.com>
Subject: Re: tidspbridge git repository
Date: Mon, 23 Mar 2009 12:47:11 -0700
Message-ID: <20090323194711.GI29546@atomide.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53326 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885AbZCWTrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 15:47:07 -0400
Content-Disposition: inline
In-Reply-To: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ameya.palande@nokia.com
Cc: linux-omap@vger.kernel.org, hiroshi.doyu@nokia.com

* ameya.palande@nokia.com <ameya.palande@nokia.com> [090323 00:42]:
> Hi Tony,
> 
> I have collected latest patches for tidspbridge at:
> git://gitorious.org/tidspbridge/mainline.git 
> 
> Branch is: tidspbridge
> 
> It is based on your pm branch.
> Can you pull it to your tidspbridge branch?

What dependencies are there to the PM branch?

To me it sounds like you should rebase your tidspbridge branch
against the mainline kernel as the drivers should be arch
independent.

If something is missing from the mainline kernel to rebase and
compile tidspbridge against the mainline, we need to fix those
issues.

Regards,

Tony
