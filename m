From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 2/4] SOUND: SOC: CODECS: Add
	support	for	the TWL4030 audio codec
Date: Tue, 02 Sep 2008 21:51:59 +0100
Message-ID: <1220388719.6499.232.camel@odin>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<1220306279-27977-3-git-send-email-sakoman@gmail.com>
	<20080902112633.GB25176@sirena.org.uk>
	<5e088bd90809020725g1d0dff70ue84f861ea3e22201@mail.gmail.com>
	<20080902145328.GA3764@rakim.wolfsonmicro.main>
	<5e088bd90809020936i2d5e8a12lee33acfe5cbd8cd6@mail.gmail.com>
	<20080902185432.GA3553@sirena.org.uk> <1220386089.6499.223.camel@odin>
	<20080902203120.GA20914@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080902203120.GA20914@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Steve Sakoman <sakoman@gmail.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2008-09-02 at 21:31 +0100, Mark Brown wrote:
> On Tue, Sep 02, 2008 at 09:08:09PM +0100, Liam Girdwood wrote:
> > On Tue, 2008-09-02 at 19:54 +0100, Mark Brown wrote:
> 
> > > OK, a comment to that effect somewhere (perhaps in set_sysclk() which
> > > only accepts 26MHz) probably wouldn't go amiss.
> 
> > The codec set_sysclk() should also accept 19.2MHz and 38.4MHz otherwise
> > return -EINVAL. It should also have a nice comment too :)
> 
> Ideally, yes but it looked like that'd need additional code to set the
> codec up to use them.  Obviously the ideal thing would be if the driver
> supports everything the chip does.

Then this should also be marked as a TODO. The likely users of the
SYSCLK value are the codecs DSP core (for audio filtering) and codec DAI
mastering.

Liam
