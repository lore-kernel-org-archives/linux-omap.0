From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] omap mailbox: execute softreset at startup
Date: Fri, 18 Sep 2009 14:26:32 +0300 (EEST)
Message-ID: <20090918.142632.70208414.Hiroshi.DOYU@nokia.com>
References: <1251365612-26258-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20644 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZIRL07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 07:26:59 -0400
In-Reply-To: <1251365612-26258-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi Tony,

From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Subject: [PATCH 1/1] omap mailbox: execute softreset at startup
Date: Thu, 27 Aug 2009 11:33:32 +0200

> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> The softreset at startup is introduced as TRM describes and also some
> register bit definitions are added instead of magic number.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---

It seems that this was missing in for-next. Please put this in if
there's no problem.
