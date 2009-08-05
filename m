From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 01/20] OMAP: McBSP: Provide functions for
	ASoC frame syncronization
Date: Wed, 5 Aug 2009 10:18:09 +0300
Message-ID: <200908051018.09304.peter.ujfalusi@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 30 July 2009 15:49:24 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>
> ASoC has an annoying bug letting either L or R channel to be
> played on L channel. In other words, L and R channels can
> switch at random. This provides McBSP funtionality that may
> be used to fix this feature.
>
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    2 +
>  arch/arm/plat-omap/mcbsp.c              |   52
> +++++++++++++++++++++++++++++++ 2 files changed, 54 insertions(+), 0
> deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h
> b/arch/arm/plat-omap/include/mach/mcbsp.h index bb154ea..77191c5 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -389,6 +389,8 @@ int omap_mcbsp_request(unsigned int id);
>  void omap_mcbsp_free(unsigned int id);
>  void omap_mcbsp_start(unsigned int id);
>  void omap_mcbsp_stop(unsigned int id);
> +void omap_mcbsp_xmit_enable(unsigned int id, u8 enable);
> +void omap_mcbsp_recv_enable(unsigned int id, u8 enable);
>  void omap_mcbsp_xmit_word(unsigned int id, u32 word);
>  u32 omap_mcbsp_recv_word(unsigned int id);
>
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index efa0e01..84cc323 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -398,6 +398,58 @@ void omap_mcbsp_stop(unsigned int id)
>  }
>  EXPORT_SYMBOL(omap_mcbsp_stop);
>
> +void omap_mcbsp_xmit_enable(unsigned int id, u8 enable)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	void __iomem *io_base;
> +	u16 w;
> +
> +	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
> +		return;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return;
> +	}
> +
> +	mcbsp =3D id_to_mcbsp_ptr(id);
> +	io_base =3D mcbsp->io_base;
> +
> +	w =3D OMAP_MCBSP_READ(io_base, XCCR);
> +
> +	if (enable)
> +		OMAP_MCBSP_WRITE(io_base, XCCR, w & ~(XDISABLE));
> +	else
> +		OMAP_MCBSP_WRITE(io_base, XCCR, w | XDISABLE);

Have you tried to play with the SPCR2:XRST bit instead of the XCCR:XDISABLE?
It places the transmitter to reset, thus disabling it also, furthermore it =
is =

available on OMAP1 as well, so we can use the same code there as well...

> +}
> +EXPORT_SYMBOL(omap_mcbsp_xmit_enable);
> +
> +void omap_mcbsp_recv_enable(unsigned int id, u8 enable)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	void __iomem *io_base;
> +	u16 w;
> +
> +	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
> +		return;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return;
> +	}
> +
> +	mcbsp =3D id_to_mcbsp_ptr(id);
> +	io_base =3D mcbsp->io_base;
> +
> +	w =3D OMAP_MCBSP_READ(io_base, RCCR);
> +
> +	if (enable)
> +		OMAP_MCBSP_WRITE(io_base, RCCR, w & ~(RDISABLE));
> +	else
> +		OMAP_MCBSP_WRITE(io_base, RCCR, w | RDISABLE);

Same goes here: can you try the SPCR1:RRST bit here instead of the =

RCCR:RDISABLE?

> +}
> +EXPORT_SYMBOL(omap_mcbsp_recv_enable);
> +
>  /* polled mcbsp i/o operations */
>  int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
>  {

-- =

P=E9ter
