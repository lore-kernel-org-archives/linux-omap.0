From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Compiling latest kernel (from kernel.org,
 linux-omap git version) in n800
Date: Wed, 18 Apr 2007 20:30:47 +0200
Message-ID: <462663D7.6040308@googlemail.com>
References: <5bc4c4570704181008w51ce9c3fg36769d80bf245fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5bc4c4570704181008w51ce9c3fg36769d80bf245fbc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Leandro Melo de Sales <leandroal@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Leandro Melo de Sales wrote:
> Hi list,
> 
>  I download the git version and then, after some commands I got the 
> following:
> 
> [sbox-SDK_ARMEL: ~/maemo_kernel_git/linux-omap] > make zImage
>  CHK     include/linux/version.h
> make[1]: `include/asm-arm/mach-types.h' is up to date.
>  CHK     include/linux/utsrelease.h
>  CHK     include/linux/compile.h
>  CC      arch/arm/mach-omap2/board-n800.o
> arch/arm/mach-omap2/board-n800.c:507: error: `MACH_TYPE_NOKIA_N800'
> undeclared here (not in a function)
> arch/arm/mach-omap2/board-n800.c:507: error: initializer element is not 
> constant
> arch/arm/mach-omap2/board-n800.c:507: error: (near initialization for
> `__mach_desc_NOKIA_N800.nr')
> make[1]: *** [arch/arm/mach-omap2/board-n800.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> What is the problem?

MACH_TYPE_NOKIA_N800 used by Nokia isn't available by 
Russels (ARM kernel maintainer) machine registry [1]. It's 
currently just a 'hack' Nokia (?) made locally to 
arch/arm/tools/mach-types. Because of this 'hack' status it 
isn't checked in.

So you have to manually apply a patch:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008958.html

(second patch of this mail, 02-mach-types-hack.patch)

Regards

Dirk

Btw.: Just noticed that Kai Svahn registered mach number 
1271 for N800 in machine registry.

[1] http://www.arm.linux.org.uk/developer/machines/
