From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Undefined Reference
Date: Mon, 30 Oct 2006 09:21:40 -0400
Message-ID: <4545FC64.3070908@nokia.com>
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
To: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Could anyone help me getting this bug fixed?
I've already git pull'd the new version of linux-omap-2.6 git tree and 
it didn't work at all.

isp1301.c is including linux/usb/otg.h, hcd.c exports the symbol 
usb_bus_start_enum wich is declared inside otg.h as extern.


drivers/built-in.o: In function `omap_otg_irq':
drivers/i2c/chips/isp1301_omap.c:851: undefined reference to 
`usb_bus_start_enum'
make: *** [.tmp_vmlinux1] Error 1

-- 
Best Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC - INdT
