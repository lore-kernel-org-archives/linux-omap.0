From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Wed, 17 Feb 2010 17:13:48 +0200 (EET)
Message-ID: <20100217.171348.223468508.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58411 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346Ab0BQPOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 10:14:04 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org

Hi Fernand,

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Sat, 13 Feb 2010 02:40:41 +0100

> From 60e21e76773de379deb41ff166f9679b7078276f Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 10 Feb 2010 17:08:20 -0600
> Subject: [PATCH] Mailbox: change mailbox version print to pr_debug
> 
> it is not useful printing the version every time mailbox is used
> instead change it to pr_debug in case someone needs to see the
> version can enable the print.

I just found that, if you put the line printing version into debug
mode, then "mbox_read_reg(MAILBOX_REVISION)" should be also done only
in debug mode. This value wouldn't be necessary if it didn't print.

Considering this printing again, this prints a message only when H/W
initialization is done correctly, most likely only *once* at
booting. This informs us of the result that a mailbox H/W itself is
set up and some mailbox related modules are loaded successfully. So
keeping this makes sense a little bit more rather than shutting this
completely silence.
