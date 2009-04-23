From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 11:16:14 -0700
Message-ID: <a46a26fd0904231116y4abc7ab2k93bb02806e029f6e@mail.gmail.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<200904231220.14465.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200904231220.14465.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, ext twebb <taliaferro62@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 23, 2009 at 2:20 AM, Peter Ujfalusi <peter.ujfalusi@nokia.com>wrote:

> On Wednesday 22 April 2009 20:58:01 ext twebb wrote:
> > Problem 2:
> > Test tone is being presented by the user application, providing a 1Khz
> > tone sampled at 44.1Khz. The data are S16_LE, right channel only. Left
> > channel is quiet. The data seems to slip back and forth from left to
> > right channel. This is reproducable and verified with a scope trace.
> >
> > Anybody have any ideas what might be going wrong here?  Traces for
> > codec reg dump and mcbsp are attached.
>
> As Jarkko already asked: are you seeing the channel switch while running or
> is
> it happens on playback start?
>
> AFAIK this phenomena can be also seen on Beagle board.
>
> I have done some investigation regarding to these, but so far I can not say
> that I know what causes it.
>
> BTW: these are separate issues (startup switch and runtime switch).
>

I have seen the startup switch happening and I investigated it a bit.
The XDISABLE bit solution discussed on the list earlier did not solve the
problem fully, additionally I needed to add check for the FIFO state before
clearing XDISABLE.

Simplified:

1. Set XDISABLE bit
2. Start DMA
3. Start serial port.
4. Wait for the DMA to put data into McBSP FIFO (there is status you can
poll for this)
5. Clear XDISABLE bit.

I found that without step #4 the FIFO would sometimes be empty on step #5
and switching happened because first word sent was bogus and second was the
first audio word.

This was on OMAP2430.

 - Juha

-- 
Madness takes it's toll. Please have exact change.
