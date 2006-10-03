From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent git kernels and OSK
Date: Tue, 03 Oct 2006 15:55:17 +0200
Message-ID: <45226BC5.9050201@gmail.com>
References: <4521941B.2020102@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4521941B.2020102@balister.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Philip Balister <philip@balister.org>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Philip Balister wrote:
> I just built a kernel from today's git repo and tried booting it on my 
> OSK. The boot hung after uncompressing the kernel at the "Starting 
> kernel ..." message.
> 
> Has anyone successfully booted a recent git kernel on the OSK?

Just checked it. Seems that recent git on OSK is really 
broken. Enabling lowlevel debug last thing I get is kernel 
command line output [3]. On my last working kernel next 
output would be clock stuff [2]

My last update some days ago including "Menelaus: Fix 
voltage values for VMEM" [1] was okay. So anything between 
this patch and now is the bad one.

Any ideas?

Cheers

Dirk

[1] 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=8f321b52ea97a59e8471904b2e2c32438618c6be

[2]
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2813 ARM_CKCTL: 0x150f
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
...

[3] Recent git with lowlevel debug enabled on OSK:

5>Linux version 2.6.18-omap1 (dirk@asterix) (gcc version 
4.1.0) #2 PREEMPT Tue Oct 3 15:40:42 CEST 2006
CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 8192
<7>  DMA zone: 8192 pages, LIFO batch:1
OMAP1611b revision 2 handled as 16xx id: 68058c80eb071005
<6>SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 
128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 
64 sets
Built 1 zonelists.  Total pages: 8192
<5>Kernel command line: mem=32M console=tty0 
console=ttyS0,115200 initrd=0x10400000,8M root=/dev/ram0 rw
