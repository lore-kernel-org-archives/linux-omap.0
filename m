From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Date: Thu, 24 Feb 2011 13:09:51 -0800
Message-ID: <20110224210951.GJ20560@atomide.com>
References: <1298528800-7399-1-git-send-email-samreen@ti.com>
 <1298536312.16119.23.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13414 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1BXVJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 16:09:57 -0500
Content-Disposition: inline
In-Reply-To: <1298536312.16119.23.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Nilofer, Samreen" <samreen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Mundt <lethal@linux-sh.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110224 00:30]:
> On Thu, 2011-02-24 at 00:26 -0600, Nilofer, Samreen wrote:
> > Enabling all the display interface options to be built as module
> > And enabling all the display panels to be built as modules.
> > 
> > Signed-off-by: Samreen <samreen@ti.com>
> 
> This looks good to me.
> 
> Tony, want to ack this? This enables all DSS features as modules. This
> should go through dss tree, as this doesn't work without a fix that is
> there.

Sounds good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
