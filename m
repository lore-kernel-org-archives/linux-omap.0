From: "zil iram" <zil_iram@hotmail.com>
Subject: omap5912 audio driver
Date: Mon, 11 Sep 2006 12:20:25 +0000
Message-ID: <BAY21-F1746C7EECAA525FB8B48FBF82A0@phx.gbl>
References: <20060911033810.89093.qmail@web55802.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060911033810.89093.qmail@web55802.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

       I have been trying out the audio driver for the OSK and I followed 
the procedures in http://oskfordummies.hp.infoseek.co.jp/howto/audio.html. 
When I compiled the kernel (version 2.6.16) with the audio drivers enabled, 
an error occured with this message :
                sound/oss/omap-audio-aic23.c:246: error: unknown field `sem' 
specified in initializer
To move on with my work, I just commented out the line
                .sem        = __SEMAPHORE_INIT(aic23_state.sem, 1)
inside the structure static audio_state_t aic23_state of the file specified 
in the error message.  So the kernel compiled. Do you know what is wrong?
     With what I've done above, I was able to record and playback the sound 
file that I recorded perfectly. However, when I play a different file,  a 
.au Sun/NeXT audio data: 16-bit linear PCM, stereo, 8000 Hz file, the file 
tends to be played really fast even if I have already set the configurations 
through the file audioconf.c given in the link above. When I converted this 
audio file to have a sampling rate of 22050, the playback was almost perfect 
even if the setting was still set to 8khz. I am thinking that the sampling 
rate cannot be set through the audioconf app and that the audio driver is 
using the same constant value.
    Also, when I play mono 16bit .wav files, with sampling rate of 44000 and 
above, all the files are played well even if I am using the same 24000hz as 
sampling rate.
Does anybody know what the problem here is?

Thank you very much,
Zil

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
