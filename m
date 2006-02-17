From: Tony Lindgren <tony@atomide.com>
Subject: Re: A problem about the uart3 of OMAP osk5912
Date: Fri, 17 Feb 2006 13:08:25 -0800
Message-ID: <20060217210824.GB771@atomide.com>
References: <20060217163457.9B78586CF0@mailreg.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060217163457.9B78586CF0@mailreg.nctu.edu.tw>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?utf-8?B?5p6X5bCP546r?= <subsun.ece94g@nctu.edu.tw>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* =E6=9E=97=E5=B0=8F=E7=8E=AB <subsun.ece94g@nctu.edu.tw> [060217 00:29]:
> Hi there,
>=20
> I have a problem about the uart3 of OMAP osk5912. The fact is that osk5=
912
> don't have a second substantial uart port. We tried to send a echo sign=
al to
> /dev/ttyS02(which is a character device node with the major number 4 an=
d
> minor number 65 we made), but there was no voltage change on the TX of
> uart3. Can you tell me how to control the second uart of osk5912 under =
OS?
> Further more, can you tell me how to use the USB serial converter? We w=
ere
> using the GMUS-03 with chipset prolific, although the required convert =
is
> Elecom's US-SGT.

If you solder a second UART to osk, you also have to init the additional
internal port. See board-osk.c for that. USB serial port should show up
as /dev/ttyUSB0.

Tony
