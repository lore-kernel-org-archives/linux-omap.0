From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in,
	not as a	module
Date: Sat, 31 Dec 2011 00:59:38 +0000
Message-ID: <20111231005935.GA5835@opensource.wolfsonmicro.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
	<20111229212707.GA9737@opensource.wolfsonmicro.com>
	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
	<20111229215407.GB9737@opensource.wolfsonmicro.com>
	<CAMP44s0EzmhdZ4X91c5X7Rn9q44QcUDm2KNDO81ue16SBWM6_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s0EzmhdZ4X91c5X7Rn9q44QcUDm2KNDO81ue16SBWM6_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 30, 2011 at 10:00:55PM +0200, Felipe Contreras wrote:
> On Thu, Dec 29, 2011 at 11:54 PM, Mark Brown
> > On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:

> >> >> > That should not be required, the modules should be loadable in any
> >> >> > order.

> >> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.

> > That is compltelely orthogonal to what you were saying above about the
> > ordering of module loading.

> Not really, because if both are compiled as modules,
> snd_soc_tlv320aic3x will always be loaded first (automatically by
> udev).

Which is relevant because...?  To repeat, the ordering of module loading
is totally ortogonal as any ordering of modules is supported.  You
appear to be totally ignoring what I am writing here.

> > The reason the driver is not loaded automatically is that the OMAP
> > machine drivers have not been converted to platform devices.

> Well, if that's the case then there's a real issue. There doesn't seem
> to be a MODULE_DEPENDS(), or anything like that.

A MODULE_DEPENDS() would also be irrelevant here.

> snd-soc-rx51 seems to depend on snd_soc_tlv320aic3x through
> codec_dai_name, and codec_name, and so on. I don't know how this
> dependency is supposed to work out.

All the drivers should load via the normal driver instantiation
mechainsms and when they're all there they'll get matched together.
