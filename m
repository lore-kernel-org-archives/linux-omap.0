From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Fri, 05 May 2006 19:14:59 +0300
Message-ID: <445B7A03.6040908@cc.jyu.fi>
References: <4457C35D.4020700@cc.jyu.fi>	
	<fd1e34b0605030420g68f908f7y447d6a4ed2001fc0@mail.gmail.com>	
	<44590581.6070108@cc.jyu.fi>
	<fd1e34b0605040318m4b0d1bd4h58f50589df2a4cdf@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fd1e34b0605040318m4b0d1bd4h58f50589df2a4cdf@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: James Selvam <james.iisc@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

James Selvam wrote:

> Hi Mika/All,
>
> The patch set the MCLK error all right. It infact took the right CLK
> freq of 12 MHz:
>
> Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
> 08:57:20
> 2006 UTC).
> MCLK = 12000000 [12000000], usecount = 1
> audio support initialized
> ALSA device list:
>   #0: OMAP Innovator AIC23
>
> But aplay -l still fails. It fails to recognise and list the hardware
> present:

Hmm, do you have udev installed and do you get nodes created to /dev/snd
directory?

>
> **** List of PLAYBACK Hardware Devices ****
> ALSA lib control.c:818:(snd_ctl_open_noupdate) Invalid CTL hw:0
> aplay: device_list:232: control open (0): No such file or directory
>
> I then tried to do a simple "cat raw_file > /dev/dsp" (OSS emulation
> enabled). It just gave me some noise. Another player "bplay"
> cross-compiled for ARM gave similar results.

So, you were able to hear something? I had some DMA problems with my
OMAP1510 based h6300 and therefore the omap-alsa.c has
#ifdef CONFIG_MACH_OMAP_H6300 in one place. You could try to enable that
also in your board?
For Daniel the AIC23 alsa code however worked with the OSK board without
need for the modifications.

Mika
