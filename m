From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] OMAP3: Fix omap3_defconfig build
Date: Thu, 10 Dec 2009 00:10:30 -0600
Message-ID: <20091210061030.GA19668@lixom.net>
References: <1260424192-29012-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:60608 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbZLJGHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 01:07:21 -0500
Content-Disposition: inline
In-Reply-To: <1260424192-29012-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

{removing invalid lkml-like addressee}

On Thu, Dec 10, 2009 at 11:19:52AM +0530, Anand Gadiyar wrote:
> Select sound codecs to allow this defconfig to build again

You need to fix the config option dependencies/selects, updating the
defconfig just papers over the real problem.

> Also, sync up this defconfig with the generated .configs.

Good idea, but I suggest holding off until the merge window has closed
since there are still new options going in. Doing a respin after -rc2
or so makes more sense. So please redo in a few weeks?

Traditionally Linus hasn't minded pulling in defconfig updates a little
later in the release cycles.


Thanks,

-Olof
