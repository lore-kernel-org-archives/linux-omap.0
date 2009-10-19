From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] RX-51: Audio: Add usage of regulator framework to
	control VMMC2
Date: Mon, 19 Oct 2009 10:24:09 +0100
Message-ID: <20091019092408.GA25204@sirena.org.uk>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com> <20091008132619.GE29176@rakim.wolfsonmicro.main> <20091012090455.GC13234@esdhcp037198.research.nokia.com> <20091012092104.GD3308@rakim.wolfsonmicro.main> <20091019091300.GA17452@esdhcp037198.research.nokia.com> <20091019092332.GC23798@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49664 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbZJSJYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 05:24:07 -0400
Content-Disposition: inline
In-Reply-To: <20091019092332.GC23798@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Mon, Oct 19, 2009 at 10:23:32AM +0100, Mark Brown wrote:
> On Mon, Oct 19, 2009 at 12:13:00PM +0300, Eduardo Valentin wrote:

> > Might be a stupid question probably because of my lack of knowledge of
> > regulator framework, but if the driver code must be written in such a
> > way that it requires all regulators for its supplies, then what
> > happens with those which are grounded? How do you provide the
> > regulator_init_data in this case (where the supply is actually grounded) ?

> That sounds like a fixed voltage regulator.  Though for a device where
> some of the supplies are optional if the driver needs to know about it
> it may make more sense to have the driver know about that and only
> request supplies which it will use.

...or possibly just handle the error when it fails to obtain them.
