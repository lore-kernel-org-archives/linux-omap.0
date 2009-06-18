From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Thu, 18 Jun 2009 15:50:36 +0300
Message-ID: <87tz2d7lk3.fsf@litku.valot.fi>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com>
	<4A38F387.1050502@gmail.com> <20090617140648.GT6605@atomide.com>
	<4A38FBA8.8090406@gmail.com> <20090617145652.GC10550@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:58802 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067AbZFRMuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 08:50:37 -0400
Received: by bwz9 with SMTP id 9so1033475bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 05:50:39 -0700 (PDT)
In-Reply-To: <20090617145652.GC10550@sirena.org.uk> (Mark Brown's message of "Wed\, 17 Jun 2009 15\:56\:53 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, Tony Lindgren <tony@atomide.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Jun 17, 2009 at 06:20:24PM +0400, Eugeny S. Mints wrote:
>> Tony Lindgren wrote:
>
>>> Anything touching arch/arm/*omap*.
>
>> I'm not sure how many non-omap based boards out there are using twl4030  
>> chip and if a separate mfd mail list exists.
>> But until any of the above is true I personally feel that twl4030  
>> related discussions naturally fall into omap mail list.
>
> While the overwhelming majority of TWL4030 specifics will only actually
> be seen on OMAP systems (so CCing the OMAP list makes sense) the code
> also exists in the context of the rest of the kernel.  It needs review
> by subsystem maintainers and people working on non-OMAP systems may have
> useful input based on their general experience of working on simiar
> parts - in general Linux terms the fact that you've got, for example, a
> keyboard controller is at least as relevant as the fact that it's likely
> to be used on an OMAP system.
>
> Many subsystems don't have a separate list and just use linux-kernel.

Yes, and nobody will blame if you CCed linux-omap list twl4030, quite
the opposite. Even if all omap code is in mainline, it doesn't mean that
this list will fade away. I would anticipate even the opposite, more
people might get interested.

-- 
Kalle Valo
