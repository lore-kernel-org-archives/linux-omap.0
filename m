From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 15 Oct 2008 03:13:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810150301510.14740@utopia.booyaka.com>
References: <200810010915.46032.david-b@pacbell.net> <20081001.213437.22091635.Hiroshi.DOYU@nokia.com> <alpine.DEB.2.00.0810140712570.15253@utopia.booyaka.com> <20081014.231954.235303071.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35748 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbYJOJNv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 05:13:51 -0400
In-Reply-To: <20081014.231954.235303071.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

Hello Hiroshi,

On Tue, 14 Oct 2008, Hiroshi DOYU wrote:

> I understood both points you explained below, while I still think that
> standardizing clock names may be a little bit rigid.

Perhaps you can help me understand - are you referring to the use of the 
TRM clocks, rather than creating a custom clock for each device driver?  
Or are you referring to the clock names used in the omap_clk_associate() 
calls?

> Thank you for your review and comments.

You're welcome,

- Paul
