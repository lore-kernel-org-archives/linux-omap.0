From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state
	is supported by pwrdm v2
Date: Wed, 19 Nov 2008 10:04:00 -0800
Message-ID: <20081119180358.GX9504@atomide.com>
References: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com> <1226909881-12415-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.2.00.0811181126460.21683@utopia.booyaka.com> <871vx8h9ml.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59962 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYKSSEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 13:04:05 -0500
Content-Disposition: inline
In-Reply-To: <871vx8h9ml.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [081118 15:56]:
> Paul Walmsley <paul@pwsan.com> writes:
> 
> > On Mon, 17 Nov 2008, Jouni Hogander wrote:
> >
> >> Check that wanted sleep state is supported by powerdomain. If it is
> >> not supported, then use next lowest supported state.
> >> 
> >> Check also on suspend that state of pwrdm was lower or equal.
> >> 
> >> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> >
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> >
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Pushing this today.

Tony
