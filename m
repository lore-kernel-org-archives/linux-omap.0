From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 27 May 2010 12:47:06 +0300
Message-ID: <1274953626.2265.196.camel@tubuntu.research.nokia.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	 <20100522215848.GB29889@n2100.arm.linux.org.uk>
	 <20100526004418.GM9645@atomide.com>
	 <20100526075059.GA25435@n2100.arm.linux.org.uk>
	 <20100526135128.GN9645@atomide.com>
	 <20100526214037.GB16418@n2100.arm.linux.org.uk>
	 <1274950338.2265.134.camel@tubuntu.research.nokia.com>
	 <20100527092501.GA28112@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61282 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400Ab0E0Jry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 05:47:54 -0400
In-Reply-To: <20100527092501.GA28112@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-05-27 at 11:25 +0200, ext Russell King - ARM Linux wrote:
> On Thu, May 27, 2010 at 11:52:18AM +0300, Tomi Valkeinen wrote:

> > I tested your lmb branch on OMAP 3430SDP board, and after removing the
> > topmost patch (ARM: use LMB to allocate system memory MMIO resource
> > structures) everything related to DSS2 (drivers/video/omap2/) seemed to
> > work ok.
> 
> Great, can I add your tested-by for the OMAP and LMB stuff up to but not
> including the last commit?

Sure.

I'll also try to find time to review the DSS side changes properly.

 Tomi


