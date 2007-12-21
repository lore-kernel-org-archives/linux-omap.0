From: "David Cohen" <dacohen@gmail.com>
Subject: Re: problems creating new cross-compiler
Date: Thu, 20 Dec 2007 22:06:10 -0400
Message-ID: <4b70acb90712201806p3458186et35221bc3273cbb51@mail.gmail.com>
References: <ae36f8040712201222n58fe5eccu181256fc7f9587de@mail.gmail.com>
	<31e679430712201239l75f21f32r591e463cf074df01@mail.gmail.com>
	<4b70acb90712201357m15c56baaqd51383cc28224c1@mail.gmail.com>
	<4b70acb90712201402s5e0abfb4n909ffc1d7c1666e3@mail.gmail.com>
	<ae36f8040712201653h225e93e1y7dc5bc5363883a86@mail.gmail.com>
	<ae36f8040712201749u1f53dec5r7f6776fbfe4e241e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040712201749u1f53dec5r7f6776fbfe4e241e@mail.gmail.com>
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
To: lvcargnini@gmail.com
Cc: linux-omap@vger.kernel.org, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

But do you need to create it for some reason, or do you need just to use it=
?

Br,

David Cohen

On Dec 20, 2007 9:49 PM, Lu=EDs Vit=F3rio Cargnini <lvcargnini@gmail.com> w=
rote:
> Please there is a new howto to create a new gcc for omap  1,2,
> different from the existent in the web ?
> Becasue Felipe sent me a set of configurations different that we
> usually found in the net
>
>
> On Dec 20, 2007 10:53 PM, Lu=EDs Vit=F3rio Cargnini <lvcargnini@gmail.com=
> wrote:
> > any way I will try both
> > Thanks all for the help
> >
> >
> > On Dec 20, 2007 8:02 PM, David Cohen <dacohen@gmail.com> wrote:
> > > Sorry, I misunderstood. You're creating one. Just do what Felipe said=
.
> > > But you might get the one I pointed. It is easy and it's ready for
> > > use.
> > >
> > > BR,
> > >
> > > David Cohen
> > >
> > >
> > >
> > >
> > > On Dec 20, 2007 5:57 PM, David Cohen <dacohen@gmail.com> wrote:
> > > > Hi,
> > > >
> > > > If you don't have the arm-none-eabi-gcc, download it from:
> > > > http://www.codesourcery.com/gnu_toolchains/arm/download.html
> > > >
> > > > Then, add its "bin" dir on PATH.
> > > >
> > > > []'s
> > > >
> > > > David Cohen
> > > >
> > > >
> > > > On Dec 20, 2007 4:39 PM, Felipe Balbi <felipebalbi@users.sourceforg=
e.net> wrote:
> > > > > Hi,
> > > > >
> > > > > First of all, send email to our new list:
> > > > > linux-omap@vger.kernel.org
> > > > >
> > > > > On Dec 20, 2007 4:22 PM, Lu=EDs Vit=F3rio Cargnini <lvcargnini@gm=
ail.com> wrote:
> > > > > > Dear colleagues,
> > > > > >
> > > > > > I having the following problem:
> > > > > > (enterprise:toolchain/build/gcc) lvcargnini% ../../sources/gcc-=
4.2.2/configure
> > > > > > --prefix=3D/opt/arm-linux --target=3Darm-linux --enable-cross -=
-disable-threads
> > > > > > --enable-languages=3Dc --disable-shared --disable-multilib
> > > > > > --enable-__cxa_atexit --with-float=3Dsoftfp
> > > > > > --with-gxx-include-dir=3D/opt/arm-linux/arm-linux/include/g++-v=
3
> > > > > > --with-headers=3D/opt/arm-linux/arm-linux/include
> > > > > > loading cache ./config.cache
> > > > > > checking host system type... i686-pc-linux-gnu
> > > > > > checking target system type... arm-unknown-linux-gnu
> > > > > > checking build system type... i686-pc-linux-gnu
> > > > > > checking for a BSD compatible install... /usr/bin/install -c
> > > > > > checking whether ln works... yes
> > > > > > checking whether ln -s works... yes
> > > > > > checking for gcc... arm-linux-gcc
> > > > > > checking whether the C compiler (arm-linux-gcc  ) works... no
> > > > > > configure: error: installation or configuration problem: C comp=
iler cannot
> > > > > > create executables.
> > > > >
> > > > > Try the following:
> > > > > ./configure --target=3Darm-none-linux-gnueabi
> > > > > --program-prefix=3Darm-linux- --prefix=3D/usr/local --enable-shar=
ed
> > > > > --enable-threads --disable-libmudflap --disable-libssp
> > > > > --disable-libgomp --disable-libstdcxx-pch --with-gnu-as --with-gn=
u-ld
> > > > > --enable-languages=3Dc --with-newlib --disable-nls --with-headers=
=3Dyes
> > > > > --enable-poison-system-directories  && make
> > > > >
> > > > >
> > > > > This might work ;-)
> > > > > --
> > > > > Best Regards,
> > > > >
> > > > > Felipe Balbi
> > > > > felipebalbi@users.sourceforge.net
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-o=
map" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > > > >
> > > >
> > >
> >
> >
> >
> > --
> > -----------------------------------------------------------------------=
-------
> >
> > Thanks && Regards
> > M.Sc. B.Sc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Electrical Engineer Faculty @ PUCRS
> > Ipiranga Avenue, 6681 =96 Building 30
> > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > Phone: +55 51 3320 3500  extension: 7696
> > -----------------------------------------------------------------------=
----------
> >
>
>
>
> --
> -------------------------------------------------------------------------=
-----
> Thanks && Regards
> M.Sc. B.Sc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
>
