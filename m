From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Fri, 1 Jun 2018 08:35:12 -0700
Message-ID: <20180601153512.GV5705@atomide.com>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@armlinux.org.uk> [180601 11:02]:
> Executing loops such as:
> 
> 	while (1)
> 		cpu_relax();
> 
> with interrupts disabled results in a livelock of the entire system,
> as other CPUs are prevented making progress.  This is most noticable
> as a failure of crashdump kexec, which stops just after issuing:
> 
> 	Loading crashdump kernel...
> 
> to the system console.  Two other locations of these loops within the
> ARM code have been identified and fixed up.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Works for me thanks:

Tested-by: Tony Lindgren <tony@atomide.com>

BTW, do LZMA crashkernels boot for you with crashdump?

For me LZMA crashkernels fail to boot while GZIP crashkernels
boots. Some more info below for failing and working output.

Regards,

Tony

8< ----------------------
CONFIG_KERNEL_LZMA fails:

Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/zImage of 65536 bytes failed
kernel: 0xb6abb010 kernel_size: 0x43d0f0
MEMORY RANGES
0000000080000000-00000000bfdfffff (0)
zImage header: 0x016f2818 0x00000000 0x0043d0f0
zImage size 0x43d0f0, file size 0x43d0f0
Reserved memory ranges
00000000a8000000-00000000abffffff (0)
Coredump memory ranges
0000000080000000-00000000a7ffffff (0)
00000000ac000000-00000000bfdfffff (0)
kernel symbol _stext vaddr =         c0100000
phys offset = 0x80000000, page offset = c0000000
Using 32-bit ELF core format
get_crash_notes_per_cpu: crash_notes addr = be001200, size = 180
Elf header: p_type = 4, p_offset = 0xbe001200 p_paddr = 0xbe001200 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
get_crash_notes_per_cpu: crash_notes addr = be002200, size = 180
Elf header: p_type = 4, p_offset = 0xbe002200 p_paddr = 0xbe002200 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
vmcoreinfo header: p_type = 4, p_offset = 0xaeae2000 p_paddr = 0xaeae2000 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0xc0000000 p_filesz = 0x28000000 p_memsz = 0x2800
0000
Elf header: p_type = 1, p_offset = 0xac000000 p_paddr = 0xac000000 p_vaddr = 0xec000000 p_filesz = 0x13e00000 p_memsz = 0x13e0
0000
elfcorehdr: 0xabf00000
crashkernel: [0xa8000000 - 0xabffffff] (64M)
memory range: [0x80000000 - 0xa7ffffff] (640M)
memory range: [0xac000000 - 0xbfdfffff] (318M)
kernel command line: "console=ttyS2,115200n8 root=/dev/nfs ip=dhcp debug earlyprintk earlycon crashkernel=64M elfcorehdr=0xabf
00000 mem=64512K"
kexec_load: entry = 0xa8008000 flags = 0x280001
nr_segments = 3
segment[0].buf   = 0xb6abb010
segment[0].bufsz = 0x43d0f0
segment[0].mem   = 0xa8008000
segment[0].memsz = 0x43e000
segment[1].buf   = 0x53dc80
segment[1].bufsz = 0x128da
segment[1].mem   = 0xa953b000
segment[1].memsz = 0x13000
segment[2].buf   = 0xb6fe8150
segment[2].bufsz = 0x400
segment[2].mem   = 0xabf00000
segment[2].memsz = 0x1000


CONFIG_KERNEL_GZIP Works:

Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/zImage of 65536 bytes failed
kernel: 0xb693f010 kernel_size: 0x5c74a8
MEMORY RANGES
0000000080000000-00000000bfdfffff (0)
zImage header: 0x016f2818 0x00000000 0x005c74a8
zImage size 0x5c74a8, file size 0x5c74a8
Reserved memory ranges
00000000a8000000-00000000abffffff (0)
Coredump memory ranges
0000000080000000-00000000a7ffffff (0)
00000000ac000000-00000000bfdfffff (0)
kernel symbol _stext vaddr =         c0100000
phys offset = 0x80000000, page offset = c0000000
Using 32-bit ELF core format
get_crash_notes_per_cpu: crash_notes addr = be001200, size = 180
Elf header: p_type = 4, p_offset = 0xbe001200 p_paddr = 0xbe001200 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
get_crash_notes_per_cpu: crash_notes addr = be002200, size = 180
Elf header: p_type = 4, p_offset = 0xbe002200 p_paddr = 0xbe002200 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
vmcoreinfo header: p_type = 4, p_offset = 0xaeae2000 p_paddr = 0xaeae2000 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0xc0000000 p_filesz = 0x28000000 p_memsz = 0x28000000
Elf header: p_type = 1, p_offset = 0xac000000 p_paddr = 0xac000000 p_vaddr = 0xec000000 p_filesz = 0x13e00000 p_memsz = 0x13e00000
elfcorehdr: 0xabf00000
crashkernel: [0xa8000000 - 0xabffffff] (64M)
memory range: [0x80000000 - 0xa7ffffff] (640M)
memory range: [0xac000000 - 0xbfdfffff] (318M)
kernel command line: "console=ttyS2,115200n8 root=/dev/nfs ip=dhcp debug earlyprintk earlycon crashkernel=64M elfcorehdr=0xabf00000 mem=64512K"
kexec_load: entry = 0xa8008000 flags = 0x280001
nr_segments = 3
segment[0].buf   = 0xb693f010
segment[0].bufsz = 0x5c74a8
segment[0].mem   = 0xa8008000
segment[0].memsz = 0x5c8000
segment[1].buf   = 0x476c80
segment[1].bufsz = 0x128da
segment[1].mem   = 0xa9cee000
segment[1].memsz = 0x13000
segment[2].buf   = 0xb6ff6150
segment[2].bufsz = 0x400
segment[2].mem   = 0xabf00000
segment[2].memsz = 0x1000
