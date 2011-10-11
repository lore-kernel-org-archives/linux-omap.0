From: Paul Walmsley <paul@pwsan.com>
Subject: Removing hwmod reset support for initiator IP blocks?
Date: Mon, 10 Oct 2011 20:58:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110102050100.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57440 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1JKC6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 22:58:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, linux-omap@vger.kernel.org


Hi,

so from talking with a few people, it sounds like we can't reset initiator 
IP blocks cleanly at the integration layer.  As I understand the problem, 
if the initiator is in the middle of an OCP transaction, the reset could 
cause system instability, since the OCP transaction would never finish and 
potentially time out.  I have also heard that some processor drivers 
require some fine-grained reset control that can't be handled by the hwmod 
code for some reason.

So this thread is for public discussion of the issue.  It would be good if 
driver authors whose IP blocks may be affected by this could comment and 
perhaps provide more details...


regards

- Paul
