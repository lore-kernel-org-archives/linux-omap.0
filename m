From: "Girish" <girishsg@ti.com>
Subject: RE: touch screen on 2430sdp not giving X and Y values
Date: Mon, 29 Oct 2007 18:23:41 +0530
Message-ID: <000001c81a2a$bc3ea5b0$6a8918ac@ent.ti.com>
References: <c656a4d20710290335h5f754ee2nf4eea969366530d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <c656a4d20710290335h5f754ee2nf4eea969366530d1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'arun c' <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>> I guess vaux2 has to be enabled for TS to work on 2430sdp, you can=20
>> Cross check in TRM.
>
>Power supply is OK, i think so because everything is working=20
>fine on CSST diagnostics tests.
What I mean to say is, the vaux won't be enabled before. So check if =
init/probe of TS driver is doing so.
Because, even if you get pen-irq if touch screen interface is not =
powered up then co-ordinates values wont
get generated.=20

>omap_tsc2046_read_buf [317] X : 0        Y:0     P : 0
>
>omap_tsc2046_read_buf[332]:Exit(0)
>omap_tsc2046_tasklet[366]:Exit(0)
>omap_tsc2046_timer Entry
>pen_down Entry
>pen_down[249]:Exit(1)
>omap_tsc2046_timer[395]:Exit(0)
>
>The problem is that for all the presses i am getting
>
>X=3D0               Y=3D0              and  P=3D0
>what could be the problem????? please somebody help me
you are getting penirq, the problem should be TS interface not powered =
up or
SPI interface with TS is not properly done. Apart from this I don=92t =
see anyting should cause such
behaviour. If the vaux is enabled properly then you can see if spi.1 is =
correctly plugged for TS or not.

girish
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
