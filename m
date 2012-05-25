From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: [PATCH 0/2] OMAPDSS: write-through caching support for omapfb
Date: Fri, 25 May 2012 12:00:25 +0300
Message-ID: <CACY+gR3-uBSH5cUuEc0R7XdjFB6kHmSdCXJnX5f0wnt+oM7XDA@mail.gmail.com>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
	<1337845417.2909.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64050 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2EYJA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 05:00:26 -0400
In-Reply-To: <1337845417.2909.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk

On Thu, May 24, 2012 at 10:43 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-05-22 at 22:54 +0300, Siarhei Siamashka wrote:
> I ran my own fb perf test on omap3 overo board ("perf" test in
> https://gitorious.org/linux-omap-dss2/omapfb-tests) :
>
> vram_cache=n:
>
> sequential_horiz_singlepixel_read: 25198080 pix, 4955475 us, 5084897 pix/s
> sequential_horiz_singlepixel_write: 434634240 pix, 4081146 us, 106498086 pix/s
> sequential_vert_singlepixel_read: 20106240 pix, 4970611 us, 4045023 pix/s
> sequential_vert_singlepixel_write: 98572800 pix, 4985748 us, 19770915 pix/s
> sequential_line_read: 40734720 pix, 4977906 us, 8183103 pix/s
> sequential_line_write: 1058580480 pix, 5024628 us, 210678378 pix/s
> nonsequential_singlepixel_write: 17625600 pix, 4992828 us, 3530183 pix/s
> nonsequential_singlepixel_read: 9661440 pix, 4952973 us, 1950634 pix/s
>
> vram_cache=y:
>
> sequential_horiz_singlepixel_read: 270389760 pix, 4994154 us, 54141253 pix/s
> sequential_horiz_singlepixel_write: 473149440 pix, 3932801 us, 120308512 pix/s
> sequential_vert_singlepixel_read: 18147840 pix, 4976226 us, 3646908 pix/s
> sequential_vert_singlepixel_write: 100661760 pix, 4993164 us, 20159914 pix/s
> sequential_line_read: 285143040 pix, 4917267 us, 57988114 pix/s
> sequential_line_write: 876710400 pix, 5012146 us, 174917171 pix/s
> nonsequential_singlepixel_write: 17625600 pix, 4977967 us, 3540722 pix/s
> nonsequential_singlepixel_read: 9661440 pix, 4944885 us, 1953825 pix/s
>
> These also show quite a bit of improvement in some read cases.
> Interestingly some of the write cases are also faster.
>
> Reading pixels vertically is slower with vram_cache. I guess this is
> because the cache causes some overhead, and we always miss the cache so
> the caching is just wasted time.

On a positive side, nobody is normally accessing memory in this way.
It is a well known performance anti-pattern.

> I would've also presumed the difference in sequential_line_write would
> be bigger. write-through is effectively no-cache for writes, right?

Write-through cache is still using write combining buffer for memory
writes. So I would actually expect the performance to be the same.

> If the user of the fb just writes to the fb and vram_cache=y, it means
> that the cache is filled with pixel data that is never used, thus
> lowering the performance of all other programs?

This is true only for write-allocate. We want the framebuffer to be
cacheable as write-through, allocate on read, no allocate on write.

Sure, when we are reading from the cached framebuffer, some useful
data may be evicted from cache. But if we are not caching the
framebuffer, any readers suffer from a huge performance penalty.
That's the reason why shadow framebuffer (a poor man's software
workaround) is implemented in Xorg server. And if we use a shadow
framebuffer (in normal write-back cached memory), we already have the
same or worse cache eviction problems when compared to the cached
framebuffer. I could not find any use case or benchmark where shadow
framebuffer would perform better than write-through cached framebuffer
on OMAP3 hardware.

Maybe a bit more details about the shadow framebuffer would be useful.
That's just one level above the framebuffer in the graphics stack for
linux desktop. And many of the performance issues happen exactly on
the boundary between different pieces of software when they are
developed independently. Knowing how the framebuffer is used in the
real world applications (and I assume X server is one of them) may
provide some insights about how to improve the framebuffer on the
kernel side.

Here the shadow framebuffer is initialized:
    http://cgit.freedesktop.org/xorg/xserver/tree/miext/shadow/shadow.c?id=xorg-server-1.12.1#n136
And it also enables damage extension to track all the drawing
operations performed with the shadow buffer in order to copy the
updated areas to the real framebuffer from time to time. The update
itself happens here:
    http://cgit.freedesktop.org/xorg/xserver/tree/miext/shadow/shpacked.c?id=xorg-server-1.12.1#n43
With the damage extension active, we go through damageCopyArea:
    http://cgit.freedesktop.org/xorg/xserver/tree/miext/damage/damage.c?id=xorg-server-1.12.1#n801
before reaching fbCopyArea:
    http://cgit.freedesktop.org/xorg/xserver/tree/fb/fbcopy.c?id=xorg-server-1.12.1#n265

While running x11perf test and doing copying/scrolling tests, the
function calls inside of X server look more or less like this:
    62. [00:29:27.779] fbCopyArea()
    63. [00:29:27.779] DamageReportDamage()
    64. [00:29:27.783] fbCopyArea()
    65. [00:29:27.783] DamageReportDamage()
    66. [00:29:27.787] fbCopyArea()
    67. [00:29:27.792] shadowUpdatePacked()
    68. [00:29:27.792] DamageReportDamage()
    69. [00:29:27.795] fbCopyArea()
    70. [00:29:27.795] DamageReportDamage()
    71. [00:29:27.799] fbCopyArea()
    72. [00:29:27.800] DamageReportDamage()
    73. [00:29:27.803] fbCopyArea()
    74. [00:29:27.803] DamageReportDamage()
    75. [00:29:27.807] fbCopyArea()
    76. [00:29:27.807] DamageReportDamage()
    77. [00:29:27.811] fbCopyArea()
    78. [00:29:27.811] DamageReportDamage()
    79. [00:29:27.815] fbCopyArea()
    80. [00:29:27.820] shadowUpdatePacked()

