From: kabbin <kabbin26@yahoo.com.tw>
Subject: Building kenel error
Date: Tue, 15 Aug 2006 17:47:38 +0800 (CST)
Message-ID: <20060815094738.61617.qmail@web17801.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear all:
  When I build kernel 2.6.10 which downloaded from
http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap2430=
.tgz

I got :=20
In file included from include/asm/page.h:27,
                 from include/asm/cpu-single.h:33,
                 from include/asm/proc-fns.h:154,
                 from include/asm/system.h:94,
                 from include/asm/bitops.h:22,
                 from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from
arch/arm/kernel/asm-offsets.c:13:
include/asm/glue.h:111:2: error: #error Unknown data
abort handler type
In file included from include/asm/cpu-single.h:33,
                 from include/asm/proc-fns.h:154,
                 from include/asm/system.h:94,
                 from include/asm/bitops.h:22,
                 from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from
arch/arm/kernel/asm-offsets.c:13:
include/asm/page.h:92:2: error: #error Unknown user
operations model

Is there some problems on my toolchain ?
Or maybe I use the  wrong config setting ?=20
Thanks. Best Regards.

yanming.

___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
