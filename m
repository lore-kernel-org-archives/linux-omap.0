From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] twl4030_charger: add devicetree support.
Date: Tue, 12 Nov 2013 22:40:19 -0800
Message-ID: <20131113064019.GB31149@teo>
References: <20131031170550.686cdf1e@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:45376 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3KMGkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Nov 2013 01:40:42 -0500
Received: by mail-pa0-f43.google.com with SMTP id fa1so4373385pad.16
        for <linux-omap@vger.kernel.org>; Tue, 12 Nov 2013 22:40:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131031170550.686cdf1e@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

On Thu, Oct 31, 2013 at 05:05:50PM +1100, NeilBrown wrote:
> 
> This allows the charger to be enabled with devicetree, and
> allows the parameters for charging the backup battery to be set.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> Acked-by: Kumar Gala <galak@codeaurora.org>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> 
> --
> This version with correct property names and some Acked-by's.
> - NB

Applied, thank you!
