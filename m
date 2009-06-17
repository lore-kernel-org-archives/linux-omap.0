From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 15:56:53 +0100
Message-ID: <20090617145652.GC10550@sirena.org.uk>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com> <4A38F387.1050502@gmail.com> <20090617140648.GT6605@atomide.com> <4A38FBA8.8090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44765 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZFQO4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:56:53 -0400
Content-Disposition: inline
In-Reply-To: <4A38FBA8.8090406@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org

On Wed, Jun 17, 2009 at 06:20:24PM +0400, Eugeny S. Mints wrote:
> Tony Lindgren wrote:

>> Anything touching arch/arm/*omap*.

> I'm not sure how many non-omap based boards out there are using twl4030  
> chip and if a separate mfd mail list exists.
> But until any of the above is true I personally feel that twl4030  
> related discussions naturally fall into omap mail list.

While the overwhelming majority of TWL4030 specifics will only actually
be seen on OMAP systems (so CCing the OMAP list makes sense) the code
also exists in the context of the rest of the kernel.  It needs review
by subsystem maintainers and people working on non-OMAP systems may have
useful input based on their general experience of working on simiar
parts - in general Linux terms the fact that you've got, for example, a
keyboard controller is at least as relevant as the fact that it's likely
to be used on an OMAP system.

Many subsystems don't have a separate list and just use linux-kernel.
