From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [alsa-devel] [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Wed, 12 Aug 2009 14:48:33 +0300
Message-ID: <1250077713.16045.31.camel@eenurkka-desktop>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	 <20090805103900.5ad89efe.jhnikula@gmail.com>
	 <200908051158.57440.peter.ujfalusi@nokia.com>
	 <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
	 <20090811090457.d89afd3e.jhnikula@gmail.com>
	 <1249971481.16045.17.camel@eenurkka-desktop>
	 <20090812144547.eb4bf7f2.jhnikula@gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24811 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZHLLsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 07:48:17 -0400
In-Reply-To: <20090812144547.eb4bf7f2.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Wed, 2009-08-12 at 13:45 +0200, ext Jarkko Nikula wrote:
> 
> The threshold based transfer will cause that omap_pcm_pointer will
> loose a bit its accuracy. Probably irrelevant but still better to play
> safe at least over one kernel release before making it default.
> 

No, it doesn't loose accuracy =) It's as accurate with both modes.
The difference is, that the other does things in bursts;
that's called evolution rather than regression =) That's how
things will be in the future =)

> Return value prints from omap_pcm_pointer while playing
> "aplay -f dat /dev/zero"
> 
> element:
> 614
> 669
> 691
> 712
> 734
> 755
> 
> threshold:
> 512
> 512
> 512
> 1024
> 1024
> 1536
> 
> 

