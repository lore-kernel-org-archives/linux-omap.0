From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Free dma buffers in case
 of error.
Date: Fri, 20 Apr 2012 14:08:10 +0100
Message-ID: <20120420130810.GA20681@sirena.org.uk>
References: <1334795870-5726-1-git-send-email-oleg.matcovschi@ti.com>
	<CAPo=G1yqVDj1u3_d28MzE1POaJcvi3e2VVh3i5EqmJuwgWWWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAPo=G1yqVDj1u3_d28MzE1POaJcvi3e2VVh3i5EqmJuwgWWWkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Oleg Matcovschi <oleg.matcovschi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 19, 2012 at 07:00:55PM +0300, Ujfalusi, Peter wrote:

> If the playback preallocation fails, or if only capture is supported
> on the dai link
> this is not needed.
> It only applies if we have both playback and capture streams and the capture
> preallocation fails.
> Luckily the omap_pcm_free_dma_buffers() has internal checks for these cases...

> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Always CC maintainers on patches...
