From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Thu, 11 Mar 2010 08:38:15 -0800
Message-ID: <20100311163815.GD2900@atomide.com>
References: <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
 <20100309153827.GR2900@atomide.com>
 <20100309154754.GI3851@gandalf>
 <20100310004826.GD2900@atomide.com>
 <20100310062159.GB3878@gandalf>
 <20100310171548.GI2900@atomide.com>
 <20100311072842.GE20878@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53677 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933240Ab0CKQg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 11:36:56 -0500
Content-Disposition: inline
In-Reply-To: <20100311072842.GE20878@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100310 23:26]:
> hi,
> 
> On Wed, Mar 10, 2010 at 06:15:49PM +0100, ext Tony Lindgren wrote:
> >Updated patch below, is this what you want to do? Maybe reply with
> >an updated patch if you want usb_ehci_init not to use const?
> 
> I'm happy with your version.

OK
 
> >Also, there are other ehci related warnings, see the attached
> >file for that.
> 
> I saw those other warnings and they come from the framework and are
> normal. If I remember Anand had put a patch on ehci-hub.c to kill
> those warnings, maybe it didn't get applied yet.

OK, I'll send out the pending drivers/usb compile fixes to linux-usb
today.

Regards,

Tony
