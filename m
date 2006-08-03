From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: NPTL on OMAP 5912
Date: Thu, 3 Aug 2006 10:40:45 +0100
Message-ID: <006c01c6b6e0$e5018750$642aa8c0@Buffy>
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

Hi,

 

I have a 2.6.15 kernel running on my 5912OSK board. Has anybody got the NPTL
stuff working on here? Can someone point me at a getting started guide?

I tried to figure out which version of threads my target supports:

            Getconf GNU_LIBPTHREAD_VERSION

 But the command returned an empty string :-(

I built my target with GCC 3.4.1 which I built using crosstool.

 

Thanks,

 

Richard.
