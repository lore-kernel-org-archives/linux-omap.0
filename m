From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: MTD : cannot reserve enough PEBs for bad PEB handling
Date: Mon, 22 Apr 2013 10:41:30 +0100
Message-ID: <517505CA.2050509@newflow.co.uk>
References: <51750526.70508@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51750526.70508@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: dedekind1@gmail.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 22/04/13 10:38, Mark Jackson wrote:
> I'm trying to work out how to generate a "valid" UBI image, but I keep
> getting a "cannot get enough PEBs" warning.

<snip>

> ...
> [    0.792456] UBI: attaching mtd7 to ubi0
> [    1.540858] UBI: scanning is finished
> [    1.557578] UBI warning: print_rsvd_warning: cannot reserve enough
> PEBs for bad PEB handling, reserved 4, need 40
> [    1.561346] UBI: attached mtd7 (name "rootfs", size 64 MiB) to ubi0
> [    1.561404] UBI: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
> [    1.561434] UBI: min./max. I/O unit sizes: 2048/2048, sub-page size 512
> [    1.561464] UBI: VID header offset: 2048 (aligned 2048), data offset:
> 4096
> [    1.561493] UBI: good PEBs: 512, bad PEBs: 0, corrupted PEBs: 0
> [    1.561520] UBI: user volume: 1, internal volumes: 1, max. volumes
> count: 128
> [    1.561554] UBI: max/mean erase counter: 2/1, WL threshold: 4096,
> image sequence number: 1434266085
> [    1.561591] UBI: available PEBs: 0, total reserved PEBs: 512, PEBs
> reserved for bad PEB handling: 4
> [    1.562374] UBI: background thread "ubi_bgt0d" started, PID 598
> ...

And some additional UBI messages I failed to copy in:-

...
[    1.728485] UBIFS: recovery needed
[    1.824972] UBIFS: recovery deferred
[    1.825553] UBIFS: mounted UBI device 0, volume 0, name "rootfs", R/O
mode
[    1.825595] UBIFS: LEB size: 126976 bytes (124 KiB), min./max. I/O
unit sizes: 2048 bytes/2048 bytes
[    1.825638] UBIFS: FS size: 60059648 bytes (57 MiB, 473 LEBs),
journal size 7999488 bytes (7 MiB, 63 LEBs)
[    1.825677] UBIFS: reserved for root: 0 bytes (0 KiB)
[    1.825711] UBIFS: media format: w4/r0 (latest is w4/r0), UUID
93286679-C044-4BC4-8FCB-6E5055E65825, small LPT model
[    2.088284] UBIFS: completing deferred recovery
[    2.204405] UBIFS: background thread "ubifs_bgt0_0" started, PID 613
[    2.206118] UBIFS: deferred recovery completed

Cheers
Mark J.
