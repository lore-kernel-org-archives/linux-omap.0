From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
Date: Wed, 4 Jul 2012 15:09:32 +0200
Message-ID: <4FF4408C.5070300@ti.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com> <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com> <4FF1977B.1080002@ti.com> <alpine.DEB.2.00.1207040307530.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53078 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2GDNJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 09:09:48 -0400
In-Reply-To: <alpine.DEB.2.00.1207040307530.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi Paul,

On 07/04/2012 11:10 AM, Paul Walmsley wrote:
> On Mon, 2 Jul 2012, Benoit Cousson wrote:
> 
>> Unfortunately the clock fmwk cannot handle module as a clock node.
> 
> Hmm.  We have to have similar support in the clockfw for the CLKDIV32K 
> clock for AM33xx.  That uses the modulemode bits to enable and disable the 
> clock.  Or does this require something more complicated?

I don't think so, in that case, that should probably be enough.

But playing with the modulemode in the clock frmwk still looks like a
hack to me.
Ideally it should be represented by a hwmod instead, but then it will
not fit in the clock fmwk.

That being said, using an IP (internal or not) as a source clock should
be supported.
That will allow us to handle the power dependency we have with Phoenix
audio that is the source clock of the McPDM.

Regards,
Benoit
