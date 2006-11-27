From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: problems with DSP
Date: Mon, 27 Nov 2006 18:54:40 -0200
Message-ID: <ae36f8040611271254k2ead290ft2679fb74d291c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
please i need some help with DSP programming using DSP Gateway. I'm
trying to write a MMAP application (start based on examples), but i
having some problems
i configured the cmd file as following:

-l tokliBIOS.cmd
-l tokliBIOScfg.cmd

MEMORY {
=09SDRAM:  origin =3D 0x2f000, len =3D 0x10000

}

SECTIONS {
=09shared_buf: align =3D 0x1000 {} > SDRAM

}



and configuring my  dsp using dspctl with following command:

/mnt/omap # dspctl exmap 0x2f000 0x10000
mapping external memory for DSP: dspadr =3D 0x02f000, size =3D 0x10000
65536 (0x10000) bytes mapped.

but when i try to load the dsp running code this is what dspctl start
prints on screen:

/mnt/omap # dspctl start mmap.out
loading mmap.out...
dspgw_initcall  : adr =3D 0x000000, size=3D    0
dspgw_task      : adr =3D 0x001fcc, size=3D   36
dspgw_version   : adr =3D 0x000000, size=3D    8  ... ignored.
SARAM_seq       : adr =3D 0x010000, size=3D    8  ... initialized.
DARAM_seq       : adr =3D 0x000100, size=3D    8  ... initialized.
SDRAM_seq       : adr =3D 0xfffd00, size=3D    8  ... initialized.
SDRAM_system_data : adr =3D 0xfffd08, size=3D  136  ... initialized.
sleep_code      : adr =3D 0x000108, size=3D  280  ... initialized.
sleep_data      : adr =3D 0x000220, size=3D    2  ... initialized.
.vers           : adr =3D 0x000000, size=3D  120  ... ignored.
.sysstack       : adr =3D 0x000224, size=3D omapdsp: IPBUF configuration
           128 words * 4 lines at 0xe000d350.
 512  ... initialized.
.clk    omapdsp: found 1 task(s)
        : adr =3D 0x000424, size=3D omapdsp: task 0: name mmap
   8  ... initialized.
.prd    omapdsp: illegal mmap buffer address(0xe002f000) or length(0x4e20).
  It needs to be page-aligned and located at external memory.
        : adr =3D 0x00042c, size=3D   48  ... initialized.
.swi            : adr =3D 0x00045c, size=3D  120  ... initialized.
.tsk            : adr =3D 0x0004d4, size=3D  264  ... initialized.
.idl            : adr =3D 0x0005dc, size=3D    8  ... initialized.
.hwi_disp_sec   : adr =3D 0x0005e4, size=3D  384  ... initialized.
.bss            : adr =3D 0x000764, size=3D 5744  ... initialized.
.far            : adr =3D 0x000100, size=3D    0
.sysdata        : adr =3D 0x001dd4, size=3D  316  ... initialized.
.mem            : adr =3D 0x000222, size=3D    2  ... initialized.
.cio            : adr =3D 0x002000, size=3D  576  ... initialized.
.sysregs        : adr =3D 0x000100, size=3D    0
.sem            : adr =3D 0x001f10, size=3D  132  ... initialized.
.dsm            : adr =3D 0x000100, size=3D    0
.data           : adr =3D 0x001f94, size=3D    4  ... initialized.
.gio            : adr =3D 0x000100, size=3D    0
.sys            : adr =3D 0x001f98, size=3D   16  ... initialized.
.TSK_idle$stk   : adr =3D 0x002240, size=3D 2560  ... initialized.
.TSK_sleep$stk  : adr =3D 0x002c40, size=3D 2560  ... initialized.
.TSK_super$stk  : adr =3D 0x003640, size=3D 2560  ... initialized.
.const          : adr =3D 0x004040, size=3D 1838  ... initialized.
.printf         : adr =3D 0x00476e, size=3D  288  ... ignored.
.args           : adr =3D 0x001fa8, size=3D   16  ... initialized.
.LOG_system$buf : adr =3D 0x004780, size=3D  128  ... initialized.
.trace          : adr =3D 0x004800, size=3D 1024  ... initialized.
.stack          : adr =3D 0x004c00, size=3D 2048  ... initialized.
.hst            : adr =3D 0x000100, size=3D    0
.log            : adr =3D 0x001fb8, size=3D   20  ... initialized.
.pip            : adr =3D 0x000100, size=3D    0
.sts            : adr =3D 0x005400, size=3D   80  ... initialized.
.DARAM$heap     : adr =3D 0x005450, size=3D32512
frt             : adr =3D 0x010000, size=3D    0
.bios           : adr =3D 0x010008, size=3D10215  ... initialized.
.text           : adr =3D 0x0127f0, size=3D28397  ... initialized.
.switch         : adr =3D 0x010000, size=3D    0
.sysinit        : adr =3D 0x0196dd, size=3D  437  ... initialized.
.trcdata        : adr =3D 0x019892, size=3D    6  ... initialized.
.pinit          : adr =3D 0x010000, size=3D    0
.gblinit        : adr =3D 0x019898, size=3D   74  ... initialized.
.hwi            : adr =3D 0x010000, size=3D    0
.SARAM$heap     : adr =3D 0x0198e2, size=3D   16
.hwi_vec        : adr =3D 0xffff00, size=3D  256  ... initialized.
shared_buf      : adr =3D 0x02f000, size=3D20000  ... initialized.
ipbuf           : adr =3D 0x00d350, size=3D 1072  ... initialized.
dbgbuf          : adr =3D 0x00d780, size=3D 4096  ... initialized.
warning: found zero-sized cinit entry at 0xd92
.cinit          : adr =3D 0x010000, size=3D 3476   ... .bss variables are
initialized.
setting DSP reset vector to 0x0197b3
releasing DSP reset
DSP configuration ... failed
Invalid argument
/mnt/omap #

someone have any idea ?

--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS
Electrical Engineer Faculty
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
