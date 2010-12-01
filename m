From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
Date: Wed, 01 Dec 2010 21:27:39 +0200
Message-ID: <1291231567-notmuch-felipe.contreras@nokia.com>
References: <1288033806-1496-1-git-send-email-x0095840@ti.com> <20101129.104729.97149649.Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:36178 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab0LAT2L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 14:28:11 -0500
In-Reply-To: <20101129.104729.97149649.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com, x0095840@ti.com, h-kanigeri2@ti.com
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hiroshi.DOYU@nokia.com wrote:
> From: ext Fernando Guzman Lugo <x0095840@ti.com>
> Subject: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
> Date: Mon, 25 Oct 2010 21:10:02 +0200
> 
> > Version 5:
> > * Changes in "iommu: create new api to set valid da range"
> >   - Change range variables to platform data structure.
> 
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Does that means you are going to send a pull request with these for .38?

Fernando, is there a branch where you have all the changes needed in
tidspbridge?

I guess the only patch missing would be the one for linux-arm.

Cheers.

-- 
Felipe Contreras
