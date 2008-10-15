From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 15 Oct 2008 13:15:09 +0300 (EEST)
Message-ID: <20081015.131509.113069618.Hiroshi.DOYU@nokia.com>
References: <alpine.DEB.2.00.0810140712570.15253@utopia.booyaka.com>
	<20081014.231954.235303071.Hiroshi.DOYU@nokia.com>
	<alpine.DEB.2.00.0810150301510.14740@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37651 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYJOKPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 06:15:32 -0400
In-Reply-To: <alpine.DEB.2.00.0810150301510.14740@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

Hi Paul,

From: "ext Paul Walmsley" <paul@pwsan.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 15 Oct 2008 03:13:49 -0600 (MDT)

> Hello Hiroshi,
> 
> On Tue, 14 Oct 2008, Hiroshi DOYU wrote:
> 
> > I understood both points you explained below, while I still think that
> > standardizing clock names may be a little bit rigid.
> 
> Perhaps you can help me understand - are you referring to the use of the 
> TRM clocks, rather than creating a custom clock for each device driver?  
> Or are you referring to the clock names used in the omap_clk_associate() 
> calls?

This has been already solved since you suggested just to use more
shorter logical name, "ick" and "fck". It would be much cleaner;)

	Hiroshi DOYU

