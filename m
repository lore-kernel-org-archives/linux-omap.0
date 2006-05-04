From: Marc Singer <elf@buici.com>
Subject: Re: Problem using gdbserver on ARM target
Date: Thu, 4 May 2006 08:37:52 -0700
Message-ID: <20060504153751.GC4234@buici.com>
References: <OF2D51E9C2.3C3CCC6A-ON65257164.00424D70-65257164.00426D5F@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <OF2D51E9C2.3C3CCC6A-ON65257164.00424D70-65257164.00426D5F@flextronicssoftware.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm-toolchain@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, May 04, 2006 at 05:35:23PM +0530, Chetan Kapoor wrote:
> Hello
> 
> I am trying bring up gdbserver on my ARM target (OMAP P2 730).
> 
> I downloaded a prebuilt toolchain which contains gcc 3.3.2-glibc-2.3.2 + 
> binutils-head. We have used this to build   Kernel version 2.6.16-omap1 & 
> Busybox-1.0.0.
> 
> I have now compiled gdb 6.4 pack, and crosscompiled the gdb with 
> --target=arm-linux
> For gdbserver in the gbb/gdbserver directory I configured using 
> --host=arm-linux 
> 
> A make is successful but the dynamically linked ARM executable gives the 
> following error when I execute it on the target,
> 
> ~ # ./gdbserver
> -sh: ./gdbserver: No such file or directory

Try

  # ldd gdbserver

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
