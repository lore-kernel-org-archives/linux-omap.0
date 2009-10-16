From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt
 controller
Date: Fri, 16 Oct 2009 13:04:25 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B317F66@dlee02.ent.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162039B2A021C@dlee02.ent.ti.com>
 <004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZJPSE2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 14:04:28 -0400
In-Reply-To: <004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>, 'Tero Kristo' <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: 'Jouni Hogander' <jouni.hogander@nokia.com>


> From: Ghongdemath, Girish
> Sent: Friday, October 16, 2009 12:48 PM

> On one of the custom board the power measured didn't show any major impact,
> with just one time disabling of INTC-AUTOIDL. However,
> optimizing this WA looks good though. I did give it a try,
> Disabling/enabling INTC autoidle around WFI on custom board, works well but
> didn't get chance to
> measure the numbers.

There was one report from a custom board when it made a difference.  I've not tried to double check this data.  I don't have the reporters setup so there is no guarantee I could reproduce anyway.  In general optimization seemed to make sense.

Regards,
Richard W.
