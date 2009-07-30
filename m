From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 06/20] OMAP: McBSP: Use appropriate value
 for startup delay
Date: Thu, 30 Jul 2009 21:56:42 +0300
Message-ID: <20090730215642.2f509757.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
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
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 30 Jul 2009 15:49:29 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -394,7 +394,8 @@ void omap_mcbsp_start(unsigned int id)
>  	w = OMAP_MCBSP_READ(io_base, SPCR1);
>  	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
>  
> -	udelay(100);
> +	/*  Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec */
> +	udelay(500);
>  
Note: udelay(100) us used to wait at least 2 CLKSRG cycles (as stated
in TRM).

Are you sure this change is necessary? CLKSRG is kind of master clock
to McBSP so original stetson guessed (?) 100 us should be fine for all
serial links where bit clock is higher than 20 kHz.

-- 
Jarkko
