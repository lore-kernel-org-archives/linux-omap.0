From: Dirk Behme <dirk.behme@googlemail.com>
Subject: 2.6.21-rc1 merge status
Date: Sun, 18 Feb 2007 18:53:37 +0100
Message-ID: <45D892A1.9040006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

Hi,

I'd like to give you an update about some 2.6.21-rc1 merge 
news from the last few days I'm aware of. There are some 
good news, but unfortunately some bad news as well.

1) Looks like hrtimers and generic clockevents are merged 
into mainline, so (main?) parts from the -rt patches . Now 
Kevin will send a patchset to enable a handful of ARM 
platforms, including OMAP1 [1]. Thanks to Kevin and 
everybody helping with this!

2) Merging our OMAP patches via Russells patch system to 
mainline failed [2]. There was some background discussion 
between Tony, Russell and Andrew how to merge our patches in 
last week. Tony sent some updated patches based on Russells 
comments, but it was too much for Russell for a proper 
review. Russell mentioned ~17klines of changes.

Now, we have to find a proper way how to get our (at the 
moment) large changes merged upstream. Looks like getting 
everything merged in the usual two week merge window isn't 
possible. First we should remove our patchset from Russells 
incoming queue and then discuss how to go on.

3) I saw that some I2C stuff was merged, but don't know the 
exact status. After [3] Dave sent a lot of patches to I2C 
list and there was a lot of discussion. I lost the track 
there while some discussion like "apply patch 6a and use 
this patch and use that patch ..." ;)

Dave: Can you give us an update about I2C status in 
2.6.21-rc1, what went in and what not? What's about the idea 
of "embedded I2C stack"? Many thanks!

Opinions and stuff I missed are welcome.

Cheers

Dirk

P.S.: I couldn't find a working archive of arm-linux-kernel. 
The stuff I can find on

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/

is always broken after some mails of each month. Therefore I 
can give no links here and cite the essential parts of the 
mails from that list here, in case you are not subscribed 
there. Sorry.

[1]

Date: Fri, 16 Feb 2007 17:54:53 -0800
From: Kevin Hilman <khilman@mvista.com>
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] generic clockevents, timer_tick() and LEDs

With the recent arrival (as of today) of hrtimers and generic
clockevents into mainline, I'm about to submit a set of 
patches to
enable a handful of ARM platforms (ixp4xx, versatile and OMAP1.)

However, I would appreciate any feedback on how to handle 
the existing
timer_tick() function in arch/arm/kernel/time.c.  The new 
clockevent
layer now does everything that timer_tick() does, except 
do_leds().

The way this is handled in the current -rt patch (see patch 
below) is
that ifdef'd arch_tick_leds() call is added to the 
arch-independent
do_timer() function.  This then removes the need for the 
timer ISR to
call timer_tick() at all.

Another option would be to remove all the calls handled by 
clockevents
with an #ifdef CONFIG_GENERIC_CLOCKEVENTS inside 
timer_tick() and leave
the timer_tick() call in each ISR.

I prefer the first option and the eventual removal of 
timer_tick().
Any other thoughts?

Also note that the new dynticks support has been added to 
mainline,
which obsoletes the existing stuff done by NO_IDLE_HZ.  From 
what I can
tell, this is currently only used on PXA, sa1100 and OMAP1. 
  In my
patchset, I plan to make NO_IDLE_HZ 'depends on 
!GENERIC_CLOCKEVENTS' as
platforms moving to clockevents should use the new dynticks 
(a.k.a.
NO_HZ) instead.

I'll have a first go at my patchset ready for comments early 
next week.
  For the curious, most of this is already in the current 
-rt patchset.

Kevin

Index: linux-2.6/arch/arm/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/time.c
+++ linux-2.6/arch/arm/kernel/time.c
@@ -234,6 +234,13 @@ static inline void do_leds(void)
  #define	do_leds()
  #endif

+void arch_tick_leds(void)
+{
+#ifdef CONFIG_LEDS_TIMER
+	do_leds();
+#endif
+}
+
  #ifndef CONFIG_GENERIC_TIME
  void do_gettimeofday(struct timeval *tv)
  {
Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -1289,6 +1289,9 @@ void do_timer(unsigned long ticks)
  {
  	jiffies_64 += ticks;
  	update_times(ticks);
+#ifdef CONFIG_LEDS_TIMER
+ 	arch_tick_leds();
+#endif
  }

  #ifdef __ARCH_WANT_SYS_ALARM



[2]

Date: Sat, 17 Feb 2007 20:40:59 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Last Chance before 2.6.21-rc1

On Sat, Feb 17, 2007 at 10:27:41AM +0000, Russell King - ARM 
Linux wrote:
 > Just a quick note to say that I will be merging patches 
for 2.6.21-rc1 up
 > until about 17:00 UTC today.  Anything submitted after 
that is likely to
 > miss the -rc1 release.  (not that there's been any 
guarantee for patches
 > sent previous to that.)

Right, that's it for -rc1.

Unfortunately, this time around, there's been a number of 
issues:

1. OMAP stuff has not been merged again; there's just too 
much of it and
    not enough time to review it.

2. NetSilicon 93xx got dumped at the last minute due to 
merging errors
    which I didn't have time to resolve.

3. IOP changes got dumped because git refused to merge, 
spewing out an
    error I didn't understand.

4. Some patches accidentally got dropped during my 
manipulation of my
    git tree, and only realised _after_ the final pull 
request has been
    sent to Linus.

So, if your patch says it was applied, but doesn't appear 
once my tree
has been merged, take that as being _not_ applied, and 
resend at the
appropriate time.

It's been a nightmare this time around due to the number and 
size of
the changes, coupled with the inability to do regular merges 
with Linus
anymore, most notable the lack of pull half-way through this 
merge
window.


[3]
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008421.html
