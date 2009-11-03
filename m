From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 1/1] PM: Making bdi threads non-freezable
Date: Tue, 3 Nov 2009 12:12:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EC179@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBC66@dbde02.ent.ti.com>
 <200911021943.49943.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbZKCGmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 01:42:36 -0500
In-Reply-To: <200911021943.49943.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> Subject: Re: [PATCH 1/1] PM: Making bdi threads non-freezable
> 
> On Monday 02 November 2009, Dasgupta, Romit wrote:
> > Fixes the case when bdi threads are in the refrigerator but file system sync
> > can happen after this. This is possible in MMC when
> CONFIG_MMC_UNSAFE_RESUME is
> > not set.
> 
> What's going to happen if we attemt to suspend the underlying block device(s)
> when the bdi thread are doing their job?  Is there any synchronisation
> mechanism for that?
> 
There is no explicit synchronization AFAICT. However, it looks like the call to 'del_gendisk' would invoke 'sync_filesystem' down the line. 'sync_filesystem' would end with synchronous writes of inodes followed by a call to '__sync_blockddev'. 
After this call I believe there should not be any activity pending for the blockdevice. So this should not lead to any race. My tests on the development board did not show any issues. But some FS experts may comment.

Regards,
-Romit

