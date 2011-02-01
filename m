From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 09/13] OMAP: McBSP: use omap_device APIs
 to modify SYSCONFIG
Date: Tue, 01 Feb 2011 14:19:03 +0200
Message-ID: <4D47FA37.1060001@nokia.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-10-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296485437-12806-10-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 01/31/2011 04:50 PM, ext Kishon Vijay Abraham I wrote:
> McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
> to be disabled before starting the sidetone. Also SYSCONFIG
> register has to be set with smart idle or no idle depending on the
> dma op mode (threshold or element sync). For doing these operations
> dynamically at runtime, omap_device APIs are used to modify SYSCONFIG reg=
ister.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   66 +++++++++++++++++++++++---------------=
-----
>  1 files changed, 35 insertions(+), 31 deletions(-)
> =

> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c

...

>  static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
>  {
> +	struct omap_device *od;
> +
> +	od =3D find_omap_device_by_dev(mcbsp->dev);
>  	/*
>  	 * Enable wakup behavior, smart idle and all wakeups
>  	 * REVISIT: some wakeups may be unnecessary
>  	 */
>  	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -		u16 syscon;
> -
> -		syscon =3D MCBSP_READ(mcbsp, SYSCON);
> -		syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> -
> -		if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_MODE_THRESHOLD) {
> -			syscon |=3D (ENAWAKEUP | SIDLEMODE(0x02) |
> -					CLOCKACTIVITY(0x02));
> +		if (mcbsp->dma_op_mode !=3D MCBSP_DMA_MODE_THRESHOLD)
> +			omap_device_noidle(od);
> +		else

Would it make sense to call here:
omap_device_smartidle(od); ?
What happens, if we configure McBSP to element mode, play a sample,
configure it to threshold?
I think we should explicitly as for smartidle, when we suppose to be in
smartidle.

>  			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
> -		} else {
> -			syscon |=3D SIDLEMODE(0x01);
> -		}
> -
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
>  	}
>  }
>  =

>  static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
>  {
> +	struct omap_device *od;
> +
> +	od =3D find_omap_device_by_dev(mcbsp->dev);
> +
>  	/*
>  	 * Disable wakup behavior, smart idle and all wakeups
>  	 */
>  	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -		u16 syscon;
> -
> -		syscon =3D MCBSP_READ(mcbsp, SYSCON);
> -		syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
>  		/*
>  		 * HW bug workaround - If no_idle mode is taken, we need to
>  		 * go to smart_idle before going to always_idle, or the
>  		 * device will not hit retention anymore.
>  		 */
> -		syscon |=3D SIDLEMODE(0x02);
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
> -
> -		syscon &=3D ~(SIDLEMODE(0x03));
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
> -
> +		omap_device_default_idle(od);
>  		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);

Hrm, it would be better to do it as the comment said:
omap_device_smartidle(od);
omap_device_forceidle(od);

BTW: what is the default_idle in case of McBSP?

-- =

P=E9ter
