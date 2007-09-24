From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 00/01] ARM: OMAP: Makes DSP compiles again for 1510 boards
Date: Mon, 24 Sep 2007 11:50:17 -0400
Message-ID: <46F7DCB9.6020402@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
Cc: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi folks,

I'd found the following problems when compiling a kernel image to
Innovator 1510 and Siemens SX1 with OMAP DSP driver (DSP Gateway)
support option enabled:

  CC      arch/arm/plat-omap/dsp/dsp_mem.o
In file included from arch/arm/plat-omap/dsp/dsp_mem.c:55:
arch/arm/plat-omap/dsp/mmu.h:10: error: 'OMAP1510_DSP_MMU_BASE'
undeclared here (not in a function)
make[2]: *** [arch/arm/plat-omap/dsp/dsp_mem.o] Error 1
make[1]: *** [arch/arm/plat-omap/dsp] Error 2
make: *** [arch/arm/plat-omap] Error 2

This simple patch makes DSP compiles again for 1510 boards.

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
