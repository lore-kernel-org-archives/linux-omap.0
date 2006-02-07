From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: omap alsa tsc2101 driver
Date: Tue, 07 Feb 2006 22:40:08 +0200
Message-ID: <43E905A8.9090307@cc.jyu.fi>
References: <43E66CF6.8040600@cc.jyu.fi>	
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>	
	<43E7AEC3.3020901@cc.jyu.fi>	
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>	
	<43E8960E.6090005@cc.jyu.fi>
	<9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Daniel Petrini wrote:

>Hi,
>
>On 2/7/06, lamikr <lamikr@cc.jyu.fi> wrote:
>  
>
>>>Yes, I am sending it right now (I have just updated my tree). Please
>>>note that it is really work in progress code, with remaining debug
>>>printks and so on. I will clean up soon.
>>>Try to make it work w/ your device, you will have to change the board*
>>>file accordingly H2 or osk in this patch.
>>>
>>>
>>>      
>>>
>>Yes, I made the changes. I kind of liked from the idea to codec
>>aic/tsc2101 specific
>>functions in the board, but the side-effect is that I was not able to
>>build the driver anymore
>>as a module. (I got unresolved function errors in the end of build). But
>>when selecting to
>>build the driver in to image, it compiled just fine.
>>    
>>
>
>That will be fixed. The idea to have separeted file for alsa generic
>and codecs is that you can work or improve diferent parts of the
>driver indenpendently. And of course reuse code.
>  
>
Yes, that seems to be very doable. In my driver I just planned to take
the tsc2101 code
totally separately until I can get it somehow working.

>Humm, Maybe the problems dwells in this function:
>omap_get_dma_src_addr_counter
> (called in alsa-omap driver core file) Please try to analyse its
>behavior for omap1510, the idea is to get the current position of a
>dma transfer. Maybe the registers are diferent in 1510 which has
>different dma engine.
>  
>
Thanks for the idea, I will try to investigate it later on today. I just
checked
that the OSS code is not relying to omap_get_dma_src_addr_counter()
function at all
so that might explain the reason why the oss version works for me.

>>Any changes you could also test the playback with my driver version, it
>>could help me to identify the problem
>>    
>>
>
>I compiled but I can not play yet, I think that my alsa programs are
>old in my rootfs. I compile them as modules or integrated without
>success. I will update my rfs.
>It says: alsactl: load_state:1236: No soundcards found...
>After I make it run I give you a feedback.
>  
>
Hmm, did you remember to change the board code, to register the driver?
I use here:
static struct platform_device h6300_mcbsp1_device = {
    .name        = "omap_tsc2101_mcbsp",
    .id        = 1,
};

static struct platform_device *h6300_devices[] __initdata = {
    &h6300_mcbsp1_device,
};

If the driver loads correctly, you should be able to use alsamixer with
recent alsa utils.
The version I have tested here is from alsa 1.0.9. In addition you can
turn the debug on from omap-alsa.h

>>Below is the debug from my attempt with your driver...
>>
>>Mika
>>
>>root@h6300:~# aplay 01_the_grudge.mp3
>>Playing raw data '01_the_grudge.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>    
>>
>
>The support for 8Khz is not ok yet although I think that you have
>tested for other frequencies. I can see in the remaining of the debug
>that it seems ok. Maybe the problem is in that function pointed above.
>  
>
With speaker-test I have used many frequencies but from wav-files I only
tested
"Signed 16 bit Little Indian with 44100 hz". The madplay I have here
requires me to modprobe
snd-pcm-oss OSS compatibility module.

Mika
