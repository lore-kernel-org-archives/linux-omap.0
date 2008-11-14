From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] HSMMC: Add MMC configuration for pandora
Date: Fri, 14 Nov 2008 13:44:07 -0800
Message-ID: <20081114214406.GO3106@atomide.com>
References: <1226691917-6577-1-git-send-email-notasas@gmail.com> <1226691917-6577-2-git-send-email-notasas@gmail.com> <200811141211.23183.david-b@pacbell.net> <6ed0b2680811141257g66f451b6k51c9b9c97e67a71b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64803 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbYKNVoK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 16:44:10 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680811141257g66f451b6k51c9b9c97e67a71b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [081114 12:58]:
> On Fri, Nov 14, 2008 at 10:11 PM, David Brownell <david-b@pacbell.net> wrote:
> > On Friday 14 November 2008, Grazvydas Ignotas wrote:
> >> This patch enables both SD slots with support of card detect and
> >> write protect switch on OMAP3 Pandora.
> >
> > Nice milestone for a Friday.  :)
> May be, but it still needs some nasty hack in the host driver to work.
> The driver relies on voltage setting in the host controller register,
> but that is fixed to 1.8V for MMC2 and doesn't represent real voltage
> used for the card.
> 
> > Weren't you working on getting the SDIO WLAN adapter on the third
> > slot to behave too?
> yeah, not much progress with that yet, though..

Pushed both.

Tony
