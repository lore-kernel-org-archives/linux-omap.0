From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 4/5] ASoC: omap: n810: Correct the cpu_dai,
 platform and codec name
Date: Thu, 26 Apr 2018 21:17:43 +0300
Message-ID: <0a2a6c9f-4e2c-6ecd-5c43-61f32c6265e9@bitmer.com>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
 <20180426115115.13744-5-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-5-peter.ujfalusi@ti.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On 04/26/18 14:51, Peter Ujfalusi wrote:
> The non DT boot is no longer supported and when booting with DT the device
> names are different.
> 
> Fix them up for now, but the n810.c should be updated to support probing
> via DT with proper bindings.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/n810.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
