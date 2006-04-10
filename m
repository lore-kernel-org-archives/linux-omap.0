From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: Problems compiling with GCC-4.0.0
Date: Mon, 10 Apr 2006 16:48:48 -0300
Message-ID: <ae36f8040604101248g7dca1259of37ae1144f910a81@mail.gmail.com>
References: <20060410045239.55C6143AA1@ws5-1.us4.outblaze.com>
	<fb249edb0604100148m2f6857ds9413fabe953cc5a5@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0604100148m2f6857ds9413fabe953cc5a5@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

take a look at my blog
http://lvcargnini.blogspot.com/

On 4/10/06, andrzej zaborowski <balrog@zabor.org> wrote:
>
> Hi,
>
> On 10/04/06, Kanagesh R <kanagesh@india.com> wrote:
> > Hello,
> >
> > I have been using a toolchain built using crosstools.
> > The version of tools is as follows:
> > GCC-3.4.1
> > Binutils-2.15
> > GLIBC-2.3.2
> >
> > This has been compiling all kernels (2.6.12, 2.6.13,
> > 2.6.15) fine without any issues.
> >
> > I've now downloaded the ELDK (Ver 4) toolchain from
> > www.denx.de and I've tried to compile 2.6.15-omap1,
> > but without success.  It breaks while compiling file
> > drivers/input/touchscreen/omap/ompa_ts.c  (however,
> > when the same sources are compiled with GCC-3.4.1,
> > it builds fine)
> >
> > The version of tools in this toolchain is:
> > GCC-4.0.0
> > Binutils-2.16.1
> > GLIBC-2.3.5
> >
> > I then built a GCC-4.0.0 crosscompiler using crosstools
> > and I hit the same problem.
> >
> > Is anyone else using the ELDK-4.0 toolchain (or crosscompiler
> > GCC-4.0.0) and has similar problems?
>
> As far as I remember this has been already corrected. 2.6.15 was
> giving a couple of errors with GCC 4 but all of them trivially
> fixable.
> Please update your kernel sources.
> >
> > warm regards,
> > Kanagesh
> >
> >
> > --
> > India.com free e-mail - www.india.com.
> > Check out our value-added Premium features, such as an extra 20MB for
> mail storage, POP3, e-mail forwarding, and ads-free mailboxes!
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
> Regards,
> Andrew
> --
> balrog 2oo6
>
> Dear Outlook users: Please remove me from your address books
> http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>


--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
