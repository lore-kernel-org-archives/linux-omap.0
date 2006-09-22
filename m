From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Re: booting new image
Date: Fri, 22 Sep 2006 15:14:39 -0300
Message-ID: <ae36f8040609221114v585d557ax7e491d1b84e165da@mail.gmail.com>
References: <ae36f8040609212108t1af9f0d5qc82f6eb5d717f546@mail.gmail.com>
	<45140C14.9020508@balister.org>
	<ae36f8040609221022y6f0a0802i56d849a45d27b994@mail.gmail.com>
	<4514202A.6050207@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4514202A.6050207@balister.org>
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

Gentlemen after booted my board using the image available in:
http://oskfordummies.hp.infoseek.co.jp/downloads/rootfs2.6.11_0612.tar.bz2

it booted using my kernel and my u-boot, it's an busybox version 1.0.0 so i
think the problem colud be with busy box.
any opinion ?

On 9/22/06, Philip Balister <philip@balister.org> wrote:
>
> yeah, let me put them on a web server. The only SW is all open source.
>
> Philip
>
> > On 9/22/06, * Philip Balister* <philip@balister.org
> > <mailto:philip@balister.org>> wrote:
> >
> >     I just took a look at my boot log and right after yours hangs I see
> >
> >     INIT: version 2.86 booting
> >
> >     Then it trys to start udev. With the fstab on your image that may
> not go
> >     smoothly. I have some changes I ahven't been able to check back in
> yet.
> >     RP in #oe mentioned there might be some trouble with busybox, but I
> do
> >     not know if it is related to this problem.
> >
> >     I would like to try and rebuild my OE stuff and test again to see i=
f
> I
> >     can narrow this down better, but I won't have time until next week,
> and
> >     even then it will be a background task for me. October I do need to
> make
> >     this work well though. Try asking gently in the #oe channel.
> >
> >     Thanks for the kind words :)
> >
> >     Philip
>
>


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
