From: Tomas Novotny <tomas@novotny.cz>
Subject: Re: omap-mcbsp: TX Buffer Overflow
Date: Tue, 10 Sep 2019 10:05:39 +0200
Message-ID: <20190910100539.03a4ea67@tomas.local.tbs-biometrics.cz>
References: <20190906165109.53c5a306@tomas.local.tbs-biometrics.cz>
 <20190907091358.GA7166@lenoch> <20190909162407.GO52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190909162407.GO52127@atomide.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Mon, 9 Sep 2019 09:24:07 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Ladislav Michl <ladis@linux-mips.org> [190907 09:14]:
> > On Fri, Sep 06, 2019 at 04:51:09PM +0200, Tomas Novotny wrote:  
> > > Hi,
> > > 
> > > we have AM3703 based board similar to BeagleBoard. I'm hitting this error
> > > after upgrade to latest LTS 4.19.71 (upgraded from 4.1):
> > > 
> > > omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!
> > > 
> > > This appears during or after playing of short (~2s) ding-dong wav. That error
> > > exists for longer time, because handling of tx buffer overflow irq was
> > > introduced in 2016: 4e85e7776eba ("ASoC: omap-mcbsp: Enable TX/RX under and
> > > overflow interrupts"). I've cherry-picked it to 4.1 and I see the error there also.
> > > The sound seems clear and ok to me, but we are using low quality speaker.  
> > 
> > Just FYI, for stream capture there's
> > omap-mcbsp 49022000.mcbsp: RX Buffer Underflow!
> > 
> > As far as I remember all stable kernels we have in production - 4.9.x, 4.14.x and
> > 4.19.x - are affected. IGEPv2 with both DM3730 and OMAP3530 are affected
> > (headless machines, CONFIG_VIDEO_OMAP3=n).  
> 
> Hmm I wonder if this is still related to the SoC idling?
> See commit 9834ffd1ecc3 ("ASoC: omap-mcbsp: Add PM QoS support for McBSP
> to prevent glitches"), maybe something still needs to be fixed in that
> area.

I also found the cpuidle information somewhere, but CPU_IDLE=n (and let PM=y)
didn't help me. I'm speaking just for playback. I can do some better test if
you want.

Thanks,

Tomas

> > And DT is probably worth updating:
> > omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
> > omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
> > 
> > I never motivated myself to dig deeper as catured stream looks pretty normal.  
> 
> These mean the devices should really have separate nodes
> in the dts rather than combining multiple devices into a
> single node with multiple reg entries.
> 
> The issue with combining multiple devices into a single device
> is that flushing posted write with a read back to one register
> range will not flush it for the other which can cause mysterious
> bugs.
> 
> Regards,
> 
> Tony
> 
