From: Kevin Hilman <khilman@mvista.com>
Subject: Re: warning on compilation of kernel & another question device
	driver related
Date: Thu, 01 Nov 2007 13:46:32 -0700
Message-ID: <1193949992.6144.35.camel@vence.hilman.org>
References: <ae36f8040711011338m48e86deeo18219805af5e4fae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040711011338m48e86deeo18219805af5e4fae@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2007-11-01 at 18:38 -0200, Lu=C3=ADs Cargnini wrote:
> Dear fellows,
> Please while compiling my kernel I'm founding the following warning mes=
sage:
>  AS      .tmp_kallsyms2.o
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0x2994): Section mismatch: reference to .init.=
text:
> (between 'omap1_clk_functions' and 'rate_table')
>   LD      vmlinux
>  someone else have the same problem ? If so how to fix this ?

I'm guessing you have OMAP_RESET_CLOCKS enabled.

Try the patch I sent earlier today:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/0118=
44.html

Kevin
