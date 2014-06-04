From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Multimonitor support on ARM
Date: Wed, 04 Jun 2014 12:57:33 +0100
Message-ID: <538F09AD.6030108@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:47965
	"EHLO know-smtprelay-omc-5.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbaFDMDS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 08:03:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I don't know if this is fixable or even considered for ARM.
I have a Lilliput 7" USB LCD that works fine on a Beaglebone White with 
the udlfb kernel module.

I started looking at the issue after a guy asked me if it also works on 
the ODROID.
For Software Defined Radio (SDR) which is of prime interest it would be 
nice to have a  portable/mobile SDR with a small keyboard/7" USB LCD or 
touchscreen, all as a compact unit.

Digging further. The Beaglebone does not have a GPU so that's probably 
why it works there and on x86_64 as it's dependent on x86.
The ODROID has a Mali400 GPU.

In /etc/modprobe.d/blacklist-framebuffer.conf
##blacklist udlfb
blacklist udl

The Lilliput came up on the ODROID with a green screen background but no 
display.

root@odroid:~# grep -i arbiter /var/log/Xorg.0.log.old
[   200.165] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card 
support

In kernels on x86_64 there is an option that is not available for ARM.
# CONFIG_VGA_ARB is not set

The files are present in the kernel but no config option, configuring it 
by hand and doing "make oldconfig" removes it as it depends on PCI and x86.
root@odroid:/b1/linux-3.8.13.23# ls drivers/gpu/vga
built-in.o  Kconfig  Makefile  modules.builtin  modules.order vgaarb.c  
vga_switcheroo.c

drivers/gpu/vga/Kconfig
===============
config VGA_ARB
         bool "VGA Arbitration" if EXPERT
         default y
         depends on (PCI && !S390)
         help
           Some "legacy" VGA devices implemented on PCI typically have 
the same
           hard-decoded addresses as they did on ISA. When multiple PCI 
devices
           are accessed at same time they need some kind of 
coordination. Please
           see Documentation/vgaarbiter.txt for more details. Select 
this to
           enable VGA arbiter.

config VGA_ARB_MAX_GPUS
         int "Maximum number of GPUs"
         default 16
         depends on VGA_ARB
         help
           Reserves space in the kernel to maintain resource locking for
           multiple GPUS.  The overhead for each GPU is very small.

config VGA_SWITCHEROO
         bool "Laptop Hybrid Graphics - GPU switching support"
         depends on X86
         depends on ACPI
         select VGA_ARB
         help
           Many laptops released in 2008/9/10 have two GPUs with a 
multiplexer
           to switch between them. This adds support for dynamic 
switching when
           X isn't running and delayed switching until the next logoff. 
This
           feature is called hybrid graphics, ATI PowerXpress, and Nvidia
           HybridPower.

Regards
Sid.

On 03/06/14 14:53, Michael Durkin wrote:
> and its working on the Odrod?
>
> On Tue, Jun 3, 2014 at 4:49 AM, Sid Boyce <boyce.sid@gmail.com> wrote:
>> A number of years actually.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