As can be seen in the log above, shadowUpdatePacked() is used much
less frequently than fbCopyArea(). Which means that shadow framebuffer
is cheating a bit by accumulating damage and updating the real
framebuffer much less frequently.

The write-through cached framebuffer beats the shadow framebuffer in every way:
- It needs less RAM
- No need for damage tracking overhead (important for small drawing operations)
- No screen updates are skipped, which means smoother animation

> I have to say I don't know much of the cpu caches, but the read speed
> improvements are very big, so I think this is definitely interesting
> patch.

Yes, it is definitely providing a significant performance improvement
for software rendering in Xorg server. But there is unfortunately no
free lunch. Using write-through cache means that if anything other
than CPU is writing to the framebuffer, then it must invalidate CPU
cache for this area. And this means that it makes sense to review how
the SGX integration is done and fix it if needed. I tried some tests
with X11WSEGL (a binary blob provided in GFX SDK for X11 integration)
and it did not seem to exhibit any obvious screen corruption issues,
but without having the sources it's hard to say for sure. I would
assume that the ideal setup for OMAP3 would be to use GFX plane
exclusively by the CPU for 2D graphics, and render SGX 3D graphics to
one of the VID planes. In this case DISPC can do the compositing and
CPU cache invalidate operations become unnecessary.

There is also DSP, ISP and maybe some other hardware blocks, but these
can be handled on case by case basis. My primary interest is a little
personal hobby project to get linux desktop running with acceptable
performance.

> So if you get the first patch accepted I see no problem with
> adding this to omapfb as an optional feature.

Yes, a review from ARM memory management subsystem experts is definitely needed.

> However, "vram_cache" is not a very good name for the option.
> "vram_writethrough", or something?

Still having "cache" in the name would be useful. Just in order to
imply that there might be coherency issues to consider. By the way,
vesafb actually uses some numeric codes for different types of caching
in mtrr:n option:
    https://github.com/torvalds/linux/blob/v3.4/Documentation/fb/vesafb.txt#L147

Write-through caching is bad on Cortex-A9 as promised in TRM and as
confirmed by tests. Still for Cortex-A9 it *might* be interesting to
experiment with enabling write-back cache for the framebuffer, but
instead of using shadow framebuffer just do CPU cache flushes based on
all the same damage tracking borrowed from shadow framebuffer code.
This even might be somehow related to the "manual" update mode :)
Except that we can't change framebuffer caching attributes at runtime.

> Did you test this with VRFB (omap3) or TILER (omap4)? I wonder how those
> are affected.

That's a good point. I tried VRFB on OMAP3 1GHz and got the following
results with x11perf (shadow framebuffer disabled in
xf86-video-fbdev):

------------------ rotate 90, write-through cached
  3500 trep @   8.0242 msec ( 125.0/sec): Scroll 500x500 pixels
  4000 trep @   8.7027 msec ( 115.0/sec): Copy 500x500 from window to window
  6000 trep @   5.4885 msec ( 182.0/sec): Copy 500x500 from pixmap to window
  6000 trep @   4.9806 msec ( 201.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4231 msec ( 292.0/sec): Copy 500x500 from pixmap to pixmap

------------------ rotate 90,  non-cached writecombining
  3000 trep @   8.9732 msec ( 111.0/sec): Scroll 500x500 pixels
  1000 trep @  26.3218 msec (  38.0/sec): Copy 500x500 from window to window
  6000 trep @   5.5002 msec ( 182.0/sec): Copy 500x500 from pixmap to window
  6000 trep @   6.2368 msec ( 160.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4219 msec ( 292.0/sec): Copy 500x500 from pixmap to pixmap

------------------ rotate 180, write-through cached
 10000 trep @   3.5219 msec ( 284.0/sec): Scroll 500x500 pixels
  6000 trep @   4.8829 msec ( 205.0/sec): Copy 500x500 from window to window
  8000 trep @   3.4772 msec ( 288.0/sec): Copy 500x500 from pixmap to window
  8000 trep @   3.2554 msec ( 307.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4196 msec ( 292.0/sec): Copy 500x500 from pixmap to pixmap

------------------ rotate 180, non-cached writecombining
 10000 trep @   4.5777 msec ( 218.0/sec): Scroll 500x500 pixels
  1000 trep @  24.9100 msec (  40.1/sec): Copy 500x500 from window to window
  8000 trep @   3.4763 msec ( 288.0/sec): Copy 500x500 from pixmap to window
  6000 trep @   4.8676 msec ( 205.0/sec): Copy 500x500 from window to pixmap
  8000 trep @   3.4205 msec ( 292.0/sec): Copy 500x500 from pixmap to pixmap

The 90 degrees rotation significantly reduces performance. Shadow
framebuffer is "faster", because it is skipping some work. But
write-through caching is at least not worse than the default
writecombine.

Regarding OMAP4. I only have an old pre-production Pandaboard EA1,
which only runs memory at half speed. It is useless for any
benchmarks.

-- 
Best regards,
Siarhei Siamashka
