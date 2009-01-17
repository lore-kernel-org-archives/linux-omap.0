From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Reading OMAP3 CONTROL_RAND_KEY_0 register hangs
Date: Fri, 16 Jan 2009 18:14:50 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A180F@dlee02.ent.ti.com>
References: <496F6310.30104@googlemail.com>
 <13B9B4C6EF24D648824FF11BE8967162036D63FEB7@dlee02.ent.ti.com>
 <4970B1AA.7090403@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50904 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762166AbZAQAO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 19:14:58 -0500
In-Reply-To: <4970B1AA.7090403@googlemail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > This address is not accessible out side of secure mode along with some other
> qualifiers.
> >
> > Trying to access is futile and will result in an abort.  The control
> register range is full of readable and aborting addresses.
>
> Is there any hint in TRM (spruf98b.pdf) identifying/marking which
> registers are readable in normal and which are only accessible in
> secure mode?

Hints, in that TRM, I'd not looked in that one before, but yes.  Actually, it seems all those registers have sufficient information for you to know if they are good to access or not.

In each register description the 'type' field instead of having 'r/w/..' has 'refer to table-xyz'.  The table is right after the register.  That table gives accessibility for NSP and SP modes (non-secure and secure).

For CONTROL_RAND_KEY_0 in Table 7-144 is shows 'Not Accessible' in NSP mode.

You can also look at CONTROL_SEC_CTRL register which sets the behavior of some of these register groups.  Secure code at boot would have set the defaults.

Regards,
Richard W.
