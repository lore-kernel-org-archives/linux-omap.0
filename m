From: Vineet Tuli <vineet@cybernetra.com>
Subject: Re: GCC with glibc
Date: Sun, 12 Feb 2006 10:53:45 +0530
Message-ID: <1139721825.2526.0.camel@meenakshi.linux>
References: <ae36f8040602070944v3e377470v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040602070944v3e377470v@mail.gmail.com>
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
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

please use --disable-shared while compiling gcc. This will solve the
problem.

Vineet Tuli


On Tue, 2006-02-07 at 15:44 -0200, Lu=C3=ADs Cargnini wrote:
> Hi i have done the toolchain construction from scratch until the step
> where i compile the gcc after had did the glibc but i receiving this
> error message:
> /opt/arm-linux/arm-linux/bin/ld: crti.o: No such file: No such file or =
directory
> collect2: ld returned 1 exit status
> make[2]: *** [libgcc_s.so] Error 1
> make[2]: Leaving directory
> `/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
> make[1]: *** [libgcc.a] Error 2
> make[1]: Leaving directory
> `/home/lvcargnini/puc/mestrado/instramed/builds/linux/b-gcc/gcc'
> make: *** [all-gcc] Error 2
>  how could i solve this ???
> --
> Thanks && Regards
> Msc. Bsc. Lu=C3=ADs Vit=C3=B3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
