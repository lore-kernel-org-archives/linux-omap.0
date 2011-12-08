From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] fix issue where hwmods are being called twice during
 init
Date: Thu, 8 Dec 2011 15:59:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112081559400.6289@utopia.booyaka.com>
References: <jbrake$vnf$1@dough.gmane.org> <jbrbmk$8mk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44090 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1LHW77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 17:59:59 -0500
In-Reply-To: <jbrbmk$8mk$1@dough.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Cc: linux-omap@vger.kernel.org

Hi Andre

On Thu, 8 Dec 2011, Andre Puschmann wrote:

> On 12/08/2011 10:36 PM, Andre Puschmann wrote:
> > when compiling the current git HEAD for a Gumstix Overo based board I
> > discovered an issue during init causing the error message which is
> > attached. I believe this is because they are called twice during init
> > (the omap34xx_hwmods struct already contains them).
> > 
> > The attached patch fixes this issue.
> 
> Steve Sakoman just notified me that Felipe Contreras' patch a few days
> ago already fixes this issue.
> My apologies for posting the same thing again.

Not at all, thanks very much for the patch.


- Paul
