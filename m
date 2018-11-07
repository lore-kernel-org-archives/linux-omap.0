From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 0/7] ASoC: omap-mcbsp: Cleanup and split
 core/sidetone support
Date: Wed, 7 Nov 2018 20:57:37 +0200
Message-ID: <a3939fd6-b120-5723-4674-4d2abfcc5eb5@bitmer.com>
References: <20181107132310.29597-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181107132310.29597-1-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/7/18 3:23 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Two patch added to address the code move triggered few warnings from build.
>   One of them is around mcbsp->pdata checks (not valid complaint), the other is
>   that we set -EINVAL to unsigned variables (they were not used in that case)
> 
> While preparing for merging the davinci and omap directories (I will send the
> series for that shortly) I have taken some time to do cleanup on the McBSP
> driver.
> 
> The mcbsp.c/h files were the result when we moved code from arch/arm/plat-omap
> to sound/soc/omap/ a long time ago and it contained code for McBSP core and the
> OMAP3 sidetone functionality.
> 
> With this series I tried to split the core and sidetone code to separate files.
> 
> There were two reasons for this:
> 1. to have the OMAP specific DAI driver files prefixed with omap-* under the new
>    sound/soc/ti/ directory
> 2. easier to find functions as all sidetone code is in separate file.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   ASoC: omap-mcbsp: Clean up dma_data addr initialization code
>   ASoC: omap-mcbsp: Clean up the interrupt handlers
>   ASoC: omap-mcbsp: Simplify the mcbsp_start/_stop function parameters
>   ASoC: omap-mcbsp: Move out the FIFO check from set_threshold and
>     get_delay
>   ASoC: omap-mcbsp: Re-arrange files for core McBSP and Sidetone
>     function split
>   ASoC: omap-mcbsp: Remove redundant check for mcbsp->pdata
>   ASoC: omap-mcbsp: No need to initialize max_xx_thres when it is not
>     used
> 
Minor comments, no need to resend. Patch 1/7 looked like it could be
splitted into two but don't know is it worth of effort, maybe not. Then
I was thinking can 6-7/7 be moved before 5/7?

I'll try to give a test to the set perhaps during weekend but don't let
that delay the process.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
