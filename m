From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: quick test OMAP ALSA driver on H2
Date: Tue, 15 Aug 2006 10:44:03 -0400
Message-ID: <44E1DDB3.8040808@indt.org.br>
References: <9268368b0608150400t43fc9dfev71a0b9d366eb8286@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9268368b0608150400t43fc9dfev71a0b9d366eb8286@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Jian,

ext Daniel Petrini wrote:
> Did you tried aplay and other applications from alsa-utils?
> In my tests I always walked through that path.

I compiled a kernel for H2 with ALSA driver (using the latest linux-omap git tree) and did
some tests (just played a wav file) using aplay. The sound was played properly.
You can check if the device is present using "aplay -l" command.

root@arm:~/sound# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: TSC2101 [H2 TSC2101], device 0: OMAP PCM [omap alsa pcm]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Regards,

Anderson Briglia

>> Hi everyone,
>>
>> I managed to get a H2 board and booted an ALSA enabled kernel on it. The
>> kernel boot log shows "H2 TSC2101" as the #0 ALSA device. To do a quick
>> test, I have manually created a pcm device node:
>> /dev/snd/pcmC0D0 116, 16, c
> 
> 
> [...]
> 
>> Regards,
>>
>> Jian
> 
