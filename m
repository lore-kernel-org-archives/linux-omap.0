From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] [RFC] ASoC: OMAP: fix OMAP1510 broken PCM
	pointer callback
Date: Mon, 29 Jun 2009 09:37:58 +0300
Message-ID: <200906290937.58786.peter.ujfalusi@nokia.com>
References: <200906280021.05931.jkrzyszt@tis.icnet.pl>
	<20090628223732.53954402.jhnikula@gmail.com>
	<200906290008.59640.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200906290008.59640.jkrzyszt@tis.icnet.pl>
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
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 29 June 2009 01:08:59 ext Janusz Krzysztofik wrote:
>
> AFAIK, both CSSA_L and CDSA_L DMA registers are static. Loaded by CPU with
> 16 LSB of initial source and destination port addresses respectively, they
> are never updated by the DMA engine itself. That's why they can't be used
> for transfer progress indication unless updated by CPU.
>
> The old omap-alsa driver was just updating them, intentionally or not, by
> reprogramming and restarting DMA every PCM period. That's why calculating
> PCM pointers from CSSA_L/CDSA_L worked.
>
> ASoC OMAP driver transfers whole PCM buffer with single DMA transfer, so =
it
> doesn't need to update DMA source/destination port address after initial
> playback/capture setup, even if restarting DMA, and actually never does
> this. Calculating PCM pointers from CSSA_L/CDSA_L registers without
> updating them every period would then be wrong.
>
> For capture, reading CPC, that follows destination port address progress,
> just works fine (for both old and new driver). For playback, similar
> hardware functionality seems to be missing, so it has to be emulated in
> software if required.

Hmmm, I had taken a look at the 2.4.21 kernel sources, which I have laying =

around in my disk from an old project which used OMAP1510. The OSS audio co=
de =

does use the CPC register for determining the DMA progress both for playbac=
k =

and recording. I know that the audio was working OK on that board, since we =

had doom running there.
The difference that I can see is that the OSS code also configured the =

CCR:SYNC(4:0) bits as well.
Looking at the DMA_CPC register description in the OMAP1510 TRM: it list tw=
o =

cases on how it behaves and both require the DMA_CCR:SYNC !=3D 0...

The current DMA code for OMAP1510 just plain ignores the DMA_CCR:SYNC for s=
ome =

reason.
Can you try the following patch:

iff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7fc8c04..38874e4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -266,6 +266,8 @@ void omap_set_dma_transfer_params(int lch, int data_typ=
e, =

int elem_count,
                ccr &=3D ~(1 << 5);
                if (sync_mode =3D=3D OMAP_DMA_SYNC_FRAME)
                        ccr |=3D 1 << 5;
+               if (dma_trigger)
+                       ccr |=3D dma_trigger & 0x1f;
                dma_write(ccr, CCR(lch));

                ccr =3D dma_read(CCR2(lch));

Than can you print out in case of playback both the destination and source =

addresses supplied to the DMA, than in the pointer callback also print out =
the =

value returned by the omap_get_dma_src_pos function to see if this actually =

helps?

-- =

P=E9ter
