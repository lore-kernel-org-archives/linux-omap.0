From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC] OMAP4:mailbox changes
Date: Thu, 11 Jun 2009 10:15:35 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2F802663@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60088 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbZFKPPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 11:15:44 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, Guzma
Cc: "Anna, Suman" <s-anna@ti.com>, "Shah, Bhavin" <bshah@ti.com>

This is to propose the following changes in the current Mailbox driver.

	- Design changes to support dynamic registration of mailbox Clients.

	- Support for OMAP4 mailbox module.

Design changes:
==============

The current Mailbox driver has the support for only one set of mailboxes (DSP) and this is statically configured. OMAP4 has multiple mailbox modules. The existing design limits adding the support to add Clients to these new Mailboxes.

Proposal:
Define a new API in Mailbox driver to dynamically register Client to mailboxes.
omap_mbox_set(char *name, int rx_id, int tx_id)
	name - name of the mailbox client
	rx_id - The Mailbox ID that is used for receiving events
	tx_id - The Mailbox that is used for sending events.

Check if the tx_id and rx_id are currently used. If used, send back ERROR.
	

OMAP4 changes:
=============
Following changes in OMAP4 mailbox module need to be taken care of.

- The register offsets for OMAP4 mailbox module is different from OMAP3 mailbox module

- New Mailbox registers added in OMAP4.

Proposal:
Add OMAP4 support for mailbox register changes with a CONFIG_ARCH_OMAP4 flag in the existing mailbox driver. 


Thank you
Best regards,
Hari

