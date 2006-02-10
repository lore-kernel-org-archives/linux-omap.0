From: X-Stranger <x@linux.by>
Subject: PalmTE kernel and linux
Date: Fri, 10 Feb 2006 23:54:04 +0200
Message-ID: <43ED0B7C.1030200@linux.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
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
To: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello!

I'm owner of Palm Tungsten E and very interested with porting Linux on 
it. Nowadays we have working kernel with touchscreen and SD support 
(thanks to Andrzej Zaborowski) which can be started using Garux (thanks 
to Romain Goyet). All this good, but we have very strange problem that
can't be resolved without help from you.

After kernel starts init process the system hangs. If I replace init by
script which starts shell (sh from Busybox), it seems to be all right, 
but when I start any other program from shell, ls for example, it also
hangs. As told Andrzej,

"I did all kinds of memory tests and checked that there is no memory 
corruption. I also disabled all possible device drivers
(running almost the original OMAP kernel without any patches) and
probed all versions since 2.6.13-rc1 to 2.6.16-rc1, and the same
behaviour was present."

Then, I've debug Busybox init process and found where it hangs (for me): 
when it tries to reset signal handlers running actions from inittab. 
Call to function

signal(SIGUSR1, SIG_DFL);

hangs init process. Probably something is incorrect in kernel pathes for 
PalmTE... Can somebody help with understanding what is incorrect?


Kind regards to all OMAP fans, Dzmitry

http://epam.com
http://linux.by
