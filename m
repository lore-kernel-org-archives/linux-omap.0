From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: Re: ASoC : underrun messages
Date: Wed, 28 Jan 2009 19:13:02 +0530
Message-ID: <ef0d8a250901280543la4cb93fgb92dc944af4fd09e@mail.gmail.com>
References: <ef0d8a250901280539v7f0b4a74nfb698796e72fb247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ef0d8a250901280539v7f0b4a74nfb698796e72fb247@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-omap-open-source@linux.omap.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 7:09 PM, Naveen Krishna Ch <
naveenkrishna.ch@gmail.com> wrote:

> Hello,
>
> I am experiencing some audio issue
> While playing using aplay
> some times i see the following messages.
> (Sorry if the messages are too long)
>
> [root@OMAP3 audio_samples]#aplay sample_96K.wav
>  Playing WAVE 'sample_96K.wav' : Signed 16 bit Little Endian, Rate 96000
> Hz, Stereo
> underrun!!! (at least 1307.251 ms long)
> underrun!!! (at least 554.656 ms long)
> underrun!!! (at least 988.861 ms long)
> underrun!!! (at least 554.443 ms long)
> underrun!!! (at least 987.670 ms long)
> underrun!!! (at least 995.484 ms long)
> ^CAborted by signal Interrupt...
>
> [root@OMAP3 audio_samples]#aplay sample_48K.wav
> Playing WAVE 'sample_48K.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
> Stereo
> underrun!!! (at least 69.306 ms long)
> underrun!!! (at least 130.981 ms long)
> underrun!!! (at least 205.750 ms long)
> underrun!!! (at least 178.100 ms long)
> underrun!!! (at least 146.057 ms long)
> ^CAborted by signal Interrupt...
>
> [root@OMAP3 audio_samples]#aplay sample_8K.wav
> Playing WAVE 'sample_8K.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
> Stereo
> ^C^[[AAborted by signal Interrupt...
>
> [root@OMAP3 audio_samples]#aplay sample_22K.wav
> Playing WAVE 'sample_22K.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
> Stereo
> ^CAborted by signal Interrupt...
>
> [root@OMAP3 audio_samples]#aplay sample_44K.wav
> Playing WAVE 'sample_44K.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> underrun!!! (at least 1602.264 ms long)
> underrun!!! (at least 873.078 ms long)
> underrun!!! (at least 1693.268 ms long)
> underrun!!! (at least 870.483 ms long)
> underrun!!! (at least 540.466 ms long)
> underrun!!! (at least 1122.711 ms long)
>
> I am using OMAP3430 + twl4030 ASoC audio codec drivers.
>
> I understand that the prints are coming from alsa-lib aplay.c file

sorry mistaken the print is from  .alsa-lib/src/pcm/pcm.c

>
> As a result of the client not reading the buffers fast enough.
>
> These are not conditionally reproducible, i see them uncertainly.
>
> I saw the same isue with 2.6.26 some one suggested me to find
> if there is any bug in the asoc layer.
> Now i am using 2.6.28 kernel from kernel.org but still got the same
>
> Can any one suggest me a way to find a fix for this..
> --
> Cheers
> (: Naveen Krishna Ch :)
>



-- 
Cheers
(: Naveen Krishna Ch :)
