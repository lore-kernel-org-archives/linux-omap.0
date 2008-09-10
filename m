From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omapzoom tree broken?
Date: Wed, 10 Sep 2008 22:08:53 +0300
Message-ID: <20080910190851.GB6671@frodo>
References: <20080909175929.GK8894@flint.arm.linux.org.uk> <1f11a5490809091137r66a9d91cl850ad6e034fe5844@mail.gmail.com> <20080909185415.GM8894@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYIJTJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 15:09:15 -0400
Content-Disposition: inline
In-Reply-To: <20080909185415.GM8894@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Tue, Sep 09, 2008 at 07:54:15PM +0100, Russell King - ARM Linux wrote:
> Looks like the pack index was corrupted; removing the one it just fetched
> and repulling has made it happier.
> 
> However, it's made me unhappier.  Again, can we please have it accessible
> via the git protocol.  Or at least can whoever looks after that tree avoid
> repacking it except maybe once a month?
> 
> Why?  I don't want to have to keep on fetching 300 odd MB of pack files
> every time I pull from this tree.  10 minutes into my current pull and
> I only have 80MB... another 220MB to go.  IOW, 45 minutes for a pull.
> 
> This really isn't practical.

Sure, repacking should be avoided on servers for that. Do what you want
with your local copy and repack sure helps making git a bit faster,
still it's not good for the server side since we'd have to pull the
packs again and again.

-- 
balbi
