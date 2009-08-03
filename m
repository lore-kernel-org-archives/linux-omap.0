From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum buffersize for
 McBSP1,3,4,5
Date: Mon, 3 Aug 2009 11:36:19 +0300
Message-ID: <20090803083619.GB1333@esdhcp037198.research.nokia.com>
References: <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <20090730215721.a899e2f4.jhnikula@gmail.com>
 <20090731075823.GB27083@esdhcp037198.research.nokia.com>
 <20090731202611.c689c31c.jhnikula@gmail.com>
 <20090803081107.GA1333@esdhcp037198.research.nokia.com>
 <20090803113638.f82699b2.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28515 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbZHCIsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 04:48:08 -0400
Content-Disposition: inline
In-Reply-To: <20090803113638.f82699b2.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Mon, Aug 03, 2009 at 10:36:38AM +0200, ext Jarkko Nikula wrote:
> On Mon, 3 Aug 2009 11:11:07 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > > True, but I was wondering can this same problem occur also on McBSP2 if
> > > using proper size threshold? Like size near the McBSP2 audio buffer
> > > (1024x32) or near the TX buffer (256x32).
> > 
> > Yes, it can happen with mcbsp2 also if you use all places (1024+256).
> > 
> So should the patch then take into account McBSP2 also?

hmmm.. But I've seen the problem only if you use 1024+256 for mcbsp2 (0x500) or
very close to that (0x4F0). I haven't seen this problem using 0x3FF, as currently is.

> 
> -- 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
