From: Ajaya Babu Anne <anneajaya@gmail.com>
Subject: Re: Audio L/R Channel Interchanges ( Solved!)
Date: Fri, 25 Nov 2005 18:02:46 +0530
Message-ID: <c43be92d0511250432k3a6e1b20o86cafc211445a4c5@mail.gmail.com>
References: <c43be92d0511182105h6bb9f274q62925dcef7b59ca8@mail.gmail.com>
	<4385F4DC.2040503@de.bosch.com>
	<c43be92d0511242250t43dc6edfx1c632d4ce5a070b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c43be92d0511242250t43dc6edfx1c632d4ce5a070b6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

One More thing:

You need to add in omap-audio-dma-intfc.c in audio_start_dma_chain
function.

if (!s->started) {

 s->hw_stop( ); /* stops McBSP Interface */
 omap_start_dma(channel);
 s->started =3D 1;
 s->hw_start( ); /* start McBSP interface */

 }


On 11/25/05, Ajaya Babu Anne <anneajaya@gmail.com> wrote:
>
> >>Just want to test this because of issues with DMA and ALSA driver. But =
I
> >>can't find what is behind
>
> >>s->hw_stop_stream( );
> >>s->hw_start_stream( );changes required for audio_stream_t in
> omap-audio.h add following elements
>
> int (*hw_stop )( void );
> int (*hw_start)( void );
>
>
> changes in audio driver, omap-audio-aic23.c:
>
> static int audio_ifc_start( void ) {  omap_mcbsp_start(AUDIO_MCBSP);
> return 0; }
> static int audio_ifc_stop( void )  {  omap_mcbsp_stop(AUDIO_MCBSP); retur=
n
> 0; }
>
>
> static audio_stream_t output_stream =3D {
>         .id              =3D "AIC23 out",
>         .dma_dev         =3D OMAP_DMA_MCBSP1_TX,
>         .input_or_output =3D FMODE_WRITE,
>         .hw_start =3D audio_ifc_start,
>         .hw_stop =3D audio_ifc_stop
> };
>
> static audio_stream_t input_stream =3D {
>         .id              =3D "AIC23 in",
>         .dma_dev         =3D OMAP_DMA_MCBSP1_RX,
>         .input_or_output =3D FMODE_READ,
>         .hw_start =3D audio_ifc_start,
>         .hw_stop =3D audio_ifc_stop
> };
>
>
> >> Any hint or even better a patch?
>
> unfortunately my audio driver is little different as I am using MCBSP2 fo=
r
> DAC and MCBSP1 for ADC so it will not work for OSK board. So I just writt=
en
> the changes required in omap-audio-aic23.c for OSK above. Hope this helps=
.
>
>
>
> With Warm Regards,
> Ajaya Babu
>
>
