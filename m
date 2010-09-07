From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: omap3: regulator_get() failure in ads7846
Date: Tue, 7 Sep 2010 13:51:19 +0100
Message-ID: <20100907125118.GC25830@sirena.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com> <4C862D15.1070606@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52194 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab0IGMvX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 08:51:23 -0400
Content-Disposition: inline
In-Reply-To: <4C862D15.1070606@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Sep 07, 2010 at 03:16:21PM +0300, Igor Grinberg wrote:

> I think, this can help:
> http://www.spinics.net/lists/arm-kernel/msg94759.html

> Seems like there were not enough interest and it is still floating.
> May be a little ping can help ;)

This is a really bad idea unless the supplies genuinely are optional -
we shouldn't be doing this sort of bodge in the drivers, that's just
going to lead to lots of repetitive code adding complexity every time
the regulator API is used.  It also makes the error handling rather more
obscure since systems that genuinely need the regulator won't be
reporting problems clearly.

The regulator API has facilties on several levels to deal with systems
that have problems here: it provides fixed voltage regulators, it
provides the option to substitute in dummy regulators automatically and
if the regulator API is disabled then the stub functions provided will
report success.
