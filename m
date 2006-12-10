From: "Chaitali Sengupta" <chaitali@snrlabs.com>
Subject: need help with rootfs load/init
Date: Sun, 10 Dec 2006 00:38:12 -0600
Message-ID: <000e01c71c25$c43761c0$b768a8c0@d2nrw2b1>
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

Hi all,
 
I am trying to build my own rootfs (running on an OMAP1710) using open
source resources.
 
When I try to boot up the board - after the kernel boots up and the
filesystem gets mounted, I see the following error:
 
init: error while loading shared libraries: libc.so.6: cannot open
shared object
 file: No such file or directory
Kernel panic: Attempted to kill init!
 
Can anybody help me with any insights into what may be wrong? The rootfs
that I am trying to load does have a symbolic link called /lib/libc.so.6
pointing to /lib/libc-2.3.2.so.
 
Thanks!
Chaitali.  
