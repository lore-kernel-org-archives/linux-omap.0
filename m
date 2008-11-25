From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Tue, 25 Nov 2008 13:13:23 +0200 (EET)
Message-ID: <20081125.131323.166913714.Hiroshi.DOYU@nokia.com>
References: <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com>
	<1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
	<20081125094427.GA4436@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56610 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbYKYLNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 06:13:40 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAPBDLNp024701
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 13:13:37 +0200
In-Reply-To: <20081125094427.GA4436@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Tue, 25 Nov 2008 11:44:27 +0200

> On Tue, Nov 25, 2008 at 11:39:53AM +0200, Hiroshi DOYU wrote:
> > +MODULE_ALIAS("platform:"DRV_NAME");
> 
> small typo here ?

Right. fixed it in the repository. Thanks.

       Hiroshi DOYU
