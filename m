From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Wed, 5 Aug 2009 10:21:49 +0300
Message-ID: <20090805102149.bfcafa35.jhnikula@gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<4A76ED80.6040001@tis.icnet.pl>
	<20090803181405.6249b843.jhnikula@gmail.com>
	<200908042246.09919.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200908042246.09919.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Arun K S <arunks@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Thanks for good debuging!

On Tue, 4 Aug 2009 22:46:09 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> For both playback start while capturing and capture start while playing, 
> XSYNC_ERR/RSYNC_ERR is clear and XRDY/RRDY is ready, respectively, both 
> before and after omap_start_dma(). No DMA transfer is actually started, so 
> the operation fails with i/o error.
> 
> My interpretation based on my SPRU592 and SPRU674 understanding:
> 
FYI: there is also SPRU708 for OMAP5910 McBSP.

> While starting the first stream, omap_mcbsp_start(), called by 
> omap_mcbsp_dai_trigger(), instructs McBSP to start shifting bits in both 
> directions, no matter which one has just been requested. After that, the 
> direction, for which a corresponding DMA transfer has just been started from 
> omap_pcm_trigger() with omap_start_dma(), starts doing its job, while the 
> opposite direction, after shifting in one word in case of capture, issues a 
> DMA event that is missed and waits for an I/O to occur.
> 
> Then, when omap_pcm_trigger() starts DMA for the opposite direction, the DMA 
> controller, configured for synchronized transfer, waits for a corresponding 
> DMA event before it performs its first I/O operation. That event already 
> occurred far before and will not occur again, so the transfer will not start 
> without any intervention. This time, omap_mcbsp_start() is not called again 
> for an already started hardware action (correct), so there is no chance for 
> the transfer to start that way.
> 
This sounds very logical explanation. I didn't find any information how
the DMA request (or event as stated in those documents) from McBSP of
the 1510/5910 is de-asserted but it very likely looks by your
observations that it's just an event which can be missed if the DMA is
not configured when it happens.

In later OMAP's it looks that the DMA request is level sensite (I
didn't check) and will clear only after the data register is accessed by
the DMA since the problem doesn't occur there.

> If my analysis is correct, the best solution I can see would be starting McBSP 
> transfer for one direction only, not both, so the opposite direction can be 
> started when needed. That requires deeper and wider OMAP knowledge and a 
> change in omap_mcbsp_start() API though. I am not in a position to deal with 
> this myself, I'm afraid.
> 
I favor this change. Actually I remember I was thinking shortly to
change API of omap_mcbsp_start and _stop more than year back or so but
didn't find it necessary back then.

I think change will be trivial. Basically two new arguments indicating
are the TX/RX active and let the first/last caller to deal with
sample-rate generator and frame sync activation/de-activation.

This API change would also clean-up these two patches:

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-July/019821.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-July/019826.html

> PS: Not CCing arch/arm/plat-omap/mcbsp.c author as his email address is 
> probably out-of-date.

Yes it is (s/nokia.com/intel.com/).


-- 
Jarkko
