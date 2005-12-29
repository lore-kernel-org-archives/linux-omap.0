From: "M Letti" <m.letti@gmx.net>
Subject: where to find cross-compiled versions of gdbserver?
Date: Thu, 29 Dec 2005 21:00:38 +0100
Message-ID: <200512292001.jBTK1FeQ010806@sabine.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Sirs,

 

I use the precompiled toolchain (version 3.3.2) on my OSK5912, which is
available from http://linux.omap.com/pub/toolchain/ .

So far so good, I can use the arm-linux-gcc command to compile my own
programs for my target.

 

But now that I want to debug these apps remotely, I'm looking for the
cross-compiled versions of gdb and gdbserver (that is, arm-linux-gdb and
arm-linux-gdbserver.and wonder, if they shouldn't be included in the
toolchain I downloaded already? I just can't find them.(they are not in the
3.3.2/bin directory where for example the arm-linux-gcc resides)

 

Could anyone please point me out where they normally would be located, or if
I have to cross-compile them on my own (in fact, I have already tried this
step, but got mass of errors when executing "make").

 

 

By the way, I would like to ask you if you by chance can recommend any
graphical development and debugging tools for my target (besides DDD & co)?
Are there for example any special Eclipse plugins I could use, or should I
use normal Eclipse environment and just set the remote debugging
configuration appropriately to develop for my target?

 

 

Thank you very much in advance,

 

Michael
