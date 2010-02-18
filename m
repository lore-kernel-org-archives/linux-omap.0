From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCHv3 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 17:41:30 +0200
Message-ID: <20100218174130.9bab289e.jhnikula@gmail.com>
References: <1266496635-31347-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com>
	<20100218152413.11d0189a.jhnikula@gmail.com>
	<201002181556.03245.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42711 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586Ab0BRPgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 10:36:22 -0500
Received: by ewy19 with SMTP id 19so6969761ewy.21
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 07:36:21 -0800 (PST)
In-Reply-To: <201002181556.03245.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 18 Feb 2010 15:56:03 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > Are you sure about these ids? Same comment to the patch 2 as well.
> > Worth to check.
> 
> They are correct.
> mcbsp->id is 1 based (1 -> McBSP1, 2 -> McBSP2, etc)
> While the exported functions expect the id to
> be 0 based (0 -> McBSP1, 1 -> McBSP2, etc)
> 
> But, yes it is confusing at times...
> 
Definitely. As existing API is using 0 based indexing, it's better to
use here as well. That would make the lines like below simpler too :-)

+	return omap_st_set_chgain((id)-1, val, 0, channel);


-- 
Jarkko
