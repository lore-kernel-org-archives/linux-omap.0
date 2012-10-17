From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when necessary
Date: Wed, 17 Oct 2012 16:22:47 -0500
Message-ID: <507F21A7.4030906@ti.com>
References: <1350504742-19995-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com> <507F16F5.9020803@ti.com> <alpine.DEB.2.00.1210172046100.9767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35343 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab2JQVWx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 17:22:53 -0400
In-Reply-To: <alpine.DEB.2.00.1210172046100.9767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, rnayak@ti.com, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/17/2012 03:58 PM, Paul Walmsley wrote:
> On Wed, 17 Oct 2012, Jon Hunter wrote:
> 
>> Are you looking to go one step further and only update the sysconfig on
>> enabling when the context has been lost? That would require more
>> changes.
> 
> Yes that's exactly it.  That would avoid adding a special case for what 
> should be the common case.  From a quick glance it looks like the cache 
> needs to be loaded in _reset(), omap_hwmod_softreset(), and _enable().  
> Other than that, seems like the cached value should work.
> 
> It should also be possible to avoid the reload in _enable() in most cases 
> since the PM code should know whether the IP block's powerdomain was 
> programmed to go off and indeed whether it did so.  It shouldn't involve 
> any extra register reads.  But I wouldn't expect you to add that 
> optimization; would just be nice to have a comment to that effect.

Ah, so you really want the cache to behave like a cache. That would be nice!

> If the meta-theme of your message is that commit 
> 233cbe5b94096f95ba7bca2162d63275b0b90b5b should have had closer scrutiny, 
> I agree with you, but we're beyond that point now...

No under-lying theme here, just more of a "I stumbled across this while
debugging something else" and I am a nut-case about saving cpu cycles
where I can. Although not always possible and I am probably responsible
for burning more cycles than I am saving these days!

Cheers
Jon
