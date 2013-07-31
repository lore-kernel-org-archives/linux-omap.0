From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [net-next PATCH 1/1] drivers: net: cpsw: Add support for new
 CPSW IP version
Date: Wed, 31 Jul 2013 16:49:59 +0200
Message-ID: <20130731144957.GC4904@netboy>
References: <1375272746-24446-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:39133 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3GaOuN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 10:50:13 -0400
Content-Disposition: inline
In-Reply-To: <1375272746-24446-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, balbi@ti.com

On Wed, Jul 31, 2013 at 05:42:26PM +0530, Mugunthan V N wrote:
> The new IP version has a minor changes and the offsets are same as the previous
> version, so instead of adding CPSW version number in the driver, make the driver
> to fall through to the latest versions so that the new version of CPSW which has
> the same register offsets will work directly without patching the driver.

This doesn't make any sense to me. Why not just add the new version
number?

None of the hunks in your patch are on performance sensitive paths, so
I really can't see any point in removing the error checking.

Thanks,
Richard
