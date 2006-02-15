From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: RE: changing core frequency in omap 5912
Date: Wed, 15 Feb 2006 15:14:27 +0900 (JST)
Message-ID: <20060215.151427.74738658.kaminaga@sm.sony.co.jp>
References: <C51F43ABFC95844490F0529B60753BF4038CD242@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-users-admin@lists.sourceforge.net>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF4038CD242@dlee02.ent.ti.com>
Sender: u-boot-users-admin@lists.sourceforge.net
Errors-To: u-boot-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=u-boot-users>
To: jon-hunter@ti.com
Cc: vshrirama@gmail.com, u-boot-users@lists.sourceforge.net, linux-omap-open-source@linux.omap.com, kaminaga@sm.sony.co.jp
List-Id: linux-omap@vger.kernel.org

Hi,

> So here is what you need to do:
> 
> 1). Make sure the DPLL1 is in bypass
> 2). Configure the ARM_SYSST for "synchronous scalable" mode
> 3). Configure the ARM_CKCTL register so that the different clock domains
> operate no faster than the maximum speed for that particular domain. See
> "OMAP5912 Global Clock Rules" in the OMAP5912 Errata guide for a list
> showing the maximum speed for each clock domain
> (http://focus.ti.com/docs/prod/folders/print/omap5912.html)
> 4). Configure DPLL1. 

Thank you!

I tried below code, (in temporary cmd in u-boot):

        /* register address */
#define CLKGEN_REG_BASE         (0xfffece00)
#define REG_ARM_CKCTL           (CLKGEN_REG_BASE + 0x0)
#define REG_ARM_IDLECT1         (CLKGEN_REG_BASE + 0x4)
#define REG_ARM_IDLECT2         (CLKGEN_REG_BASE + 0x8)
#define REG_ARM_EWUPCT          (CLKGEN_REG_BASE + 0xC)
#define REG_ARM_RSTCT1          (CLKGEN_REG_BASE + 0x10)
#define REG_ARM_RSTCT2          (CLKGEN_REG_BASE + 0x14)
#define REG_ARM_SYSST           (CLKGEN_REG_BASE + 0x18)
#define REG_ARM_IDLECT3         (CLKGEN_REG_BASE + 0x24)
#define REG_ARM_DPLL1           (0xfffecf00)
        /* register set value */
#define VAL_ARM_SYSST           (0x1000)
#define VAL_ARM_DPLL1           (0x2810)
#define VAL_ARM_CKCTL           (0x050f)
#define VAL_ARM_IDLECT1         (0x0400)
#define VAL_ARM_IDLECT2         (0x0000)
        /* ARM_IDLECT2 bit shifts */
#define EN_WDTCK        0
#define EN_XORPCK       1
#define EN_PERCK        2
#define EN_LCDCK        3
#define EN_LBCK         4 /* Not on 1610/1710 */
/*#define EN_HSABCK     5*/
#define EN_APICK        6
#define EN_TIMCK        7

...

	*(short *)REG_ARM_SYSST = VAL_ARM_SYSST;
	{ /* busy loop wait finish bubbles */
		int i = 0x400;
		while (i--) ;
	}
	*(short *)REG_ARM_DPLL1 = VAL_ARM_DPLL1;
	{ /* busy loop wait to let it settle */
		int i = 10;
		while (i--) ;
	}
	*(short *)REG_ARM_CKCTL = VAL_ARM_CKCTL;
	*(short *)REG_ARM_CKCTL &= 0xfff;
	*(short *)REG_ARM_RSTCT1 = 0x0;
	*(short *)REG_ARM_RSTCT2 = 0x1; /* PER_EN bit */
	*(short *)REG_ARM_IDLECT1 = VAL_ARM_IDLECT1;

	*(short *)REG_ARM_IDLECT2 |= EN_PERCK;
	*(short *)REG_ARM_IDLECT2 |= EN_XORPCK;
	*(short *)REG_ARM_IDLECT2 |= EN_TIMCK;

	{ /* busy loop wait finish bubbles */
		int i = 0x400;
		while (i--) ;
	}

and seems working:

(ARM CKCTL register content)
OMAP5912 OSK # md.l fffece00
fffece00: 0000050f 00000400 000003ff 0000003f    ............?...
fffece10: 00000000 00000001 00001000 00000015    ................
fffece20: 00000000 00000015 0000ffff 0000ffff    ................
...
(ARM DPLL1 register content)
OMAP5912 OSK # md.l fffecf00
fffecf00: 00002813 2b58c02f 00010000 00000000    .(../.X+........


I'm not sure about the amount and place of delay I need though...
(I set delay referencing board/omap5912osk/lowlevel_init.S)

# Also, is there any simpler method to read ARM926EJS cpu speed?


Best Regards,

HK.
--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
