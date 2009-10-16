From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt
 controller
Date: Fri, 16 Oct 2009 09:39:56 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B2A021C@dlee02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205AbZJPOkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 10:40:46 -0400
In-Reply-To: <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jouni Hogander <jouni.hogander@nokia.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero Kristo
> Sent: Friday, October 16, 2009 5:49 AM

> OMAP interrupt controller goes to unknown state when there is right
> combination of l3,l4 sleep/wake-up transitions, l4 autoidle in
> interrupt controller and some interrupt. When this happens, interrupts
> are not delivered to ARM anymore and ARM will remain in WFI (wait for
> interrupt) until interrupt controller is forced to wake-up
> (i.e. lauterbach). Disable AUTOIDLE in INTC for now.

Optimal work around enables and disables this around WFI.

Regards,
Richard W.
