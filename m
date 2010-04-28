From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Wed, 28 Apr 2010 10:50:36 +0300 (EEST)
Message-ID: <20100428.105036.39187012.Hiroshi.DOYU@nokia.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33662 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab0D1Hu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 03:50:58 -0400
In-Reply-To: <1272390982-14882-2-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Ohad,

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Tue, 27 Apr 2010 19:56:19 +0200

> rwlocks are slower and have potential starvation issues so spinlocks are
> generally preferred

Would it be possible to explain the above a bit more?
