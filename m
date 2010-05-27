From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 27 May 2010 11:52:18 +0300
Message-ID: <1274950338.2265.134.camel@tubuntu.research.nokia.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	 <20100522215848.GB29889@n2100.arm.linux.org.uk>
	 <20100526004418.GM9645@atomide.com>
	 <20100526075059.GA25435@n2100.arm.linux.org.uk>
	 <20100526135128.GN9645@atomide.com>
	 <20100526214037.GB16418@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55756 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142Ab0E0IxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 04:53:17 -0400
In-Reply-To: <20100526214037.GB16418@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-05-26 at 23:40 +0200, ext Russell King - ARM Linux wrote:
> On Wed, May 26, 2010 at 06:51:29AM -0700, Tony Lindgren wrote:

> > Yeah I'll do that once the dss2 code has been verified to work.
> 
> It'd help with this patch - it seems rx51 needs some additional stuff.
> Any other OMAP platforms with this kind of thing?

I think rx51 is currently the only board that configures the VRAM size
dynamically at boot time.

I tested your lmb branch on OMAP 3430SDP board, and after removing the
topmost patch (ARM: use LMB to allocate system memory MMIO resource
structures) everything related to DSS2 (drivers/video/omap2/) seemed to
work ok.

I tested the DSS2 both as built-in and as modules, and I also tested
VRFB rotation. All seemed to be fine.

 Tomi


