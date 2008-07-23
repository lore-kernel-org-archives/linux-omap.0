From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] Set correct off mode polarity
Date: Wed, 23 Jul 2008 16:26:32 +0300
Message-ID: <20080723132632.GA4543@codecarver.research.nokia.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com> <20080721172229.GA4738@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17007 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYGWN1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 09:27:42 -0400
Content-Disposition: inline
In-Reply-To: <20080721172229.GA4738@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jul 21, 2008 at 08:22:31PM +0300, ext Felipe Balbi wrote:
> Hi,
> 
> style comments inlined.
> 
> On Mon, Jul 21, 2008 at 07:02:02PM +0300, Peter 'p2' De Schrijver wrote:
> > +#define OFFMODE_POL 			(1<<3)
> 
> add spaces after 1 and before 3 (1 << 3)
> 
> > -
> 
> unnecessary change ?!?

? This change is necessary, otherwise the system dies as soon as the triton2 sysoffmode scripts become active.

Cheers,

Peter.

-- 
goa is a state of mind
