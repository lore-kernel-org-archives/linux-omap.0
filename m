From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Fw: init (busybox) problem on OSK5912
Date: Thu, 4 May 2006 12:49:50 +0530
Message-ID: <OFD42F04BA.70938876-ON65257164.00280E9D-65257164.0028488C@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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
To: Eduardo Gallofin <egallofin@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ed

Could you tell me where is the option of compiling busybox with or without 
shared libs. I have Busybox 1.0.0 running on OMAP 730 P2, it was fine till 
we used the included apps (ls, pwd etc), but we then tried running 
gdbserver on the target, which gives a segmentation fault while running, 
seems as if my problem is also related to shared libs. Also, I had to 
manually copy libc-2.3.2.so & libthread_db-1.0.so to make gdbserver start 
on the target, before which we were not even able to launch gdbserver on 
the target.

If I complie Busybox with shared libs, will I see a 'lib' folder at path 
/lib or /usr/local/lib on the target's rootfs?

Your reply will be of great help.

Cheers!!

Chetan
 



Eduardo Gallofin <egallofin@yahoo.com> 
Sent by: linux-omap-open-source-bounces@linux.omap.com
05/04/2006 12:17 PM


To
linux-omap-open-source@linux.omap.com
cc

Subject
init (busybox) problem on OSK5912






I'm replying to my own query to give update ....

I managed to have init working by using an older
version of busybox (1.00-pre8), however another
problem happens with /bin/sh (ash) crashing and
restarting over and over.

The problem seems to happen only when busybox is
compiled with shared libraries. other busybox applets
(like ls -l) also terminate with segmentation fault.
strace shows that they seg fault when connecting or
binding to a socket.

any thoughts why these only happen with shared
libraries?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source



***********************  FSS-Unclassified   ***********************

***********************  FSS-Unclassified   ***********************
