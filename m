From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: [PATCH 0/2] OMAPDSS: write-through caching support for omapfb
Date: Tue, 22 May 2012 23:25:26 +0300
Message-ID: <CACY+gR15Q+wEVnkWqWmTy4+R72zP91t-KCHvZS-vAO1Ls0Ef-A@mail.gmail.com>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39697 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524Ab2EVUZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 16:25:27 -0400
In-Reply-To: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, Siarhei Siamashka <siarhei.siamashka@gmail.com>

On Tue, May 22, 2012 at 10:54 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> And at least for ARM11 and Cortex-A8 processors, the performance of
> write-through cache is really good. Cortex-A9 is another story, becau=
se
> all pages marked as Write-Through are supposedly treated as Non-Cache=
able:
> =C2=A0 =C2=A0http://infocenter.arm.com/help/topic/com.arm.doc.ddi0388=
h/CBBFDIJD.html
> So OMAP4 is out of luck.

I don't have Pandaboard ES, but still tried to experiment changing the
following line in the kernel sources to benchmark different types of
caching for the framebuffer on Origen board (Exynos 4210):
    https://github.com/torvalds/linux/blob/v3.4/drivers/media/video/vid=
eobuf2-memops.c#L158

It was not a totally clean experiment, because 500x500 16bpp pixel
buffer is much smaller than 1MiB L2 cache and the performance numbers
may be a bit odd. Also I have not checked whether the same buffer may
be mapped with different cacheability attributes anywhere else (which
would be bad). But still it was interesting to see whether
write-through cache is of any use and whether it could serve as a
replacement for shadowfb.

Origen board, Exynos 4210, Cortex-A9 1.2GHz, 1920x1080 screen
resolution, 16bpp desktop color depth (I did not find any obvious way
how to change it to 32bpp yet):

$ x11perf -scroll500 -copywinwin500 -copypixpix500 \
          -copypixwin500 -copywinpix500

-- pgprot_noncached + shadowfb
 100000 trep @  0.2708 msec ( 3690.0/sec): Scroll 500x500 pixels
  40000 trep @  0.7307 msec ( 1370.0/sec): Copy 500x500 from window to =
window
  60000 trep @  0.5471 msec ( 1830.0/sec): Copy 500x500 from pixmap to =
window
  60000 trep @  0.5822 msec ( 1720.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6584 msec ( 1520.0/sec): Copy 500x500 from pixmap to =
pixmap

-- pgprot_writecombine + shadowfb
 100000 trep @  0.2612 msec ( 3830.0/sec): Scroll 500x500 pixels
  40000 trep @  0.7058 msec ( 1420.0/sec): Copy 500x500 from window to =
window
  60000 trep @  0.5262 msec ( 1900.0/sec): Copy 500x500 from pixmap to =
window
  60000 trep @  0.5797 msec ( 1730.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6554 msec ( 1530.0/sec): Copy 500x500 from pixmap to =
pixmap

-- pgprot_writethrough + shadowfb
 100000 trep @  0.2609 msec ( 3830.0/sec): Scroll 500x500 pixels
  40000 trep @  0.7018 msec ( 1420.0/sec): Copy 500x500 from window to =
window
  60000 trep @  0.5260 msec ( 1900.0/sec): Copy 500x500 from pixmap to =
window
  60000 trep @  0.5758 msec ( 1740.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6569 msec ( 1520.0/sec): Copy 500x500 from pixmap to =
pixmap

-- pgprot_noncached
   3500 trep @  7.5972 msec (  132.0/sec): Scroll 500x500 pixels
   1800 trep @ 14.7146 msec (   68.0/sec): Copy 500x500 from window to =
window
   6000 trep @  4.6501 msec (  215.0/sec): Copy 500x500 from pixmap to =
window
   8000 trep @  3.3500 msec (  299.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6546 msec ( 1530.0/sec): Copy 500x500 from pixmap to =
pixmap

-- pgprot_writecombine
  10000 trep @  2.9439 msec (  340.0/sec): Scroll 500x500 pixels
   6000 trep @  5.7246 msec (  175.0/sec): Copy 500x500 from window to =
window
  60000 trep @  0.4213 msec ( 2370.0/sec): Copy 500x500 from pixmap to =
window
  12000 trep @  2.2423 msec (  446.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6648 msec ( 1500.0/sec): Copy 500x500 from pixmap to =
pixmap

-- pgprot_writethrough
  40000 trep @  0.7103 msec ( 1410.0/sec): Scroll 500x500 pixels
  20000 trep @  1.3024 msec (  768.0/sec): Copy 500x500 from window to =
window
  80000 trep @  0.3933 msec ( 2540.0/sec): Copy 500x500 from pixmap to =
window
  18000 trep @  1.3967 msec (  716.0/sec): Copy 500x500 from window to =
pixmap
  40000 trep @  0.6548 msec ( 1530.0/sec): Copy 500x500 from pixmap to =
pixmap

Without shadowfb, the performance of "writecombine" looks to be better
than "noncached". And "writethrough" is clearly the fastest. Still
even "writethrough" is no match for shadowfb on Cortex-A9 (unlike
ARM11 and Cortex-A8).

So is Cortex-A9 a lost cause? Maybe experimenting with page table
entries and tweaking inner/outer cacheability attributes could provide
something? From the first glance, it looks like read performance for
write-through cached memory is rather bad on Cortex-A9. But still
there is some speedup, so it does not seem to be treated as totally
non-cached. And at least PL310 L2 cache controller has some support
for "Cacheable write-through, allocate on read":
    http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246f/ch02s03s0=
1.html

--=20
Best regards,
Siarhei Siamashka
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
