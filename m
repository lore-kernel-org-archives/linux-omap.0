From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 6/10] omap mailbox: remove unnecessary arg for
 omap_mbox_msg_send
Date: Wed, 09 Sep 2009 12:10:24 +0300 (EEST)
Message-ID: <20090909.121024.267971467.Hiroshi.DOYU@nokia.com>
References: <20090907150243.GB6538@flint.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6C43EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34378 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZIIJKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 05:10:39 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43EF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: rmk@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com, h-kanigeri2@ti.com, grgupta@ti.com

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 6/10] omap mailbox: remove unnecessary arg for omap_mbox_msg_send
Date: Mon, 7 Sep 2009 17:32:48 +0200

> Hi Russell,
> 'arg' is used later in Patch 10, as part of the tasklet
> implementation, for writing messages to the mailbox. Should I be
> removing it in patch 6 and introduce it only for the tasklet
> implementation?

If just converting work queue to tasklet as below, can we get rid of
the special struct "struct omap_msg_tx_data"?

http://marc.info/?l=linux-omap&m=125248696005088&w=2
