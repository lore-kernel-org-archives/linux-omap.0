From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: H4 with 2.6.9 from TI dev site not booting
Date: Fri, 29 Sep 2006 13:52:04 +0100
Message-ID: <009f01c6e3c6$10a275b0$642aa8c0@Buffy>
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

 

I wonder if anyone has any experience with LINUX 2.6.9 built with gcc 3.4.1
for ARM running on TI OMAP2420 H4 board.

 

I download the kernel via JTAG to 0x80000000 and start it running. It runs
for 35 instructions and then ends up in a tight loop at 0x80008118 which
contains a nop followed by a branch to 0x80008118.

 

Can someone point me in the right direction please?

 

TIA,

 

Richard.
