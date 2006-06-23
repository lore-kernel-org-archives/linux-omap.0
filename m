From: Kevin Hilman <khilman@deeprooted.net>
Subject: Re: Error compiling after cg-update
Date: Fri, 23 Jun 2006 15:07:43 -0700
Message-ID: <1151100463.27204.258.camel@vence.internal.net>
References: <ae36f8040606231421t190bf34kc704214290678d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040606231421t190bf34kc704214290678d51@mail.gmail.com>
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

You must be using gcc4.  Apply my gcc4 patch from yesterday to fix this
problem.  I'll be pushing it soon.

Kevin

On Fri, 2006-06-23 at 18:21 -0300, Lu=C3=ADs Cargnini wrote:
> Hi, I've upgrade my kernel source tree.  after that i try to recompilat=
e and
> this occur:
>=20
> arch/arm/plat-omap/clock.c:31: error: static declaration of 'clocks' fo=
llows
> non-static declaration
> include/asm/arch/clock.h:51: error: previous declaration of 'clocks' wa=
s
> here
> arch/arm/plat-omap/clock.c:33: error: static declaration of 'clockfw_lo=
ck'
> follows non-static declaration
> include/asm/arch/clock.h:52: error: previous declaration of 'clockfw_lo=
ck'
> was here
>=20
>=20
