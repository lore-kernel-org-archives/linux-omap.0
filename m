From: Tony Lindgren <tony@atomide.com>
Subject: Re: PalmTT
Date: Fri, 10 Nov 2006 02:16:43 +0200
Message-ID: <20061110001643.GU16172@atomide.com>
References: <200611072158.15804.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611072158.15804.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061107 23:15]:
> Hi,
> I=C2=B4ve pulled latest git snapshot and it seems palmtt is there (all =
four=20
> patches - board, defconfig, lcd, leds), but as Tony wrote I had to fix =
those=20
> tabs (formating) before it=C2=B4ll be (maybe ;-)) merged. I havent seen=
 any=20
> mention about merging TT on gitweb so I was just curious why is it ther=
e :)

Oops, sorry. Looks like I pushed them accidentally in Kyungmin's USB
patch.
=20
> Well ... doesnt matter ... here=C2=B4s a patch that fixes formating in=20
> board-palmtt.c and lcd-palmtt.c (formating - tabs and removing commente=
d=20
> code). I=C2=B4ve also made a small change to board-palmz71.c formating.

Well I just reverted the patch, and reapplied Kyungmin's patch without
your code :)

The reason is that we want to be able to send the patches upstream as
they are without editing them again. And reverting a patch and reapplying
the modified patch makes sending patches upstream easy, as we can just
ignore the reverted patches.

Can you please repost your series one more time with the formatting
changes?
=20
> Plus I changed GPIO 6 name in board-palmz71(tt).h (renamed=20
> PALMxxx_PINTDAV_GPIO to PALMxxx_PENIRQ_GPIO, where xxx=3DTT or Z71). Ho=
pe it=20
> doesnt matter I put it into one patch while it=C2=B4s a small (one line=
 - see the=20
> bottom of the patch) change.

OK

Regards,

Tony
