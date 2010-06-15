From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 15 Jun 2010 10:04:22 +0300 (EEST)
Message-ID: <20100615.100422.02284271.Hiroshi.DOYU@nokia.com>
References: <AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
	<20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7571E25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47264 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab0FOHEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 03:04:39 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7571E25@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: fernando.lugo@ti.com, ohad@wizery.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 17:56:35 +0200

> Hi Ohad/Hiroshi,
> 
> Good to see the new mailbox requirements. While we are at it can we add some more :)?
> 
> * Make the mailbox as a generic driver. 
> 	Meaning, users can request for a pair of mailbox rather than
> using a set of pre-defined ones. For eg: Instead of doing an
> omap_mbox_get("mailbox-1") we can have the user specify the mailbox
> pair that he needs ( omap_mbox_get(int tx_mbox, int rx_mbox) or
> similar API ). This also means that we remove the bulk of the data
> structures like omap2_mbox_1_priv and mbox_1_info and so
> on. Additional checks needs to be done so that consequtive requests
> to the driver does not re-configure the rx-tx pairs.
> 
> Rationale: 
> The pre-configured structures does make sense in case of DSP Bridge,
> since it is the only user of mailbox. However, for Syslink for
> example, (or for any other IPC or user of mailbox) it would be good
> for the user of the mailbox to request the pair (or just tx/rx) from
> user/kernel side.

Fair enough.

> * Provide debug support for the mailboxes (relevant for OMAP4)
> 	Since OMAP4 has support to read the RAW registers we might as
> well add an API for the user to read the status from RAW registers.

This could be debugfs.
