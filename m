From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/0] McBSP changes for OMAP4 platform
Date: Wed, 12 May 2010 09:49:30 +0100
Message-ID: <20100512084930.GA4330@rakim.wolfsonmicro.main>
References: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
 <201005121139.26990.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39946 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754756Ab0ELItc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 04:49:32 -0400
Content-Disposition: inline
In-Reply-To: <201005121139.26990.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lrg@slimlogic.co.uk, tony@atomide.com

On Wed, May 12, 2010 at 11:39:26AM +0300, Peter Ujfalusi wrote:

> Looks good with Jarkko's comment.
> However, I'd like to ask Tony, Liam, Jarkko, and Mark the following:
> Would it make sense to use the alsa tree for OMAP McBSP related patches, while 
> keeping l-o in CC off course.

We've had to do this a few times in the past due to the way the code is
split between the two areas.  If it makes everyone's life easier I've
got no problem with it, though I'll say my standard thing about it being
better to keep them on a branch by themselves which can be pulled into
both trees in case of any merge issues.
