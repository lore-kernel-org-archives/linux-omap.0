From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Mon, 1 Oct 2007 20:20:25 -0300
Message-ID: <ae36f8040710011620s33ae47c1hdb9b985423074b81@mail.gmail.com>
References: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
	<46F1450E.8020307@googlemail.com> <20071001180626.GN24656@atomide.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071001180626.GN24656@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony please I submitted a patch for mcbsp.{c,h}, modifying it to support
shared IRQ on McBSP ports, it are working for me, and for my device driver,
I'm testing it yet it take me sometime. But the device diver isn't a major
question, only the interruption modification on mcbsp file as I said.

On 10/1/07, Tony Lindgren <tony@atomide.com> wrote:
>
> * Dirk Behme <dirk.behme@googlemail.com> [070919 08:50]:
> > Lu=EDs Cargnini wrote:
> >> --- linux-omap-2.6/arch/arm/plat-omap/devices.c 2007-08-28 01:01:
> >> 50.502065325 -0300
> >> +++ linux-omap-2.6.23-instramed
> /arch/arm/plat-omap/devices.c    2007-09-18
> >> 15:05:44.748685528 -0300
> > ...
> >
> > Should this be a fix for your issues [1]?
> >
> > If yes, why do you think [2] isn't sufficent? Did you try [2]?
> >
> > [3] introduced usage of OMAP2_CTRL_BASE undefined on OMAP1. So anything
> > like [2] to fix compilation issues like [1] should be sufficent to fix
> [1].
> > [2] works at least for me selecting MMC on OSK.
>
> Luis, please repost your patch if something still needs to be patched.
>
> Tony
>
>
>
> > [1]
> >
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/011=
373.html
> >
> > [2]
> >
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/011=
393.html
> >
> > [3]
> >
> http://source.mvista.com/git/?p=3Dlinux-omap-2.6.git;a=3Dcommitdiff;h=3Da=
d1794683d378d08467ea9b340628994ff3e7edd
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
