From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: problem compiling kernel
Date: Wed, 15 Feb 2006 18:25:27 +0000
Message-ID: <ae36f8040602151025o25f4661dp8a4c1696a1f56bcb@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

 CC      drivers/input/touchscreen/omap/omap_ts.o
drivers/input/touchscreen/omap/omap_ts.c:230: error: syntax error
before '{' token
drivers/input/touchscreen/omap/omap_ts.c:233: error: syntax error
before '}' token
make[4]: *** [drivers/input/touchscreen/omap/omap_ts.o] Error 1
make[3]: *** [drivers/input/touchscreen/omap] Error 2
make[2]: *** [drivers/input/touchscreen] Error 2
make[1]: *** [drivers/input] Error 2
make: *** [drivers] Error 2

someone know about it or how to fix ?
i taked a look at source but seems ok, any fix available ?
--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
