From: Oleg Kechin <okechin@gmail.com>
Subject: Standby/resume omap 5910 board
Date: Thu, 07 Jun 2007 16:31:57 +0300
Message-ID: <466808CD.1060908@gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi
I run 2.6.20-rt8 kernel on board like innovator1510 (OMAP5910 cpu)
Board enter Deep Sleep mode cleanly, and it is OK, but in resume has a 
problem.
(I use echo -n standby > /sys/power/state command)
When it wakes up,  some times I get string:

omapflash.0: Waiting for chip to be ready timed out. Status 3068
Write of 68 bytes at 0x00945628 failed. returned -5, retlen 0
Not marking the space at 0x00945628 as dirty because the flash driver 
returned retlen zero

Searching in mtd subdir  show, that mtd driver has functions suspend and 
resume (cfi_intelext_suspend() & cfi_intelext_resume()),
but both of this functions are not calling in suspend/resume process.
Searching through  configs files in omap1 directory does not any shine 
any lite on this problem.

May be it is pm mail list question, or mtd mail list, but many 
omap-based device suspend/resume cleanly without such problem, I think.
Can anyone help me?

Oleg Kechin
