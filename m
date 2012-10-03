From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3.7-rc1] omap zoom2.c: Fix compile error by
 including correct header files
Date: Wed, 03 Oct 2012 17:52:20 +0300
Message-ID: <506C5124.3050200@ti.com>
References: <1349274686-45668-1-git-send-email-tim.gardner@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1349274686-45668-1-git-send-email-tim.gardner@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Gardner <tim.gardner@canonical.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 10/03/2012 05:31 PM, Tim Gardner wrote:
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: linux-omap@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  sound/soc/omap/zoom2.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
> index 23de2b2..d0a8c92 100644
> --- a/sound/soc/omap/zoom2.c
> +++ b/sound/soc/omap/zoom2.c
> @@ -27,9 +27,10 @@
>  
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
> -#include <mach/gpio.h>
> +#include <linux/gpio.h>
>  #include <mach/board-zoom.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> +#include <linux/platform_data/gpio-omap.h>
>  
>  /* Register descriptions for twl4030 codec part */
>  #include <linux/mfd/twl4030-audio.h>
> 

I have the same patch stashed away for the same issue. Was waiting for rc1 to
send it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
