From: "Girish S G" <girishsg@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
Date: Tue, 20 Oct 2009 11:19:42 -0500
Message-ID: <01e801ca51a1$21776de0$841018ac@am.dhcp.ti.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com><1255690150-16853-2-git-send-email-tero.kristo@nokia.com><1255690150-16853-3-git-send-email-tero.kristo@nokia.com><1255690150-16853-4-git-send-email-tero.kristo@nokia.com><1255690150-16853-5-git-send-email-tero.kristo@nokia.com><1255690150-16853-6-git-send-email-tero.kristo@nokia.com><1255690150-16853-7-git-send-email-tero.kristo@nokia.com><1255690150-16853-8-git-send-email-tero.kristo@nokia.com><1255690150-16853-9-git-send-email-tero.kristo@nokia.com><1255690150-16853-10-git-send-email-tero.kristo@nokia.com><1255690150-16853-11-git-send-email-tero.kristo@nokia.com><1255690150-16853-12-git-send-email-tero.kristo@nokia.com><1255690150-16853-13-git-send-email-tero.kristo@nokia.com><13B9B4C6EF24D648824FF11BE8967162039B2A021C
 @dlee02.ent.ti.com><004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com><13B9B4C6EF24D648824FF11BE8967162039B317F66@dlee02.ent.ti.com><005001ca4e8b$ea107c10$3d1018ac@am.dhcp.ti.com><1F18D6510CF04!
 74A8C9500565A7E41A210
	F69EEFFB@NOK-EUMSG-02.mgdnok.nokia.com> <87oco2njfh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40016 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbZJTQTp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 12:19:45 -0400
In-Reply-To: <87oco2njfh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>, Tero.Kristo@nokia.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org, jouni.hogander@nokia.com



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, October 20, 2009 11:02 AM
> To: Tero.Kristo@nokia.com
> Cc: girishsg@ti.com; r-woodruff2@ti.com; linux-omap@vger.kernel.org; jouni.hogander@nokia.com
> Subject: Re: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
> 
> <Tero.Kristo@nokia.com> writes:
> 
> Except omap_write* functions are deprecated.
> 
> I'd rather see a call into the interrupt code.  Something like
> omap_intc_prepare_idle()
> 
> Also, isn't this only needed if CORE != ON?

In all the failure cases, the CORE was ON. It was programmed for RET/OFF but didn't really hit the state. Also, I have seen this
issue in C2 state as well. 

-Girish

