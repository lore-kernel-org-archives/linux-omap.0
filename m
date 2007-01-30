From: Indraneel <indraneel.m@samsung.com>
Subject: RE: Problem in linking with montavista toolchain for omap2420
Date: Tue, 30 Jan 2007 16:55:49 +0530
Message-ID: <1170156349.4387.20.camel@localhost.localdomain>
References: <904DEC693BE1AB429622C6F5ABA7E0B801B2253C@is01ex02.ittiam.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <904DEC693BE1AB429622C6F5ABA7E0B801B2253C@is01ex02.ittiam.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Madhava Gauranga <Madhava.Gauranga@ittiam.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Madhava,

On Tue, 2007-01-30 at 11:46 +0530, Madhava Gauranga wrote:
> Hey indranil,
> 
> I reckon u have copied the toolchain already installed somewhere,
> instead of installing them. try installing(perhaps from the cd(s)
> provided) the toolchain.


It shouldn't be a case of missing libs as i am able to build and run the
kernel from the same. I played around with the linker options

LDFLAGS= -nostdlib -L/opt/montavista/devkit/arm/v5t_le/target/usr/lib
-L/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1 -L/opt/montavista/devkit/arm/v5t_le/armv5tl-hardhat-linux/lib

With this i am past the previous error and the new error is

/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1/../../../../armv5tl-hardhat-linux/bin/ld: warning: cannot find entry symbol _start; defaulting to 00008074
/tmp/cc0VA6xr.o(.text+0x8): In function `main':
: undefined reference to `puts'
collect2: ld returned 1 exit status

I guess it's something to do with path but i'm not sure what exactly.

The code i'm trying to build is

#include<stdio.h>
int main (void)
{
printf("Hello World - arm linux\n");
return 0;
}


Regards,
Indraneel

>  The problem should be fixed then.
> 
> Respect,
> Madhava Gauranga
>  
> 
> Ittiam Systems | www.ittiam.com
> A Red Herring Asia 100 Company, 2005
> Forward Concepts' Worlds Most Preferred DSP IP Supplier, 2004, 2005
> 
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Indraneel
> Sent: Sunday, January 28, 2007 5:23 PM
> To: Linux-omap-open-source@linux.omap.com
> Subject: Problem in linking with montavista toolchain for omap2420
> 
> Hi,
> I'm trying to cross-compile a program using the montavista tool chain
> for arm_v5t_le architecture for the omap2420(h4 board). I get the
> following error when linking a simple c program:
> 
> $ arm_v5t_le-gcc -DPOSIX -DMD=2 rz.c
> /opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.
> 1/../../../../armv5tl-hardhat-linux/bin/ld: cannot find libc.so.6
> collect2: ld returned 1 exit status
> 
> 
> Surprisingly i couldn't find any file or link by the name libc.so.6 in
> the toolchain, although there was
> /opt/montavista/devkit/arm/v5t_le/target/usr/lib/libc.so
> 
> Other info
> gcc
> version 3.3.1 (MontaVista 3.3.1-7.0.15.0500230 2005-02-20)
> --with-sysroot=/opt/montavista/devkit/arm/v5t_le/target
> 
> GNU ld
> version 2.14 20030612 (MontaVista 2.14-11.0.7.0500230 2005-02-20)
> 
> PATH=/opt/montavista/devkit/arm/v5t_le/bin:$PATH
> 
> 
> I have searched for the error but couldn't find anything definitive.
> 
> Can anyone provide any clues as to what is wrong and how can i solve
> this linking issue?
> 
> Any pointers will be appreciated.
> 
> Regards,
> Indraneel
> 
> 
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> **********************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> helpdesk@ittiam.com.
> **********************************************************************
> 
> 
> 
