From: jiangqingdong@konka.com
Subject: help for omap730 hardware nand controller
Date: Thu, 12 Apr 2007 09:31:37 +0800
Message-ID: <OFBDB00854.8DF6B4E1-ON482572BA.00299319-482572BB.0006D8CA@konka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,
        I want to port omap1710 hardware nand controller driver omap-hw.c 
from omap 2.6 git tree to my own omap730 board. but I stalled at reading 
the flash ID.

 
 
omap-hw-nand: OMAP NAND Controller rev. 0.0

....
No NAND device found!!!
func = nand_scan   LINE = 2460
185   ret=0
185   ret=0


nand_scan failed in read the flash ID, the right value should be 0xa1 but 
returned 0x00. I wrote a function to read the flash ID like below:

static void read_flash_id()
{
        u32 l;
 
        NAND_REG32(NND_ADDR_SRC)=0x00;
        NAND_REG8(NND_COMMAND)=0x90;
 
        //wait_for_tr();
 
        l = NAND_REG32(NND_ACCESS);
        printk("MID:%x\n",l);
        l = NAND_REG32(NND_ACCESS);
        printk("ID:%x\n",l);

}

the result is actually zero.

could someone tell me the difference between software controller and 
hardware control?  need change diagram? please help.



Kindle
Br
