From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: Re: problems compiling u-Boot 1.1.4 (2)
Date: Fri, 17 Feb 2006 01:30:19 -0200
Message-ID: <ae36f8040602161930m4cd1c758vc451bc11a0610777@mail.gmail.com>
References: <ae36f8040602151401j4776aaccge3bd4818a95c60c5@mail.gmail.com>
	<20060216.123750.18297871.kaminaga@sm.sony.co.jp>
	<ae36f8040602160414s1af05cdcmf64b14448a894ff3@mail.gmail.com>
	<20060217.095643.71082850.kaminaga@sm.sony.co.jp>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060217.095643.71082850.kaminaga@sm.sony.co.jp>
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
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

but this omap is a arm926ejs it have hardware fp i don't have this
options --without-float or --with-float=3Dhard, neither
--with-float=3Dsoft'
but --with-float=3Dsoft will add software fp correct ?

On 2/16/06, Hiroki Kaminaga <kaminaga@sm.sony.co.jp> wrote:
> Hi,
>
> > so about toolchain i must recreate the gcc without some options ?
>
> Will you try:
> $ arm-linux-gcc -v
> and see if there is `--with-float=3Dsoft'?
>
> If you can't find this, or --without-float or --with-float=3Dhard, then
> your gcc is compiled with hardware FP.
> add --with-float=3Dsoft when you configure gcc, rebuild gcc, and try agai=
n.
>
> Hope this helps.
>
>
> Best Regards,
>
> HK.
> --
>


--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
