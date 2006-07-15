From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Problems compiling gcc-4.1.0
Date: Sat, 15 Jul 2006 07:06:32 +0200
Message-ID: <44B877D8.4050907@gmail.com>
References: <ae36f8040607141045p5669198ci65d28617d466bbed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040607141045p5669198ci65d28617d466bbed@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@ieee.org
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Cargnini wrote:
> i have modified ../gcc-4.1.0/gcc/config/arm/t-linux and added=20
> -Dinhibit_libc
> -D__gthr_posix_h
> what should i do ???

Maybe you should use an other (working?) toolchain?

Building gcc 4.1.0 with crosstool-0.42

http://kegel.com/crosstool/

using crosstool's

eval `cat arm.dat gcc-4.1.0-glibc-2.3.2.dat`  sh all.sh --notest

configuration works for me (except ALSA optimization issue [1]).

Or if you like prebuild toolchain

http://www.codesourcery.com/gnu_toolchains/arm/

Regards

Dirk

[1] http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D27363
