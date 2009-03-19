From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Thu, 19 Mar 2009 19:27:11 +0000
Message-ID: <20090319192711.GC8966@sirena.org.uk>
References: <200903111743.34708.david-b@pacbell.net> <200903181225.11444.david-b@pacbell.net> <20090318203317.GA6299@sirena.org.uk> <200903181402.14384.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:39280 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZCST1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 15:27:19 -0400
Content-Disposition: inline
In-Reply-To: <200903181402.14384.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wed, Mar 18, 2009 at 02:02:14PM -0700, David Brownell wrote:

> Huh?  $SUBJECT patch hasn't merged.  How could you
> have backed it out??

Sorry - another patch introducing a version of the same issue.  Your
patch:

http://git.kernel.org/?p=linux/kernel/git/lrg/voltage-2.6.git;a=commit;h=67130ef073299cc7299d3ffa344122959e97753c

bumped the refcount for boot_on regulators.  This patch:

http://git.kernel.org/?p=linux/kernel/git/lrg/voltage-2.6.git;a=commit;h=504e7d7e42fb3a58809946770ff5e07cc9d52dbf

backs out that change only.  This was my bad on the review.
