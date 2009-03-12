From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Thu, 12 Mar 2009 10:37:48 +0000
Message-ID: <20090312103744.GA24376@sirena.org.uk>
References: <200903111743.34708.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1271 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743AbZCLKv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 06:51:26 -0400
Content-Disposition: inline
In-Reply-To: <200903111743.34708.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wed, Mar 11, 2009 at 04:43:34PM -0800, David Brownell wrote:

> Buggy consumers could notice different bug symptoms.  The main
> example would be refcounting bugs; also, any (out-of-tree) users
> of the experimental regulator_set_optimum_mode() stuff which
> don't call it when they're done using a regulator.

I'm OK with this from a code point of view so

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

However any consumers that take advantage of this won't be able to
safely share a regulator without extra work since they have no way of
telling why a regulator is in the state that it's in without extra
stuff.  We should probably have something along the lines of a
regulator_get_exclusive() for them.  Previously the consumer counting
would have stopped them interfering with enables done by other
consumers.

There will be other consumers that can't safely share a regulator anyway
(eg, requiring additional code to notice and handle voltage changes) so
it'd be a good thing to have.
