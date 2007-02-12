From: Kevin Hilman <khilman@mvista.com>
Subject: Re: OMAP1 realtime patch
Date: Mon, 12 Feb 2007 11:24:30 -0800
Message-ID: <1171308270.20717.32.camel@vence.hilman.org>
References: <45C785A4.6080007@googlemail.com>
	<1170882015.11368.25.camel@vence.hilman.org>
	<45CB6775.7020500@googlemail.com>  <45CF4BD1.6010109@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45CF4BD1.6010109@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2007-02-11 at 18:01 +0100, Dirk Behme wrote:
> Dirk Behme wrote:
> > Kevin Hilman wrote:
> > 
> >> Here is a patch which leaves out the raw_spinlock conversions.  It goes
> >> on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
> >> all the raw_spinlock conversions.  This has been tested on an
> >> OMAP1623/H2 platform.
> > 
> > Update of Kevins update. Tested on OSK.
> > 
> > Changes:
> > 
> > - Remove kernel/printk.c "+    zap_rt_locks();". It's already in -rt5.
> > 
> > - Re-add HRTIMER conversion to ads7846.c
> > 
> > With this patch I get Oops below after playing mp3 via NFS. Add 
> > raw_spinlock_t to sound/arm/omap/omap-alsa-dma.c like in my original 
> > patch doesn't seem to help.
> 
> Re-adding raw_spinlock_t to omap-alsa.h helps against this Oops.

My guess the oops you sent is that you saw this crash when doing a
Ctrl-C or otherwise stopping the playback, correct?

This oops is triggered by the same thread trying to take the same
spinlock (now an rt_mutex under PREEMPT_RT.)  The following patch
fixes the nested spinlocks,  and removes the raw_spinlock.  It applies
on top of your latest patch.

On my OSK, I do notice however that using -rt (with and without this
fix) mp3 playback has some audible noise under PREEMPT_RT.  Do you hear
this too?

Kevin
