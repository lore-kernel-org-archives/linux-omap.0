From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Thu, 26 Apr 2012 18:49:12 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54347 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab2DZStW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 14:49:22 -0400
In-Reply-To: <20120426184312.GY3739@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 27, 2012 at 00:13:13, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120423 11:31]:
> > On Thu, Apr 19, 2012 at 04:48:37, Tony Lindgren wrote:
> > > * Hiremath, Vaibhav <hvaibhav@ti.com> [120413 03:39]:
> > > > On Thu, Apr 12, 2012 at 13:56:06, Paul Walmsley wrote:
> > > > 
> > > > Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
> > > > These patches have been reviewed and accepted in the list, only thing is
> > > > they couldn't make it to upstream during v3.4 merge window.
> > > > 
> > > > I believe Tony is going to push them for v3.5 now.
> > > 
> > > Hmm care to clarify which patches are you talking about here?
> > > 
> > 
> > Tony,
> > I was referring to initial 2 baseport patches which we have dropped due 
> > dependency on mach-types.
> > 
> > arm:omap:am33xx: Add AM335XEVM machine support
> > arm:omap:am33xx: Add low level debugging support
> 
> Can you please repost these against current v3.4-rc4? 
>  

Ok, I will do that.

> > One patch (which was independent) from this series, made its way to upstream,
> > ARM: OMAP2+: id: Add am33xx SoC type detection
> 
> OK
>  
> > Can you please make sure that, it gets included into your next pull request?
> 
> As far as I remember they looked OK for minimal board changes.
> 

Yes, they were accepted and were also available under linux-omap/soc2 branch 
for quite some time.

Thanks,
Vaibhav

