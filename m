From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB: Update hdrc_cnf.h to enable the full range of endpoints
Date: Fri, 11 Apr 2008 08:24:15 -0700
Message-ID: <200804110824.16001.david-b@pacbell.net>
References: <010C7BAE6783F34D9AC336EE5A01A08805D6502A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:29404 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751767AbYDKPYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2008 11:24:18 -0400
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805D6502A@dbde01.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>

On Friday 11 April 2008, Gadiyar, Anand wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Updates to the hdrc_cnf.h file to enable the full range of 16 endpoints.
> This patch fixes the "musb_hdrc: invalid ep 8" messages that show up on boot.

Still doesn't fix:

 * This file contains configuration constants for the (m)hdrc
 * silicon as integrated into DaVinci CPUs.

Can you make that reference the relevant OMAP models?
