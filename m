From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 00/10] Patches for fixing the lowmem module
Date: Thu, 11 Sep 2008 19:17:02 +0300
Message-ID: <20080911161702.GL16796@gandalf.research.nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49764 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYIKQRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:17:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGHFd3020927
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:17:17 +0300
Content-Disposition: inline
In-Reply-To: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Viktor Rosendahl <viktor.rosendahl@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 07:20:32PM +0300, ext Viktor Rosendahl wrote:
> 
> Hello,
> 
> Currently the lowmem module doesn't compile. Here are some patches
> that will fix a bug, make some improvements and even make it compile.
> 
>  security/lowmem.c |  258 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 154 insertions(+), 104 deletions(-)

This series should be going to LKML, l-o will get it when merging
upstream I'd say.

-- 
balbi
