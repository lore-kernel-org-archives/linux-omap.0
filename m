From: "Girish S G" <girishsg@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
Date: Fri, 16 Oct 2009 12:47:34 -0500
Message-ID: <004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com> <1255690150-16853-2-git-send-email-tero.kristo@nokia.com> <1255690150-16853-3-git-send-email-tero.kristo@nokia.com> <1255690150-16853-4-git-send-email-tero.kristo@nokia.com> <1255690150-16853-5-git-send-email-tero.kristo@nokia.com> <1255690150-16853-6-git-send-email-tero.kristo@nokia.com> <1255690150-16853-7-git-send-email-tero.kristo@nokia.com> <1255690150-16853-8-git-send-email-tero.kristo@nokia.com> <1255690150-16853-9-git-send-email-tero.kristo@nokia.com> <1255690150-16853-10-git-send-email-tero.kristo@nokia.com> <1255690150-16853-11-git-send-email-tero.kristo@nokia.com> <1255690150-16853-12-git-send-email-tero.kristo@nokia.com> <1255690150-16853-13-git-send-email-tero.kristo@nokia.com> <13B9B4C6EF24D648824FF11BE8
 967162039B2A021C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58679 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbZJPRre (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 13:47:34 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B2A021C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, 'Tero Kristo' <tero.kristo@nokia.com>, linux-omap@vger.kernel.org
Cc: 'Jouni Hogander' <jouni.hogander@nokia.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Woodruff, Richard
> Sent: Friday, October 16, 2009 9:40 AM
> To: Tero Kristo; linux-omap@vger.kernel.org
> Cc: Jouni Hogander
> Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
> 
> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tero Kristo
> > Sent: Friday, October 16, 2009 5:49 AM
> 
> > OMAP interrupt controller goes to unknown state when there is right
> > combination of l3,l4 sleep/wake-up transitions, l4 autoidle in
> > interrupt controller and some interrupt. When this happens, interrupts
> > are not delivered to ARM anymore and ARM will remain in WFI (wait for
> > interrupt) until interrupt controller is forced to wake-up
> > (i.e. lauterbach). Disable AUTOIDLE in INTC for now.
> 
> Optimal work around enables and disables this around WFI.

On one of the custom board the power measured didn't show any major impact, with just one time disabling of INTC-AUTOIDL. However,
optimizing this WA looks good though. I did give it a try,
Disabling/enabling INTC autoidle around WFI on custom board, works well but didn't get chance to
measure the numbers.

Regards,
-Girish


