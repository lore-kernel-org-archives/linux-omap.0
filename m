From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] OMAP: McBSP: Add 32-bit mode support
Date: Thu, 13 May 2010 16:28:57 +0100
Message-ID: <20100513152856.GB14499@sirena.org.uk>
References: <1273757957-7299-1-git-send-email-slapin@ossfans.org>
	<1273764248-14043-1-git-send-email-slapin@ossfans.org>
	<20100513152755.GA14499@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20100513152755.GA14499@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey Lapin <slapin@ossfans.org>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 04:27:55PM +0100, Mark Brown wrote:
> On Thu, May 13, 2010 at 07:24:08PM +0400, Sergey Lapin wrote:
> > This patchs should allow to use 32-bit samples on e.g. TLV320AIC3x codec,
> > or others.
> 
> > Signed-off-by: Sergey Lapin <slapin@ossfans.org>
> 
> > +	default:
> > +		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
> > +			 OMAP_DMA_DATA_TYPE_S16;
> > +		break;
> 
> Defensiveness would seem to dictate returning an error here - no other
> sample sizes are advertised so you should never get here anyway.

Oh, and please CC maintainers on patches - adding Liam for visibility.
