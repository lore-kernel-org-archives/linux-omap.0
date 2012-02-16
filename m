From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
	for v3.4 merge window
Date: Thu, 16 Feb 2012 12:12:34 +0000
Message-ID: <20120216121234.GJ15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51325 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab2BPMMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 07:12:47 -0500
Content-Disposition: inline
In-Reply-To: <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 05:30:59PM +0530, Nayak, Rajendra wrote:
> > One more patch is needed to sort out the remaining issue with
> > omap4 that has yet another luck based initialization for the
> > same issue..
> >
> 
> I did this patch on top of your series which should fix the
> issue on all omap4 boards too. Tested on omap4panda and
> omap4sdp boards.

Can you test something with these patches?

1. Build the gpio-twl4030.c as a module, but with HSMMC support built in
2. Boot on the 4430SDP
3. Load the gpio-twl4030 module
4. Remove the gpio-twl4030 module
5. Re-load the gpio-twl4030.ko module

and report back what you get.  Thanks.
