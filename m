From: Tony Lindgren <tony@atomide.com>
Subject: Kexec regression in next-20160906
Date: Tue, 6 Sep 2016 15:09:37 -0700
Message-ID: <20160906220936.4txqzodkgknhjiyh@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 5c01cdd2d4bc ("kexec_file: allow skipping checksum
calculation for some segments") makes next-20160916 stop working for
me at least on ARM.

I now get "kexec_load failed: Invalid argument error" on loading the
new kernel to memory with kexec -l.

Reverting the following two commits makes things work for me again:

d2bf993afdf1 ("kexec_file: add mechanism to update kexec segments")
5c01cdd2d4bc ("kexec_file: allow skipping checksum calculation for
some segments")

Regards,

Tony

8< -------
kernel: 0xb6b77008 kernel_size: 0x3aa538
MEMORY RANGES
0000000080000000-00000000ffcfffff (0)
00000000fff00000-00000000ffffefff (0)
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb6b77008
segment[0].bufsz = 0x3aa538
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3ab000
segment[1].buf   = 0xadf80
segment[1].bufsz = 0x16080
segment[1].mem   = 0x81709000
segment[1].memsz = 0x17000
kexec_load failed: Invalid argument
entry       = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb6b77008
segment[0].bufsz = 0x3aa538
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3ab000
segment[1].buf   = 0xadf80
segment[1].bufsz = 0x16080
segment[1].mem   = 0x81709000
segment[1].memsz = 0x17000
Nothing has been loaded!
