From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Re: Error compiling after cg-update
Date: Sat, 24 Jun 2006 17:54:11 -0300
Message-ID: <ae36f8040606241354q4fdb17f3xccd96d70c49f7a72@mail.gmail.com>
References: <ae36f8040606231421t190bf34kc704214290678d51@mail.gmail.com>
	<1151100463.27204.258.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1151100463.27204.258.camel@vence.internal.net>
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

i'm using the denx toolchain.


On 6/23/06, Kevin Hilman <khilman@deeprooted.net> wrote:
>
> You must be using gcc4.  Apply my gcc4 patch from yesterday to fix this
> problem.  I'll be pushing it soon.
>
> Kevin
>
> On Fri, 2006-06-23 at 18:21 -0300, Lu=EDs Cargnini wrote:
> > Hi, I've upgrade my kernel source tree.  after that i try to recompilat=
e
> and
> > this occur:
> >
> > arch/arm/plat-omap/clock.c:31: error: static declaration of 'clocks'
> follows
> > non-static declaration
> > include/asm/arch/clock.h:51: error: previous declaration of 'clocks' wa=
s
> > here
> > arch/arm/plat-omap/clock.c:33: error: static declaration of
> 'clockfw_lock'
> > follows non-static declaration
> > include/asm/arch/clock.h:52: error: previous declaration of
> 'clockfw_lock'
> > was here
> >
> >
>
>


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
