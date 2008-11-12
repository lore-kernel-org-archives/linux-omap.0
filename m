From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: twl4030 i2c problem
Date: Wed, 12 Nov 2008 14:20:58 +0200
Message-ID: <20081112122058.GD7467@gandalf.research.nokia.com>
References: <9e6474ae0811120217l101f7a12tbb2287779651fd32@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28704 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYKLMVn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 07:21:43 -0500
Content-Disposition: inline
In-Reply-To: <9e6474ae0811120217l101f7a12tbb2287779651fd32@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sudipta GHOSH <sudipta.in@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Nov 12, 2008 at 12:17:24PM +0200, ext Sudipta GHOSH wrote:
> Hi,
> 
> I am having some problem with i2c.
> 
> In my env I cant make i2c working.
> 
> During boot, Twl4030 tries to send few i2c data, but it didnt going ok.
> 
> static void twl_init_irq(void), issues many i2c write but fails with
> error -121 (EREMOTEIO).
> 
> I tries to some twl4030 i2c read and write from video driver but also
> failes with same error.
> 
> My env and my board is based on OMAP2. I have configured the kernel to
> use board-add08.
> 
> with some debugging I found dev->cmd_err is 2.
> 
> any idea?
> 
> is there any special initialization needed for twl4030?

Send us the console output with debugging enabled and kernel version.
twl4030 is working pretty fine in several boards right now, if yours is
failing we need to track down the issue.

-- 
balbi
