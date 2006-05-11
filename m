From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: OSK5912 copy flash to mem broken?
Date: Thu, 11 May 2006 15:52:33 +0900 (JST)
Message-ID: <20060511.155233.74750204.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

I'm facing a problem, on OSK5912 board, boot loader that is 
copied from 0x00000000 to 0x11080000 at powerup is not exactly copied.

This can be checked as below:
(after OSK5912 is powered up and uboot prompt is shown)
OMAP5912 OSK # cmp.b 0x00000000 0x11080000 0x15dd4

and I got:

byte at 0x000150a2 (0xff) != byte at 0x110950a2 (0x0f)


Memory itself is not broken, since I get:

OMAP5912 OSK # tftp 10000000 uboot.bin
TFTP from server 192.168.0.1; our IP address is 192.168.0.43
Filename 'uboot.bin'.
Load address: 0x10000000
Loading: ##################
done
Bytes transferred = 89556 (15dd4 hex)
OMAP5912 OSK # cp.b 10000000 11080000 0x15dd4
OMAP5912 OSK # cmp.b 0x10000000 0x11080000 0x15dd4
Total of 89556 bytes were the same


I'm using the updated uboot.bin from
http://omap.spectrumdigital.com/osk5912/osk5912_faq.html

Anyone have the same problem?
I tested with OSK5912 Revision C and D, and its the same...


(Hiroki Kaminaga)
t
--
