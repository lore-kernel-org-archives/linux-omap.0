From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 PM: off-mode during idle, problem with UART1 console
Date: Fri, 19 Jun 2009 11:40:55 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E316E07@dlee02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54975@dbde02.ent.ti.com>
 <87ab44xkim.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41886 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZFSQlA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:41:00 -0400
In-Reply-To: <87ab44xkim.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, June 19, 2009 11:21 AM

> Thanks a lot for testing.  It sounds like something specific to the
> ES3.0 GP SDP.

Are DIP switches the same?

ROM code may touch UART in one case and not the other.

Regards,
Richard W.
