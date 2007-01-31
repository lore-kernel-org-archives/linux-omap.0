From: Indraneel <indraneel.m@samsung.com>
Subject: Re: Problem in linking with montavista toolchain for omap2420
Date: Wed, 31 Jan 2007 16:50:48 +0530
Message-ID: <1170242448.4387.42.camel@localhost.localdomain>
References: <904DEC693BE1AB429622C6F5ABA7E0B801B2253C@is01ex02.ittiam.com>
	<1170156349.4387.20.camel@localhost.localdomain>
	<fb249edb0701300655t50b86cc0g1cf00284a62bf44f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <fb249edb0701300655t50b86cc0g1cf00284a62bf44f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Madhava Gauranga <Madhava.Gauranga@ittiam.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Andrew,

On Tue, 2007-01-30 at 15:55 +0100, andrzej zaborowski wrote:
> Hi,
> 
> On 30/01/07, Indraneel <indraneel.m@samsung.com> wrote:
> > LDFLAGS= -nostdlib -L/opt/montavista/devkit/arm/v5t_le/target/usr/lib
> > -L/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1 -L/opt/montavista/devkit/arm/v5t_le/armv5tl-hardhat-linux/lib
> >
> > With this i am past the previous error and the new error is
> >
> > /opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1/../../../../armv5tl-hardhat-linux/bin/ld: warning: cannot find entry symbol _start; defaulting to 00008074
> > /tmp/cc0VA6xr.o(.text+0x8): In function `main':
> > : undefined reference to `puts'
> > collect2: ld returned 1 exit status
> >
> > I guess it's something to do with path but i'm not sure what exactly.
> 
> These function (puts, _start) are part of the C library, which you
> disabled by passing -nostdlib so it's understandable that the linker
> is not finding them.
> 
> Personally I'd just try a different toolchain. Tools like "scratchbox"
> or "crosstool" or Gentoo's "crossdev"  make it particularly easy to
> compile a working toolchain. You can also build it using only bare
> gcc, binutils and glibc/uclibc sources.

The tool chain should be okay as i'm "able to build and run the kernel"
using the same montavista v5t_le toolchain. But surprisingly i'm unable
to build a simple application binary using the same. I'm giving the
-nostdlib option so that it doesn't pick C libs from the host. The path
to the libs is provided in the -L option. Correct me if my understanding
is wrong.
It should be a matter of giving the correct compiler/linker options to
build the code but i haven't been able to figure that out till now.

If somebody is using the montavista v5t_le toolchain (for TI's H4
board), please let me know the options to compile and link a simple
HelloWorld program.

Other info
gcc
version 3.3.1 (MontaVista 3.3.1-7.0.15.0500230 2005-02-20)
--with-sysroot=/opt/montavista/devkit/arm/v5t_le/target

GNU ld
version 2.14 20030612 (MontaVista 2.14-11.0.7.0500230 2005-02-20)

PATH=/opt/montavista/devkit/arm/v5t_le/bin:$PATH (i keep the toolchain
here)




Regards,
Indraneel


> 
> If you have libc.so but not libc.so.6 try symlinking libc.so.6 ->
> libc.so (not guarranted to work but may help, maybe someone forgot to
> pack the link).
> 
> Regards,
> Andrew
> 
> 
