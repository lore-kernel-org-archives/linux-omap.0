From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 09:08:44 +0300
Message-ID: <20090423090844.50d05a65.jarkko.nikula@nokia.com>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<7A436F7769CA33409C6B44B358BFFF0C0106373FD4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0106373FD4@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Menon, Nishanth" <nm@ti.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, twebb <taliaferro62@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 22 Apr 2009 20:05:40 +0200
"ext Menon, Nishanth" <nm@ti.com> wrote:

> > Test tone is being presented by the user application, providing a
> > 1Khz tone sampled at 44.1Khz. The data are S16_LE, right channel
> > only. Left channel is quiet. The data seems to slip back and forth
> > from left to right channel. This is reproducable and verified with
> > a scope trace.
>
Is this slipping happening in middle of playback or between the tracks?

> I recollect this issue from years back of OSS driver -> i2s is
> configured as dual phase - mcbsp sends data on both edges, and if the
> data write happen on the wrong edge for the wrong phase, we might get
> mix up.. if I recollect right, configuration for mcbsp was done as a
> single phase with the right edge as a trigger for transfer, the
> transfer size was set as 32 bytes (both channels).. this essentially
> guarentees that mcbsp will never mix up channels.
> 
Thanks Menon! This is sounds a information we should try out. OMAP2420
in N810 is especially suffering from channel swapping between the
tracks and I haven't found time to look any deeper :-(

I know there is a fix for DaVinci (commit
fb0ef645f2c546f8297b2fbf9b2b8fff4a7455e8) but I would like to find
out are there any other or simpler way to fix it than mixing DMA and DAI
setup.


Jarkko
