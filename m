From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 1/3] aic23: Kconfig fixes for alsa and oss drivers.
Date: Thu, 10 Aug 2006 03:29:20 +0300
Message-ID: <44DA7DE0.6000200@cc.jyu.fi>
References: <4476192B.5070703@cc.jyu.fi> <20060526231248.GN4132@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060526231248.GN4132@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * lamikr <lamikr@cc.jyu.fi> [060525 13:54]:
>   
>> Kconfig fixes to prevent unselecting I2C and I2C-omap drivers is aic23
>> sound driver is selected.
>>     
>
> Pushing all 3 patches today.
>
> Tony
>
>   
Tony

I noticed that patches 2 and 3 are not applied. James Selvam tested that
they were needed in order to get sounds working with innovator.
Can you you still apply the old patches or should I resend them? (Send
originally in 25.5.2006)

In addition to these, audio_process_dma from omap-alsa.c will also need
one more fix that I can send separately.
(2 #ifdef CONFIG_MACH_OMAP_H6300 definitions must be changed to #ifdef
CONFIG_ARCH_OMAP15XX)

Mika
