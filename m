From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sun, 15 Jan 2006 22:05:31 -0800 (PST)
Message-ID: <20060116060531.80856.qmail@web32902.mail.mud.yahoo.com>
References: <1137341099.7384.16.camel@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1137341099.7384.16.camel@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

>=20
> We have a TSC2301 driver that's in a pretty good shape now.  At the
> moment keypad and touchscreen are supported.  The audio mixer driver
> is
> work-in-progress.
>=20
> We'll merge it whenever Dave's SPI stuff finds its way into
> linux-omap.
>=20
> BTW, we also have a McSPI controller driver for OMAP2.  It uses PIO
> at
> the moment, but DMA support is on its way.

Cool. I hope you know that Dave's SPI fwk made it to Linus tree 2 days
back. :). It is time to sync up our tree.

And I had made a attempt to write OMAP2 SPI controller driver with that
framework. Here is the work-in-progress patch.

You can re-use most of the code from that when you further implement
patch based on Dave's fwk.

http://linux.omap.com/pipermail/linux-omap-open-source/2006-January/00610=
7.html

_or_ give me some review, so that I can change it and test it again.
You can send me your work-in-progress McSPI driver. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
