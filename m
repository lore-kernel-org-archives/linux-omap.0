From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] RX-51: Audio: Add usage of regulator framework to
 control VMMC2
Date: Mon, 12 Oct 2009 10:21:04 +0100
Message-ID: <20091012092104.GD3308@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
 <20091008132619.GE29176@rakim.wolfsonmicro.main>
 <20091012090455.GC13234@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55793 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755072AbZJLJVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 05:21:41 -0400
Content-Disposition: inline
In-Reply-To: <20091012090455.GC13234@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Mon, Oct 12, 2009 at 12:04:55PM +0300, Eduardo Valentin wrote:

> Right. Should we add 4 instances of drvdd and 2 of iovdd? So, naming those would be like:

No, if there's multiple pins for the supply then there's no need to
represent those individually - they're required to be wired together in
hardware.
