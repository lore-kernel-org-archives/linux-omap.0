From: Philip Balister <philip@balister.org>
Subject: /proc/pic/smaps output
Date: Sun, 25 Mar 2007 14:21:26 -0400
Message-ID: <4606BDA6.70907@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I am using pmap to try and estimate process memory usage on the OSK 
(with the 2.6.20 omap kernel). Here is a short section of output:

40024000   1340K  r-x--  /usr/lib/libomniORB4.so.0.7
40173000     32K  -----  /usr/lib/libomniORB4.so.0.7
4017b000     44K  rw---  /usr/lib/libomniORB4.so.0.7

I am not sure how to interpret the section marked -----. If I look 
directly at the output of /proc/<pid>/smaps, the ----- corresponds to 
---p . If I look on my x86 machine, this section appears be r-xp.

Does anyone have any insight into this? I do not understand why a 
library would be maped as unreadble, unwritable, and not executable.

Thanks,

Philip
