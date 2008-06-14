From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] Added sleep support to UART
Date: Fri, 13 Jun 2008 18:36:25 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806131830200.21863@utopia.booyaka.com>
References: <> <1213106931-17954-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.1.00.0806111712520.21166@utopia.booyaka.com> <B71CE868F2BC2847B3F23C5A8EE3943024C0F4@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48433 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbYFNAg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 20:36:26 -0400
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE3943024C0F4@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Tero,

Let me begin by saying that I don't care too much about the 32-bit SCM 
register read change; I just happen to think that it is easier to read.  
That said, one comment of yours bears some additional discussion:

On Thu, 12 Jun 2008, Tero.Kristo@nokia.com wrote:

> Also, the spec says that these registers can be accessed in either 8, 16
> or 32 bit modes so why make it unnecessarily complicated and potentially
> buggy with shifts (race conditions)?

What race are you referring to?  Wouldn't such a race exist with the 
current code?  (i.e., a shift should not cause any further race)


- Paul
