From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap1510/16xx fixes for the tsc2101 oss driver
Date: Thu, 19 Jan 2006 12:04:23 -0800
Message-ID: <20060119200423.GL4425@atomide.com>
References: <43CB0447.2000606@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CB0447.2000606@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr <lamikr@cc.jyu.fi>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060115 18:26]:
> 1) mcbsp.h needs to define AUDIO_MCBSP_DATAREAD and
> AUDIO_MCBSP_DATAWRITE functions, etc... both for the omap1510 and
> omap16xx oterwise the sound/oss/omap-audio-dma-intfc.c fails to compile
> with omap1.
> 
> 2) Added cpu_is_omap1510 check to places which earlier only checked
> cpu_is_omap16xx() so that the dma got initialized properly also with the
> omap1510 based iPAQ h6300.
> 
> 3)  DCSR_ERROR check looked suspicious compared to the version in 2.6.14
> kernel. In addition that prevented the sound working after first played
> frame
> in the iPAQ h6300 as assumed always that error had happened.
> 
> After applying attached fixes, cat my_song.wav > /dev/dsp worked ok for me.

Thanks, I'll push this today at some point.

Tony
