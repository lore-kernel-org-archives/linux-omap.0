From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling MUSB support
Date: Wed, 27 Aug 2008 23:54:28 -0700
Message-ID: <200808272354.28531.david-b@pacbell.net>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:45010 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752500AbYH1Gya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Aug 2008 02:54:30 -0400
In-Reply-To: <20080827133825.GC7354@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Wednesday 27 August 2008, Felipe Balbi wrote:
> I tried musb on omap2420 (with tusb), omap3430 and omap3530
> (beagle board) and all of them are working.

I tried it on Beagle and found that OTG mode wanted to oops
while binding the gadget driver ... static config.  That's
with current GIT.  Peripheral-only had the same issue ISTR.

Host mode seemed to come up partially.  There seem to be
issues with control-OUT transfers, which caused problems
trying to use the Ethernet adapter I was hooking up.

- Dave

p.s. FWIW my beagle identifies itself as 3430 ES2.2
     not as 3530.
