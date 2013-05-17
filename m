From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Date: Fri, 17 May 2013 11:56:20 -0700
Message-ID: <20130517185620.GF28484@animalcreek.com>
References: <20130515002537.GG5600@atomide.com>
 <20130515015212.GB3268@animalcreek.com>
 <20130515170734.GI5600@atomide.com>
 <20130515215028.GA11883@animalcreek.com>
 <5194B2A8.8020608@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m1plsmtpa01-02.prod.mesa1.secureserver.net ([64.202.165.174]:36200
	"EHLO m1plsmtpa01-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255Ab3EQS43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 May 2013 14:56:29 -0400
Content-Disposition: inline
In-Reply-To: <5194B2A8.8020608@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 16, 2013 at 12:19:20PM +0200, Yegor Yefremov wrote:
> On 15.05.2013 23:50, Mark A. Greer wrote:
> > On Wed, May 15, 2013 at 10:07:35AM -0700, Tony Lindgren wrote:

> >> Mark, do you have some omap3 with no iva (other than am3703) to test the
> >> idle states with?
> > 
> > I have an am35xx which isn't supposed to have an IVA so I can test with it
> > (although, I'm not sure how well the kernel works on the am35xx these days).
> > 
> > I'm a bit busy today but I'll try booting the am35xx tomorrow and if it
> > comes up, see what I can figure out.
> 
> I think this issue is relevant to am3517 as you can see from this thread: http://thread.gmane.org/gmane.linux.ports.arm.omap/97903
> I could boot only with your patch http://www.spinics.net/lists/arm-kernel/msg168865.html
> 
> I have such a system running, so if you have any other patches/ideas to test, I would do it.

Yegor, since I've so far been unable to get my am3517evm to fire up, can
you play around with the 3517 to see if there appears to be iva registers
that can be read/written to safely?  In particular, can the code that idles
the iva be run safely on an am3517?

Thanks,

Mark
--
