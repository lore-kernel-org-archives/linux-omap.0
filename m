From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 15:54:37 +0200
Message-ID: <20100219155437.66473141.jhnikula@gmail.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100218222229.0f0eb3a9.jhnikula@gmail.com>
	<201002191034.32391.peter.ujfalusi@nokia.com>
	<20100219153916.a3dc4a77.jhnikula@gmail.com>
	<1266586637.2044.2.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:20172 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0BSNtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 08:49:13 -0500
Received: by ey-out-2122.google.com with SMTP id d26so46983eyd.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 05:49:11 -0800 (PST)
In-Reply-To: <1266586637.2044.2.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>

On Fri, 19 Feb 2010 15:37:17 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> > It seems to work with I2S too.
> > 
> 
> For both channels? I don't recall so.. and for the one channel only, the
> FIR doesn't behave expectedly? (maybe this works [1,0,..0], but more
> sophisticated ones may not..)
> 
Could be. At least the control 'McBSP2 Sidetone Channel 1' doesn't have
any effect. But the control 0 is affecting both channels
simultaneously. (I didn't check the meaning of those two controls)


-- 
Jarkko
