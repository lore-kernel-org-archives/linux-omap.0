From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Fri, 01 Dec 2006 17:12:20 +0100
Message-ID: <45705464.3070105@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>	
	<456F1B1E.1050305@gmail.com>
	<1164909003.17665.1.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1164909003.17665.1.camel@imap.mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Daniel Walker <dwalker@mvista.com>, Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Daniel Walker wrote:
> On Thu, 2006-11-30 at 18:55 +0100, Dirk Behme wrote:
> 
>>I checked links below and can't find anything of your 
>>patches integrated there. Do I miss anything?
>>
>>I wonder because 2.6.19 is out now and mainline patch window 
>>opens for 2.6.20.
>>
>>http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick4.patch
>>http://people.redhat.com/mingo/realtime-preempt/patch-2.6.19-rt1
>>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
>  
> They went to RMK as far as I know. Someplace in his patch system.

Yes and no ;)

The Versatile and OMAP clocksource patches are in RMKs patch 
system. The OMAP one is updated here on the list.

But as I understand Kevin, the rest has been submitted to 
Thomas Gleixner and was planned to be included in the 
-hrt-dyntick patcheset and then in -mm. And there I couldn't 
find them. Would be a shame if they get lost. Especially the 
OMAP clockevent one.

Cheers

Dirk


Content of your patches-2.6.19-rc2.tar.bz2:

arm-hrt-kconfig.patch
arm-ixp4xx-clockevent.patch
arm-leds-timer.patch
arm-no-hz.patch
arm-versatile-clockevents.patch
arm-versatile-clocksource.patch -> RMK patch system
arm_omap_clockevents.patch
arm_omap_clocksource.patch  -> RMK patch system/ OMAP list
hrt-add-regs-include.patch
