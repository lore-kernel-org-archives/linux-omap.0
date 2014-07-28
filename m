From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] dma: edma: Allow to disable eDMA IRQ during cyclic
	transfer
Date: Mon, 28 Jul 2014 09:13:12 +0300
Message-ID: <53D5E9F8.4030401@ti.com>
References: <1405513761-23739-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1405513761-23739-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2014 03:29 PM, Peter Ujfalusi wrote:
> Hi,
> =

> After this series clients can ask to not receive notifications after each=
 period.
> In this case we can disable the completion interrupt since the position r=
eporting
> does not rely on it for cyclic mode.
> Patchset for ASoC part has been sent which allows users space to take adv=
entage
> of SNDRV_PCM_INFO_NO_PERIOD_WAKEUP:
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-July/078993=
.html

ping.

> When both series applied on top of linux-next:
> =

> # cache the audio file in memory
> cat some_music.mp3 > /dev/null
> # start PA
> pulseaudio -v
> # in another terminal, play the music via PA
> mplayer -ao pulse some_music.mp3
> # yet another terminal to monitor the interrupts
> watch cat /proc/interrupts
> # note the non increasing number of edma interrupts ;)
> =

> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   dma: edma: Update caps->residue_granularity to match with reality
>   dma: edma: Support to suppress the period interrupts in cyclic mode
> =

>  drivers/dma/edma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =



-- =

P=E9ter
