From: Pavel Machek <pavel@ucw.cz>
Subject: 3.12-rc1: no longer compiles for Nokia n900 (omap based)
Date: Thu, 19 Sep 2013 11:30:02 +0200
Message-ID: <20130919093002.GA23806@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will.deacon@arm.com, catalin.marinas@arm.com
List-Id: linux-omap@vger.kernel.org

Hi!

I get:

  CC      arch/arm/kernel/machine_kexec.o
/tmp/ccCFXeXG.s: Assembler messages:
/tmp/ccCFXeXG.s:217: Error: garbage following instruction -- `dsb
nshst'
/tmp/ccCFXeXG.s:225: Error: garbage following instruction -- `dsb nsh'
make[1]: *** [arch/arm/kernel/suspend.o] Error 1
make[1]: *** Waiting for unfinished jobs....

pavel@amd:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Debian 4.3.5-4) 4.3.5

Minimum required gcc is 3.2, so I'm safe.

I suspect

commit 62cbbc42e0019aff6310259f275ae812463f8836
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu May 23 18:43:58 2013 +0100

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
