From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: [PATCH] fix issue where hwmods are being called twice during
 init
Date: Thu, 08 Dec 2011 22:54:28 +0100
Message-ID: <jbrbmk$8mk$1@dough.gmane.org>
References: <jbrake$vnf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54012 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab1LHVyl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Dec 2011 16:54:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RYlvM-0002ov-Cf
	for linux-omap@vger.kernel.org; Thu, 08 Dec 2011 22:54:40 +0100
Received: from dslb-178-008-122-127.pools.arcor-ip.net ([178.8.122.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 22:54:40 +0100
Received: from andre.puschmann by dslb-178-008-122-127.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 22:54:40 +0100
In-Reply-To: <jbrake$vnf$1@dough.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 12/08/2011 10:36 PM, Andre Puschmann wrote:
> Hi list,
> 
> when compiling the current git HEAD for a Gumstix Overo based board I
> discovered an issue during init causing the error message which is
> attached. I believe this is because they are called twice during init
> (the omap34xx_hwmods struct already contains them).
> 
> The attached patch fixes this issue.

Steve Sakoman just notified me that Felipe Contreras' patch a few days
ago already fixes this issue.
My apologies for posting the same thing again.

BR
Andre




