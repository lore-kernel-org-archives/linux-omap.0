From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 18:55:42 +0100
Message-ID: <456F1B1E.1050305@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4550CA9E.6090500@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Daniel Walker and myself have done both the clocksource and clockevent
> drivers for the 32k timer and MPU timers on OMAP1.
> 
> The clocksource driver has been submitted to RMK's patchsystem (but not
> yet integrated, RMK is waiting some settling in mainline too) and the
> rest has been submitted to Thomas Gliexner and will be included in his
> next -hrt-dyntick patcheset[2]
> 
> The active -hrt-dyntick work is going on in -mm right now.  The attached
> patchset (against 2.6.19-rc2-mm2) includes the latest OMAP patches which
> will be part of the next -hrt-dyntick patchset.

I checked links below and can't find anything of your 
patches integrated there. Do I miss anything?

I wonder because 2.6.19 is out now and mainline patch window 
opens for 2.6.20.

Cheers

Dirk

http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick4.patch
http://people.redhat.com/mingo/realtime-preempt/patch-2.6.19-rt1
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
