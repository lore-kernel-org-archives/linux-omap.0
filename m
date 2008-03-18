From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: OMAP MMC multiport support
Date: Tue, 18 Mar 2008 18:50:39 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com> <20080318115247.GE7843@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58754 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbYCRNZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 09:25:35 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080318115247.GE7843@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Remith Ravi <remithmailinglist@gmail.com>
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, March 18, 2008 5:23 PM
> To: Remith Ravi
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP MMC multiport support
> 
> * Remith Ravi <remithmailinglist@gmail.com> [080318 14:47]:
> > Hi,
> >
> > Is there any OMAP MMC driver implementation exist which support multi
> > port implementation?
> > I am working on OMAP-2530 EVM and want to have support for both MMC
> > port 1 and port 2.
> >
> > Please let me know if you have any input.
> 
> Well if 2530 has same controller as 2420, then yes, it should be
> supported by configuring it in board-*.c files.
>

2530 is same as 2430, and the 3430 MMC driver is best fit for that and it supports Multi MMC controllers (and not slots). One controller can be connected to only one slot on 2530/2430/3530/3430.

But I don't see a MMC second slot on EVM, have you customized this board now?

Regards,
Khasim
 
