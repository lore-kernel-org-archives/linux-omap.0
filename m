From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Mon, 5 Nov 2007 10:26:57 +0200
Message-ID: <20071105102657.f195e5c0.jarkko.nikula@nokia.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<1194011191-29395-3-git-send-email-jarkko.nikula@nokia.com>
	<200711020927.40350.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200711020927.40350.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

"ext David Brownell" <david-b@pacbell.net> wrote:

> > +=A0=A0=A0=A0=A0=A0=A0omap_register_i2c_bus(1, 100);
>=20
> I always use 400 kHz on this board.  :)
>=20
> Is there a reason you're not using 400k anywhere?
> ISTR at one point checking specs and finding that
> many TI dev boards were spec'd so that 400k should
> work fine.
>=20
Reason is to not break anything :-)

Honestly I don't believe that we have many boards with components not
rated for 400 kHz.

I'll modify osk so that it will use 400 kHz. Probably N800 as well :-)


	Jarkko
