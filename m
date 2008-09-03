From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Wed, 03 Sep 2008 11:40:11 +0800
Message-ID: <1220413211.7042.38.camel@localhost>
References: <1220276228.2680.9.camel@localhost>
	 <200809020751.48357.david-b@pacbell.net>
	 <1220406796.7042.34.camel@localhost>
	 <200809021855.25118.david-b@pacbell.net>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63000 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbYICDib (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2008 23:38:31 -0400
In-Reply-To: <200809021855.25118.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, 2008-09-02 at 18:55 -0700, David Brownell wrote:
> On Tuesday 02 September 2008, stanley.miao wrote:
> > > 
> > > If that file is, oddly, being shared between two boards ...
> > > then put that code in the "if (machine_is_omap_3430sdp())"
> > > block.  And someone should consider renaming the file if
> > > it's not specific to the 2430 SDP.
> > 
> > OMAP3430_ES1 doesn't have this problem.
> 
> Not the point.  Why have 2430 chips run code that only makes
> sense on 3430 silicion?

Have you noticed my later version ? I have modified it to
if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)).

Stanley.

> 
