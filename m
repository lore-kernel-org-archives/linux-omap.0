From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Allow only formats with 1,
 2, and 4 byte physical size
Date: Tue, 3 Mar 2015 14:22:08 +0200
Message-ID: <20150303122208.GA28158@bitmer.com>
References: <1425382133-17120-1-git-send-email-jsarha@ti.com>
 <54F59DE1.2010406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <54F59DE1.2010406@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 03, 2015 at 01:41:21PM +0200, Peter Ujfalusi wrote:
> On 03/03/2015 01:28 PM, Jyri Sarha wrote:
> > sDMA support only transfer elements with 1, 2, and 4 byte physical
> > size. Initialize the pcm driver accordingly.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> > 
> > Signed-off-by: Jyri Sarha <jsarha@ti.com>
> > ---
> >  sound/soc/omap/omap-pcm.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> > index f4b05bc..e49ee23 100644
> > --- a/sound/soc/omap/omap-pcm.c
> > +++ b/sound/soc/omap/omap-pcm.c
> > @@ -39,7 +39,7 @@
> >  #define pcm_omap1510()	0
> >  #endif
> >  
> > -static const struct snd_pcm_hardware omap_pcm_hardware = {
> > +static struct snd_pcm_hardware omap_pcm_hardware = {
> >  	.info			= SNDRV_PCM_INFO_MMAP |
> >  				  SNDRV_PCM_INFO_MMAP_VALID |
> >  				  SNDRV_PCM_INFO_INTERLEAVED |
> > @@ -53,6 +53,24 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
> >  	.buffer_bytes_max	= 128 * 1024,
> >  };
> >  
> > +/* sDMA supports only 1, 2, and 4 byte transfer elements. */
> > +static void omap_pcm_limit_supported_formats(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
> > +		switch (snd_pcm_format_physical_width(i)) {
> > +		case 8:
> > +		case 16:
> > +		case 32:
> > +			omap_pcm_hardware.formats |= (1LL << i);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> > +

I wonder why these are set in a loop instead of setting formats statically
and why this is needed after commit 60e21d287344 ("ASoC: omap: Don't set
unused struct snd_pcm_hardware fields")?

-- 
Jarkko
