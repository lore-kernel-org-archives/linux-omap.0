From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Free dma buffers in case
	of error.
Date: Thu, 19 Apr 2012 19:00:55 +0300
Message-ID: <CAPo=G1yqVDj1u3_d28MzE1POaJcvi3e2VVh3i5EqmJuwgWWWkQ@mail.gmail.com>
References: <1334795870-5726-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1334795870-5726-1-git-send-email-oleg.matcovschi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Apr 19, 2012 at 3:37 AM, Oleg Matcovschi <oleg.matcovschi@ti.com> w=
rote:
> Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> ---
> =A0sound/soc/omap/omap-pcm.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index a2a464f..380a5bd 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -414,6 +414,10 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *=
rtd)
> =A0 =A0 =A0 =A0}
>
> =A0out:
> + =A0 =A0 =A0 /* free preallocated buffers in case of error */
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pcm_free_dma_buffers(pcm);
> +

If the playback preallocation fails, or if only capture is supported
on the dai link
this is not needed.
It only applies if we have both playback and capture streams and the capture
preallocation fails.
Luckily the omap_pcm_free_dma_buffers() has internal checks for these cases=
...

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
