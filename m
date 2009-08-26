From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Audio capture not working with AIC23/McBSP1 on
 OMAP3517
Date: Wed, 26 Aug 2009 16:42:39 +0300
Message-ID: <20090826164239.a574d4ab.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<20090826130356.GB29299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090826130356.GB29299@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 Aug 2009 14:03:56 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Aug 26, 2009 at 06:30:52PM +0530, Aggarwal, Anuj wrote:
> 
> > I am trying to capture audio through LineIn on my OMAP3517 EVM, using 
> > AIC23 codec and McBSP1, and getting the following error:
> 
> > arecord: pcm_read:1529: read error: Input/output error
> 
> That suggests that DMA isn't happening - might be worth checking to see
> that clocks are being generated properly.
> 
> > Playback is working fine using the same combination. 
> 
What is exactly your configuration: Is the AIC23 master or slave, how
is the McBSP1 is connected (it has additional FSR and CLKR pins
compared to other ports) and is the pin muxing correct?

I think I have tested the McBSP1 on Beagle but definitely only OMAP as a
master since my codec was oscilloscope.

> Which kernel are you using?  There are rather a lot of McBSP changes
> queued up for 2.6.32.  If this ever worked in the past a git bisect
> might be interesting.

Those recent patches should not any effect into this since they are
mostly playing with the McBSP and DMA interfacing. What comes to my
mind if muxing is correct and if codec is master, this might be related
to those McBSP1 FSR and CLKR setup.


-- 
Jarkko
