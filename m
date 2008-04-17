From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 21:57:23 +0300 (EEST)
Message-ID: <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
	<200804171140.59906.david-b@pacbell.net>
	<alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32001 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYDQS5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 14:57:52 -0400
In-Reply-To: <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: david-b@pacbell.net, linux-omap@vger.kernel.org

Hi,

From: "ext Paul Walmsley" <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 12:45:02 -0600 (MDT)

> Hello David,
> 
> On Thu, 17 Apr 2008, David Brownell wrote:
> 
> > On Thursday 17 April 2008, Paul Walmsley wrote:
> > > But it would be nice to be able to call into clock functions like 
> > > round_rate, set_rate, and set_parent via filesystem writes for debugging 
> > > purposes, and I don't think that debugfs supports this.
> > 
> > It does, if you set up the files properly ... except
> > maybe the set_parent stuff.
> 
> Could you be more specific?  The only write support that I see in the 
> debugfs API is to store bytes into memory locations.  We'd need to call 
> functions also upon writes.


"debugfs_create_file(...fops)" has take "fops" as its argument. I
guess that this can deal with the above.

For "set_parent", would it be possible to do that by using
"debugfs_rename()"?

And if there will be a little possibility that sysfs attribute can be
used by userland in the future, keeping sysfs instead of debugfs
doesn't seem not so illegal, does it?

	Hiroshi DOYU


