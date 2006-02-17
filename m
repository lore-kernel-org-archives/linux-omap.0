From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: problem compiling kernel
Date: Fri, 17 Feb 2006 17:00:27 +0100
Message-ID: <43F5F31B.2010503@gmail.com>
References: <ae36f8040602151025o25f4661dp8a4c1696a1f56bcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040602151025o25f4661dp8a4c1696a1f56bcb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lvcargnini@ieee.org
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Cargnini wrote:
>  CC      drivers/input/touchscreen/omap/omap_ts.o
> drivers/input/touchscreen/omap/omap_ts.c:230: error: syntax error
> before '{' token
> drivers/input/touchscreen/omap/omap_ts.c:233: error: syntax error
> before '}' token
> make[4]: *** [drivers/input/touchscreen/omap/omap_ts.o] Error 1
> make[3]: *** [drivers/input/touchscreen/omap] Error 2
> make[2]: *** [drivers/input/touchscreen] Error 2
> make[1]: *** [drivers/input] Error 2
> make: *** [drivers] Error 2

Does patch in previous mail fix this?

Which toolchain do use? My toolchain doesn't complain about=20
this.

Dirk
