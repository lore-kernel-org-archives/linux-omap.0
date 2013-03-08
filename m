From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/3] driver: net: ethernet: cpsw: implement ethtool get/set phy setting
Date: Fri, 08 Mar 2013 16:04:28 +0100
Message-ID: <87ip523pc3.fsf@dell.be.48ers.dk>
References: <1362659421-11884-1-git-send-email-mugunthanvnm@ti.com>
	<1362659421-11884-2-git-send-email-mugunthanvnm@ti.com>
	<8762135on4.fsf@dell.be.48ers.dk>
	<1362686350.2936.43.camel@bwh-desktop.uk.solarflarecom.com>
	<513991E6.5080400@ti.com>
	<1362754401.3248.8.camel@bwh-desktop.uk.solarflarecom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63456 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073Ab3CHPEe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 10:04:34 -0500
In-Reply-To: <1362754401.3248.8.camel@bwh-desktop.uk.solarflarecom.com> (Ben
	Hutchings's message of "Fri, 8 Mar 2013 14:53:21 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, netdev@vger.kernel.org, davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

>>>>> "Ben" == Ben Hutchings <bhutchings@solarflare.com> writes:

Hi,

 Ben> The 'active slave' property would also be needed for the SIOCGMIIPHY
 Ben> ioctl and not just ethtool.  But it's really quite arbitrary.  Perhaps
 Ben> each of them should have their own net device (as with DSA).

Indeed, I think that would simplify all of this quite a bit.

-- 
Bye, Peter Korsgaard
