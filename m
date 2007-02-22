From: Zgembo Adislic <adislic_zgembo@yahoo.com>
Subject: Kernel compilation problem
Date: Thu, 22 Feb 2007 05:01:33 -0800 (PST)
Message-ID: <63576.32055.qm@web30611.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hello,
 
 I using linux kernel 2.6.8.1 for my embedded ARM target and I am able to compile it without any problems using gcc-3.4-0 cross-compiler. For some reason I had to modify one of my device drivers to work with files and I had to include "stdio.h" library for that reason. But now when I execute make command I got an error that says that
 
 "stdio.h: No such file or directory"
And all functions that I used form that library are not recognized. 
 
 I really see no reason why this should not work?! All suggestions are welcome.
 
---------------------------------
8:00? 8:25? 8:40?  Find a flick in no time
 with theYahoo! Search movie showtime shortcut.
