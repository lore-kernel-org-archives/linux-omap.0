From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Fri, 14 Jun 2013 02:46:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52545 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab3FNCqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 22:46:34 -0400
In-Reply-To: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, khilman@linaro.org, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

cc Kevin, Vaibhav

On Thu, 13 Jun 2013, Rajendra Nayak wrote:

> The powerdomain framework today expects to always have a voltagedomain
> associated with a given powerdomain. We already have AM33xx which
> has no Voltage Controller/Voltage Processor as part of PRCM.
> There are more SoCs' to follow starting with AM437x and DRA7xx
> which do not have VC/VP.
> 
> Instead of adding dummy voltage domain data files, make the powerdomain
> framework aware of the fact that some SoCs' might not really have
> scalable voltage domains.

Fine with me in principle if AM335x doesn't support voltage scaling.  
Vaibhav, if this is okay for you, please ack it.  

Then, in terms of merging, probably Kevin would be the right person for 
this since he's done much of the voltagedomain work.


- Paul
