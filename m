From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Tue, 25 Nov 2008 11:44:27 +0200
Message-ID: <20081125094427.GA4436@gandalf.research.nokia.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-4-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-5-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35795 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYKYJqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 04:46:04 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAP9jjWk003957
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:46:02 +0200
Content-Disposition: inline
In-Reply-To: <1227605998-13531-6-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Nov 25, 2008 at 11:39:53AM +0200, Hiroshi DOYU wrote:
> +MODULE_ALIAS("platform:"DRV_NAME");

small typo here ?

MODULE_ALIAS("platform:" DRV_NAME);

-- 
balbi
