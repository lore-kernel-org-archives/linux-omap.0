From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum buffersize for
 McBSP1,3,4,5
Date: Mon, 3 Aug 2009 11:36:38 +0300
Message-ID: <20090803113638.f82699b2.jhnikula@gmail.com>
References: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<20090730215721.a899e2f4.jhnikula@gmail.com>
	<20090731075823.GB27083@esdhcp037198.research.nokia.com>
	<20090731202611.c689c31c.jhnikula@gmail.com>
	<20090803081107.GA1333@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:39415 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZHCIf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 04:35:27 -0400
In-Reply-To: <20090803081107.GA1333@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Mon, 3 Aug 2009 11:11:07 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> > True, but I was wondering can this same problem occur also on McBSP2 if
> > using proper size threshold? Like size near the McBSP2 audio buffer
> > (1024x32) or near the TX buffer (256x32).
> 
> Yes, it can happen with mcbsp2 also if you use all places (1024+256).
> 
So should the patch then take into account McBSP2 also?

-- 
Jarkko
