From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] Wait until DPLL1 is relocked.
Date: Wed, 12 Nov 2008 10:08:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811121007550.8505@utopia.booyaka.com>
References: <1226508851-18663-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57486 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYKLRI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 12:08:28 -0500
In-Reply-To: <1226508851-18663-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, 12 Nov 2008, Peter 'p2' De Schrijver wrote:

> This patch causes _omap3_noncore_dpll_lock to wait for clocks marked as
> WAIT_READY to be ready before continuing. This is necessary for MPU/DSP
> DVFS to work correctly.

Acked-by: Paul Walmsley <paul@pwsan.com> 

but it is missing your Signed-off-by: ?


- Paul
