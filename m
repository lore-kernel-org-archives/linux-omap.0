From: lizette sanglay <moonpools2003@yahoo.com>
Subject: problem (segmentaion fault) with CSL API for emiff
Date: Mon, 3 Jul 2006 08:13:40 +0100 (BST)
Message-ID: <20060703071340.9478.qmail@web60419.mail.yahoo.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
   I tried running the sample emiff program (Emiff_example.c -->sample program on CSL APIs for EMIFF) which writes and reads from sdram on OMAP (without using CCS). I compiled the program using arm gcc but when i executed the program, segmentation fault occurs after reading the emiff register during hardware setup.
  Does it have something to do with memory mapping? because i did not use the OMAP5912_arm9.cmd which came with the sample program.

 Send instant messages to your online friends http://uk.messenger.yahoo.com 
