From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: dspgw: illigal seq bit for demo_console.out
Date: Mon, 19 Feb 2007 09:18:13 +0200
Message-ID: <20070219091813.3d1db870.Hiroshi.DOYU@nokia.com>
References: <5d5443650702170307h3913acdasf7b950e8df1caad1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702170307h3913acdasf7b950e8df1caad1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Soni,

It comes from the definition of sequence bit in mailbox. In public dsp
s/w doesn't use this bit. So just disable this definition in kernel,
and it should work.

    Hiroshi DOYU

On Sat, 17 Feb 2007 16:37:51 +0530
"ext Trilok Soni" <soni.trilok@gmail.com> wrote:

> Doyu-San,
> 
> I am trying to execute demo_console.out on H4 with latest git kernel,
> but it gives me DSP configuration failed message. What could be wrong?
> 
> -----------------------------snip------------------------------
> #/usr/sbin/dspctl start demo_console.out
> <7>omapdsp: mapping in ARM MMU, v=0xe0fff000, p=0x80488000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fce000, p=0x48008000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fdc000, p=0x4807c000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fdd000, p=0x4807e000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fde000, p=0x48080000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fdf000, p=0x48082000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fe0000, p=0x48090000, sz=0x1000
> <7>omapdsp: mapping in ARM MMU, v=0xe0fe2000, p=0x48094000, sz=0x1000
> loading demo_console.out...
> dspgw_initcall  : adr = 0x000000, size=    0
> dspgw_task      : adr = 0x00d760, size=   36
> dspgw_version   : adr = 0x000000, size=    8  ... ignored.
> SARAM_seq       : adr = 0x010000, size=    8  ... initialized.
> DARAM_seq       : adr = 0x000100, size=    8  ... initialized.
> SDRAM_seq       : adr = 0xfffd00, size=    8  ... initialized.
> SDRAM_system_data : adr = 0xfffd08, size=  136  ... initialized.
> sleep_code      : adr = 0x000108, size=  224  ... initialized.
> sleep_data      : adr = 0x0001e8, size=    2  ... initialized.
> .vers           : adr = 0x000000, size=  120  ... ignored.
> .sysstack       : adr = 0x0001ec, size=  512  ... initialized.
> .clk    <7>mbox: sending   seq=0, cmd=70:00(DSPCFG:REQ), data=0000
>         : adr = 0x0003ec, size= <7>mbox: receiving seq=0, cmd=70:70(DSPCFG:PROTR
> EV), data=0019
>    8  ... initialized.
> .prd    <3>mbox: illegal seq bit! ignoring this command. (7028007f)
>         : adr = 0x0003f4, size= <3>mbox: illegal seq bit! ignoring this command.
>  (70a9fe88)
>   48  ... initialized.
> .swi    <3>mbox: illegal seq bit! ignoring this command. (23000000)
>         : adr = 0x000424, size=  160  ... initialized.
> .tsk            : adr = 0x0004c4, size=  264  ... initialized.
> .idl            : adr = 0x0005cc, size=    8  ... initialized.
> .hwi_disp_sec   : adr = 0x0005d4, size= 1024  ... initialized.
> .bss            : adr = 0x0009d4, size= 3410  ... initialized.
> .far            : adr = 0x000100, size=    0
> .sysdata        : adr = 0x001728, size=  348  ... initialized.
> .mem            : adr = 0x0001ea, size=    2  ... initialized.
> .cio            : adr = 0x000100, size=    0
> .sysregs        : adr = 0x000100, size=    0
> .switch         : adr = 0x000100, size=    0
> .trcdata        : adr = 0x001884, size=    6  ... initialized.
> .sem            : adr = 0x00188c, size=  176  ... initialized.
> .dsm            : adr = 0x000100, size=    0
> .data           : adr = 0x00193c, size=    4  ... initialized.
> .gio            : adr = 0x000100, size=    0
> .sys            : adr = 0x001940, size=   16  ... initialized.
> .cinit          : adr = 0x001950, size= 3386  ... initialized.
> .pinit          : adr = 0x00268c, size=    8  ... initialized.
> .pwrmdb         : adr = 0x000100, size=    0
> .gblinit        : adr = 0x002694, size=   74  ... initialized.
> .TSK_idle$stk   : adr = 0x0026e0, size= 2560  ... initialized.
> .TSK_sleep$stk  : adr = 0x0030e0, size= 2560  ... initialized.
> .TSK_super$stk  : adr = 0x003ae0, size= 2560  ... initialized.
> .const          : adr = 0x0044e0, size= 1638  ... initialized.
> .printf         : adr = 0x004b46, size=  340  ... ignored.
> .LOG_system$buf : adr = 0x004b80, size=  128  ... initialized.
> .args           : adr = 0x004b48, size=   16  ... initialized.
> .trace          : adr = 0x004c00, size= 1024  ... initialized.
> .stack          : adr = 0x005000, size= 2048  ... initialized.
> .hst            : adr = 0x000100, size=    0
> .log            : adr = 0x004b58, size=   20  ... initialized.
> .pip            : adr = 0x000100, size=    0
> .sts            : adr = 0x005800, size=   96  ... initialized.
> .DARAM$heap     : adr = 0x005860, size=32512
> frt             : adr = 0x010000, size=    0
> .bios           : adr = 0x010008, size=10570  ... initialized.
> .text           : adr = 0x012952, size=22020  ... initialized.
> .sysinit        : adr = 0x017f58, size=  864  ... initialized.
> .hwi            : adr = 0x010000, size=    0
> .SARAM$heap     : adr = 0x0182b8, size=   16
> .hwi_vec        : adr = 0xffff00, size=  256  ... initialized.
> ipbuf           : adr = 0x004b6c, size=   14  ... initialized.
> dbgbuf          : adr = 0x00d784, size= 4096  ... initialized.
> setting DSP reset vector to 0x01824a
> releasing DSP reset
> <3>omapdsp: configuration error!
> DSP configuration ... failed
> Invalid argument
> --------------------------------snip--------------------------------------------
> 
> -- 
> --Trilok Soni
