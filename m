From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: DT support for OMAP3 ISP
Date: Wed, 7 Jan 2015 00:10:35 +0200
Message-ID: <20150106221034.GU17565@valkosipuli.retiisi.org.uk>
References: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:57003 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754299AbbAFWKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 17:10:43 -0500
Content-Disposition: inline
In-Reply-To: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ash Charles <ashcharles@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Charles,

On Tue, Jan 06, 2015 at 12:42:12PM -0800, Ash Charles wrote:
> I'm playing with the Caspa camera (mt9v032) and Overo on the 3.17
> kernel.  It looks like there has been some work on dt-bindings for the
> omap3isp (notably [1] and [2]) but I didn't see anything heading for
> mainline.
> 
> What would be needed to support cameras using the omap3isp in a mainline kernel?
> 
> Thanks for any insight,
> --Ash
> 
> [1] https://github.com/vaussard/linux/commits/overo-for-3.14/iommu/dt-v2
> [2] http://git.linuxtv.org/cgit.cgi/sailus/media_tree.git/log/?h=rm696-043-dt

Please use this one instead:

It's much improved compared to what was there in the other branch:

<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=~sailus/linux.git;a=shortlog;h=refs/heads/rm696-046-dt>

That rebased on current media-tree.git doesn't work; for some reason the
IOMMU doesn't get bound correctly to the ISP DT node. Something to figure
out.

Indeed it's not in mainline yet, although the delta is a lot smaller than it
was back then, especially for the smiapp driver (which may not be relevant
for you though).

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
