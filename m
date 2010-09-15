From: Tony Lindgren <tony@atomide.com>
Subject: Upcoming merge window, marked all the patchwork patches before
 v2.6.35 as archived
Date: Wed, 15 Sep 2010 11:31:41 -0700
Message-ID: <20100915183141.GF4174@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62010 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab0IOSbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 14:31:46 -0400
Received: from c-67-188-36-105.hsd1.ca.comcast.net ([67.188.36.105] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Ovwlj-0000Bl-4V
	for linux-omap@vger.kernel.org; Wed, 15 Sep 2010 18:31:44 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Here's some important info regarding posted patches and the
upcoming merge window.


UPCOMING MERGE WINDOW

Just to remind everybody, we want to have our omap patches reviewed
and queued into for-next by -rc6. That is less than two weeks from
today.

If you have a larger set of patches, please set them up into a git
branch after review for pulling. Please remember that anything
touching arch/arm/*omap*/ must be also reviewed on the linux-arm-kernel
list, so Cc that list too so I don't have to repost the patches before
applying. Basically see the instructions here (server currently down?):

http://www.elinux.org/OMAP_patch_merging_process


POSTED PATCHES AND PATCHWORK

To cope with the patch overload, I added all the patchwork
patches into archived-v2.6.35 bundle when v2.6.35 got tagged:

http://patchwork.kernel.org/bundle/tmlind/archived-v2.6.35/?archive=both

However, at that point the patchwork instance on kernel.org was buggy,
and I could not mark them all archived.

Anyways, I've marked them all archived now. This means they do not
appear as new patches any longer, and patchwork.kernel.org is
usable again for tracking what's already queued up.

I plan on archiving everything when a new major release comes out,
maybe even after some -rc releases if necessary.

So the current list of patches we're working with for the upcoming
merge window is:

http://patchwork.kernel.org/project/linux-omap/list/

Please everybody, check if your patch got archived, and if so,
repost as needed against v2.6.36-rc4.

In general, if something got archived, please don't consider it
rejected. It just means that you have to repost, fix and complain
until the patch is ready and integrated :) The standard Linux way
you know.

Regards,

Tony
