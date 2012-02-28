From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 5/6] ARM: OMAP4: hwmod_data: Do not get DSP out of
 reset at boot time
Date: Tue, 28 Feb 2012 17:05:28 +0200
Message-ID: <1330441528.2116.46.camel@sokoban>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
	 <1330096546-20477-6-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40089 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab2B1PFe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 10:05:34 -0500
In-Reply-To: <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Tue, 2012-02-28 at 03:31 -0700, Paul Walmsley wrote:
> Hi
> 
> On Fri, 24 Feb 2012, Tero Kristo wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > With no driver handling DSP, if brought out of reset, it stays
> > active and does not assert standby. This leads to IVAHD powerdomain not
> > transitioning and hence preventing chip retention.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Please test this series:
> 
>    http://marc.info/?l=linux-omap&m=133040749621183&w=2
> 
> in lieu of this patch.
> 
> 
> - Paul

Just tried the CSWR set on top of your branch with this patch reverted
and it works nicely. I'll drop this patch out from the next version.

-Tero

