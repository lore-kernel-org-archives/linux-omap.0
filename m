From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.15-rc7
Date: Wed, 28 May 2014 18:25:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405281823460.1280@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405271657050.28436@utopia.booyaka.com> <20140527201752.GD14191@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42430 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbaE1SZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 14:25:44 -0400
In-Reply-To: <20140527201752.GD14191@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Aaro,

On Tue, 27 May 2014, Aaro Koskinen wrote:

> Hi Paul,
> 
> On Tue, May 27, 2014 at 04:59:16PM +0000, Paul Walmsley wrote:
> > Here are some basic OMAP test results for Linux v3.15-rc7.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.15-rc7/20140526221127/
> 
> This is great stuff, as always, but just curious, why are the N800 booting
> results not reported? Based on your logs you are still booting it...?

That test run was broken.  Not only did it omit the N800 test, it also 
tested v3.15-rc6, rather than v3.15-rc7 - hence the 0 difference in the 
size report from v3.15-rc6.

The tests are being rerun and will be reposted.

Thanks for the sharp-eyed attention -

- Paul
