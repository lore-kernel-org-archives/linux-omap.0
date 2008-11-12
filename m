From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] Wait until DPLL1 is relocked.
Date: Wed, 12 Nov 2008 16:22:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811121621300.22679@utopia.booyaka.com>
References: <1226508851-18663-1-git-send-email-peter.de-schrijver@nokia.com> <alpine.DEB.2.00.0811121007550.8505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36597 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbYKLXWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 18:22:02 -0500
In-Reply-To: <alpine.DEB.2.00.0811121007550.8505@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, 12 Nov 2008, Paul Walmsley wrote:

> On Wed, 12 Nov 2008, Peter 'p2' De Schrijver wrote:
> 
> > This patch causes _omap3_noncore_dpll_lock to wait for clocks marked as
> > WAIT_READY to be ready before continuing. This is necessary for MPU/DSP
> > DVFS to work correctly.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com> 
> 
> but it is missing your Signed-off-by: ?

Let's hold off on merging this one, new information has arrived and we can 
do a better patch ...

- Paul
