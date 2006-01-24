From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: Re: tollchain and kernel source
Date: Tue, 24 Jan 2006 16:03:48 -0200
Message-ID: <ae36f8040601241003t4e8fcab9q@mail.gmail.com>
References: <ae36f8040601230447g6af145f3k@mail.gmail.com>
	<43D503C9.6020907@indt.org.br>
	<ae36f8040601230847k351b7fc6m@mail.gmail.com>
	<1138098390.2500.1.camel@meenakshi.linux>
	<ae36f8040601240330x6af0ed66i@mail.gmail.com>
	<1138102708.2500.2.camel@meenakshi.linux>
	<43D63818.9000800@indt.org.br>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43D63818.9000800@indt.org.br>
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
To: David Cohen <david.cohen@indt.org.br>
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

during gcc build step i receibing this error , how could i fix this ??
i following the steps cited on the link but i sitll having this error

/opt/arm-linux/arm-linux/bin/ld: crti.o: No such file: No such file or dire=
ctory
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory
`/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory
`/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
make: *** [all-gcc] Error 2


On 24/01/06, David Cohen <david.cohen@indt.org.br> wrote:
> Hi Luis,
>
> You can use scratchbox. It already has a toolchain for arm. You can find
> it at www.scratchbox.org
>
> BR,
>
> David Cohen
>
> Vineet Tuli wrote:
>
> >Yes u can use the git kernel.
> >
> >On Tue, 2006-01-24 at 09:30 -0200, Lu=EDs Cargnini wrote:
> >
> >
> >>ok but the kernel step i must following what he says or i could make
> >>an modification and use the git of omap ? downloaded using git ? the
> >>official source tree ?
> >>
> >>On 24/01/06, Vineet Tuli <vineet@cybernetra.com> wrote:
> >>
> >>
> >>>Please check the following post on building a gcc-4.0 toolchain from
> >>>scratch:
> >>>
> >>>http://linux.omap.com/pipermail/linux-omap-open-source/2005-November/0=
05665.html
> >>>
> >>>Thanks
> >>>
> >>>Vineet Tuli
> >>>
> >>>On Mon, 2006-01-23 at 14:47 -0200, Lu=EDs Cargnini wrote:
> >>>
> >>>
> >>>>thanks
> >>>>On 23/01/06, Anderson Briglia <anderson.briglia@indt.org.br> wrote:
> >>>>
> >>>>
> >>>>>Hi Lu=EDs,
> >>>>>
> >>>>>I guess you can find some useful information at this link: http://ww=
w.muru.com/linux/omap/
> >>>>>Good luck :)
> >>>>>
> >>>>>Anderson Briglia
> >>>>>INdT - Manaus
> >>>>>
> >>>>>Lu=EDs Cargnini wrote:
> >>>>>
> >>>>>
> >>>>>>Hi i've downloaded the binutils,gcc, and Kernel linux source and
> >>>>>>started to create a tollchain for arm. But I in doubt about how to
> >>>>>>create my toolchain for omap from scratch and what source of kernel=
 i
> >>>>>>must use ? AN where to to found the source tree to donwload the lat=
est
> >>>>>>kernel source tree.
> >>>>>>Please i'm starting to develop for omap any new information will be=
 welcome.
> >>>>>>
> >>>>>>--
> >>>>>>
> >>>>>>
> >>>>--
> >>>>Thanks && Regards
> >>>>Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> >>>>IEEE Member
> >>>>Mastering Degree student @ PUC-RS Electrical Engineer Faculty
> >>>>_______________________________________________
> >>>>Linux-omap-open-source mailing list
> >>>>Linux-omap-open-source@linux.omap.com
> >>>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >>>>
> >>>>
> >>>
> >>>
> >>--
> >>Thanks && Regards
> >>Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> >>IEEE Member
> >>Mastering Degree student @ PUC-RS Electrical Engineer Faculty
> >>
> >>
> >
> >_______________________________________________
> >Linux-omap-open-source mailing list
> >Linux-omap-open-source@linux.omap.com
> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> >
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
