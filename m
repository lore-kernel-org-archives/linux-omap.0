From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Problem in linking with montavista toolchain for omap2420
Date: Tue, 30 Jan 2007 15:55:25 +0100
Message-ID: <fb249edb0701300655t50b86cc0g1cf00284a62bf44f@mail.gmail.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B801B2253C@is01ex02.ittiam.com>
	<1170156349.4387.20.camel@localhost.localdomain>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1170156349.4387.20.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Indraneel <indraneel.m@samsung.com>
Cc: Madhava Gauranga <Madhava.Gauranga@ittiam.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 30/01/07, Indraneel <indraneel.m@samsung.com> wrote:
> LDFLAGS= -nostdlib -L/opt/montavista/devkit/arm/v5t_le/target/usr/lib
> -L/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1 -L/opt/montavista/devkit/arm/v5t_le/armv5tl-hardhat-linux/lib
>
> With this i am past the previous error and the new error is
>
> /opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1/../../../../armv5tl-hardhat-linux/bin/ld: warning: cannot find entry symbol _start; defaulting to 00008074
> /tmp/cc0VA6xr.o(.text+0x8): In function `main':
> : undefined reference to `puts'
> collect2: ld returned 1 exit status
>
> I guess it's something to do with path but i'm not sure what exactly.

These function (puts, _start) are part of the C library, which you
disabled by passing -nostdlib so it's understandable that the linker
is not finding them.

Personally I'd just try a different toolchain. Tools like "scratchbox"
or "crosstool" or Gentoo's "crossdev"  make it particularly easy to
compile a working toolchain. You can also build it using only bare
gcc, binutils and glibc/uclibc sources.

If you have libc.so but not libc.so.6 try symlinking libc.so.6 ->
libc.so (not guarranted to work but may help, maybe someone forgot to
pack the link).

Regards,
Andrew
