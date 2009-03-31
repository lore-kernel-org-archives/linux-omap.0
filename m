From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in
	mmc-twl4030
Date: Tue, 31 Mar 2009 22:00:19 +0100
Message-ID: <20090331210019.GA12304@sirena.org.uk>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk> <200903301353.44087.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52691 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbZCaVAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 17:00:31 -0400
Content-Disposition: inline
In-Reply-To: <200903301353.44087.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Mar 30, 2009 at 01:53:43PM -0700, David Brownell wrote:

> So when are you going to fix the regulator docs to report that:

> 	ALL regulator consumers must start by enabling and
> 	then disabling the regulator.

The documention should not be changed to say that since only consumers
that need the regulator to be off at startup should do this, and then
probably only if they find that it is already enabled.

Other consumers do not need to do this.  Consumers that want to enable a
regulator at startup can do so directly.  Consumers that don't need a
specific state (for example, because they are able to share the
regulator and don't need it enabling) should just leave it alone.
