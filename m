From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [RFC 16/23] ASoC: omap: mcbsp, mcpdm,
 dmic: raw read and write endian fix
Date: Sat, 16 Nov 2013 18:09:51 +0200
Message-ID: <528798CF.4060609@bitmer.com>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-17-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1384560086-11994-17-git-send-email-taras.kondratiuk@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: alsa-devel@alsa-project.org, Victor Kamensky <victor.kamensky@linaro.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linaro-networking@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/16/2013 02:01 AM, Taras Kondratiuk wrote:
> From: Victor Kamensky <victor.kamensky@linaro.org>
> 
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
> 
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
>  sound/soc/omap/mcbsp.c      |   12 ++++++------
>  sound/soc/omap/omap-dmic.c  |    4 ++--
>  sound/soc/omap/omap-mcpdm.c |    4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
Looks ok to me by looking at the _relaxed definitions in
arch/arm/include/asm/io.h.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
