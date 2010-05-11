From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add support for packet synchronised sDMA transfers.
Date: Tue, 11 May 2010 15:47:32 -0700
Message-ID: <20100511224731.GJ13931@atomide.com>
References: <1267611658-18946-1-git-send-email-f-goucem@ti.com>
 <2183bec21003030502y4e29d943o49b85cba937922a0@mail.gmail.com>
 <74583B8642AB8841B30447520659FCA9EB8A7F8D@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50380 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0EKWrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 18:47:31 -0400
Content-Disposition: inline
In-Reply-To: <74583B8642AB8841B30447520659FCA9EB8A7F8D@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Goucem, Fabrice" <f-goucem@ti.com>
Cc: hari n <hari.zoom@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Goucem, Fabrice <f-goucem@ti.com> [100309 05:11]:
> Hi Hari,
> 
> Thanks for your comment.
> What you're saying is perfectly true, however I find current way is a bit awkward and potentially dangerous if for any reason value of OMAP_DMA_SYNC_PACKET changes in the future, or if more constants are defined later on.
> 
> I think proposed patch improves the readability of the code and makes it clearer to developers what DMA synchronisations are supported.

In that case the patch subject is wrong, these features are
already supported as Hari pointed out. Maybe update the
patch subject and description accordingly?

Tony
