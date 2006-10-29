From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] OMAP MMC fixes
Date: Sun, 29 Oct 2006 20:32:35 +0100
Message-ID: <454501D3.2050009@gmail.com>
References: <200610282034.05218.marek.vasut@gmail.com>
	<200610282040.09413.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200610282040.09413.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?ISO-8859-2?Q?Marek_Va=B9ut?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Marek Va=B9ut wrote:
> oops, sorry, I missed the previous patch ...

;)

To get it right: You used 1 << data->blksz in your patch. I=20
think it should only be data->blksz without additional shift=20
because shift is already included in data->blksz?

http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dblobdi=
ff;h=3D5b9caa7978d34311839840243e38921255f6da4b;hp=3D74eaaee66de0e59532ba=
5655fddac5aaeea5ba08;hb=3D132919ba80ad207755fe271277bfefff865a54fe;f=3Ddr=
ivers/mmc/mmc.c

So, do you think

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/00818=
3.html

is correct?

Thanks

Dirk
