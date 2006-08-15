From: David Cohen <david.cohen@indt.org.br>
Subject: Re: quick test OMAP ALSA driver on H2
Date: Tue, 15 Aug 2006 14:18:27 -0400
Message-ID: <44E20FF3.9030008@indt.org.br>
References: <304D2A85A9643F4A991BDDF8D297BBA6041524A8@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA6041524A8@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Zhang, Jian" <jzhang@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Jian,

ext Zhang, Jian wrote:
> Anderson and Daniel,
>
> First of all, I appreciate your info. I completely ignored ALSA utils.
> The ALSA web site did talk about directly cating a file to a PCM device
> node. I thought that would be a quick & dirty check. Can you tell me the
> devices under /dev/snd/?
>
> Just downloaded alsa 1.0.11 utils and tried to cross compile it. The
> following command doesn't seem to pass the right lib location. Any idea
> what's going wrong?
>
> $ CC=arm_v5t_le-gcc ./configure --target=arm-linux --host=i686-pc-linux
> --prefix=~/alsa/alsa-lib-1.0.11/
>
> ....
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
> checking for libasound headers version >= 1.0.9... not present.
> configure: error: Sufficiently new version of libasound not found.   
>
>   
It seems either you don't have the alsa-lib cross-compiled or you need
to pass the alsa-lib headers path.
BTW, why don't you try to use scratchbox to cross-compile? Could make
your task easier. :)

Kind regards,

David Cohen
> Regards,
> Jian
>
> -----Original Message-----
> From: Anderson Briglia [mailto:anderson.briglia@indt.org.br] 
> Sent: Tuesday, August 15, 2006 9:44 AM
> To: ext Daniel Petrini
> Cc: Zhang, Jian; OMAP-Linux
> Subject: Re: quick test OMAP ALSA driver on H2
>
> Hi Jian,
>
> ext Daniel Petrini wrote:
>   
>> Did you tried aplay and other applications from alsa-utils?
>> In my tests I always walked through that path.
>>     
>
> I compiled a kernel for H2 with ALSA driver (using the latest linux-omap
> git tree) and did
> some tests (just played a wav file) using aplay. The sound was played
> properly.
> You can check if the device is present using "aplay -l" command.
>
> root@arm:~/sound# aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: TSC2101 [H2 TSC2101], device 0: OMAP PCM [omap alsa pcm]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
> Regards,
>
> Anderson Briglia
>
>   
>>> Hi everyone,
>>>
>>> I managed to get a H2 board and booted an ALSA enabled kernel on it.
>>>       
> The
>   
>>> kernel boot log shows "H2 TSC2101" as the #0 ALSA device. To do a
>>>       
> quick
>   
>>> test, I have manually created a pcm device node:
>>> /dev/snd/pcmC0D0 116, 16, c
>>>       
>> [...]
>>
>>     
>>> Regards,
>>>
>>> Jian
>>>       
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   
