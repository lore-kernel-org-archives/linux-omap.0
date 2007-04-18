From: "Leandro Melo de Sales" <leandroal@gmail.com>
Subject: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Wed, 18 Apr 2007 14:08:05 -0300
Message-ID: <5bc4c4570704181008w51ce9c3fg36769d80bf245fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi list,

  I download the git version and then, after some commands I got the following:

[sbox-SDK_ARMEL: ~/maemo_kernel_git/linux-omap] > make zImage
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC      arch/arm/mach-omap2/board-n800.o
arch/arm/mach-omap2/board-n800.c:507: error: `MACH_TYPE_NOKIA_N800'
undeclared here (not in a function)
arch/arm/mach-omap2/board-n800.c:507: error: initializer element is not constant
arch/arm/mach-omap2/board-n800.c:507: error: (near initialization for
`__mach_desc_NOKIA_N800.nr')
make[1]: *** [arch/arm/mach-omap2/board-n800.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

What is the problem? I'm using scratchbox and before make zImage, I
did make n800_defconfig.

Any clue will be greatfully appreciated.

Thank you,
Leandro.

-- 
Leandro Melo de Sales.
Computer Science MSc Candidate
Pervasive and Embedded Computing Lab - embedded.ufcg.edu.br
Center of Electrical Engineering and Informatics at Federal University
of Campina Grande - UFCG / Brazil
083 33101404 (extension 208)
