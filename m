From: Martin Margraf <m_margraf@web.de>
Subject: Kernel 2.6.16 hangs after start booting with U-Boot 1.1.2
Date: Wed, 24 May 2006 15:03:33 +0200
Message-ID: <922740597@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
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

hi,

my problem is that after updating u-boot from 1.1.1 to 1.1.2 and after patching /arch/arm/boot/compressed/makefilfe and head-omap.S
the kernel is hanging up at start. i use the latest kernel (2.6.16.18) and patched it with the 2.6.16-omap1 patch.

the second problem is in hyperterminal or minicom. 
i try to setenv bootargs... but at the end of line there is no jump to the next line (if i press enter then there is a new line) so 
i cant set all bootargs in one row.
does anybody else has this problem?

im going insane :)

regards

martin 
______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193
