From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 15:45:54 +0200
Message-ID: <20100219154554.98be7ebd.jhnikula@gmail.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100218222229.0f0eb3a9.jhnikula@gmail.com>
	<alpine.DEB.2.00.1002191026060.2509@tumpelo.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:41817 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab0BSNka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 08:40:30 -0500
Received: by ewy28 with SMTP id 28so95152ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 05:40:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1002191026060.2509@tumpelo.nmp.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ikoskine@nokia.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

On Fri, 19 Feb 2010 12:05:40 +0200 (EET)
Ilkka Koskinen <ikoskine@nokia.com> wrote:

> > 2. I cannot change the sidetone level with alsamixer
> >
> I think with the previous patch set, it was impossible to set the other 
> channel's gain as Peter pointed out. But at least now that I try, i can 
> change it with alsamixer.
> 
Probably there is some difference with SW? I'm using Debian and
alsa-utils 1.0.21-1.

> > Is this bug with the alsamixer? With amixer I'm able to set positive
> > values but not negative
> >
> > amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32767
> 
> If you try to give negative values, you need to put '--' before the value.
> 
Thanks, works fine (lazy me).


-- 
Jarkko
