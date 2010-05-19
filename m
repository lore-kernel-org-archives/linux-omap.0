From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/4] OMAP: mcbsp - add smart idle
 configuration API
Date: Wed, 19 May 2010 14:31:21 +0300
Message-ID: <20100519113121.GO4265@besouro.research.nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
	<20100519104628.GJ4265@besouro.research.nokia.com>
	<1274268086.3240.136.camel@odin>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274268086.3240.136.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 19, 2010 at 01:21:26PM +0200, Liam Girdwood wrote:
> On Wed, 2010-05-19 at 13:46 +0300, Eduardo Valentin wrote:
> > Hello Lian,
> > 
> > On Tue, May 18, 2010 at 10:13:12PM +0200, Liam Girdwood wrote:
> > > Add a small API to configure McBSP smart idle modes
> > > to conserve power.
> > 
> > I'm sorry but I didn't get the point of this patch, as you didn't add any wider
> > description why you need to export this feature. 
> 
> Sorry, I thought this would obvious from the patch and description.
> 
> > Why do you think mcbsp clients
> > should be aware of these bit? Would it make sense to mask it behind other feature?
> > like the threshold size for instance..
> 
> Why do you think it should be masked behind threshold ? 

Well, that was just an example. It could be masked there because, if client doesn't set the
threshold level, you could assume you don't need to set the smart idle.

Or maybe it could be bound to dma op mode. if element mode, then no need to smart idle.
I guess that was the way it was, at some point.

> 
> Liam
> -- 
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
> 
