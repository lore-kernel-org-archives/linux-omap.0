From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Question about microphone usage on OMAP2430SDP
Date: Tue, 23 Jan 2007 23:31:38 -0600
Message-ID: <45B6EF3A.3040401@gmail.com>
References: <dbf1574b0701231757o7186a24dk39d9483ae371eab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <dbf1574b0701231757o7186a24dk39d9483ae371eab5@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: RobertChou <rbtchc@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

RobertChou stated on 1/23/2007 7:57 PM:
> I'm trying to record some voice through Main/Sub & Headset microphone on
> OMAP2430SDP board. But only noises is recorded (does not sound like
> voice).
>
Am assuming you are using OSS driver. Ideally, this code could come over
to 2430 git as ALSA driver.. but i guess, it;d need some time to get the
framework for that in place.. hmm...todo...
anyways, am looking at
http://linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.10-omap2420-omap2430.tgz
which is same as the 2.6.14 code..
>  I have used
>    1. cat /dev/dsp > audio.out & cat audio.out > /dev/dsp   --> failed
failed in what sense? did u do a hexdump audio.out? is it all 0x0000 or
some constant value?
   2. sample program from pjsip (open source sip protocol stack)
>        which config. sample rate=44100, ch=2, bits=16
>        (able to record sound in x86 system)                        -->
> failed
>
>   Besides main/sub mic, I noticed that the record source can be switch to
> Headset by ioctl OSS driver. I tried to use audio connector to 3.5mm
> microphone to the headset plug. But still doesn't work.
Did u  try something simpler, like plugging a speaker (8ohm stereo
speaker) to the 3.5mm jack? the default setting should allow you to
listen to music on that.. cat /bin/ls>/dev/sound/dsp (you should listen
to some noise)...
am hoping that your volume levels are all set properly here... else use
some mixer app like aumix or somethin to set it up.
>
>   I'm using linux-2.6.14-omap2430 downloaded from TI webiste. Does
> anyone ever
> successfully record anything from OMAP2430 main/sub or headset mic?
> And how
yes, it works.. you have ioctls for that..
> can i correctly connect microphone to on-board headset plug? I'm
> currently using
I used a 2.5 mm mono headset+mic combination we can buy at walmart..
:).. dont remember the make though...
> audio connector grab from nokia mobile accessory. Thx for answering my
> question.
I'd say, go step by step...
1. check first that you are able to  play a music on bootup - use a
simple filesystem that does not do any fancy pre-init like starting off
a sound server etc.. cat abc.wav>/dev/sound/dsp (where abc.wav is a
44100 stereo 16 bit wav/raw signed PCM file)
2. use the correct ioctls:
see /drivers/sound/omap-audio-twl4030.c  and the ioctl functions to
understand which ioctls are supported,
see the .h file for the following info:
/*
 * Mapping of OSS devices to TWL devices
 * TWL Device                      OSS MASK
 * ==============================================================
 * OUTPUT:
 * =======
 * OUTPUT_STEREO_HEADSET           SOUND_MASK_LINE1
 * OUTPUT_HANDS_FREE_CLASSD        SOUND_MASK_SPEAKER
 * OUTPUT_MONO_EARPIECE            SOUND_MASK_PHONEOUT (mono Sink)
 *
 * INPUT:
 * ======
 * INPUT_HEADSET_MIC               SOUND_MASK_LINE
 * INPUT_MAIN_MIC + INPUT_SUB_MIC  SOUND_MASK_MIC
 *
 * CURRENT SOURCES:
 * ===============
 * SOUND_MIXER_OUTSRC - output source
 * SOUND_MIXER_RECSRC - input source
 * Operations:
 * MIXER_READ() and MIXER_WRITE() to control the sources
 *
 * VOLUME CONTROL:
 * ===============
 * SOUND_MIXER_RECLEV - control the gain level of recording
 * SOUND_MIXER_VOLUME - control the gain level of playback
 * MIXER_WRITE and MIXER_READ with each of the device masks will
 *                            control the coarse volume control of the
device
 */

using the MIXER_WRITE with SOUND_MIXER_RECSRC with SOUND_MASK_MIC -
records stereo from both main and sub mic (in left and right channels each).
and so on.. read this on a associated issue:
http://www.music.columbia.edu/pipermail/linux-audio-dev/2006-June/016125.html


Regards,
Nishanth Menon
