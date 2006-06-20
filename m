From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Implement support for two MMC slots
Date: Tue, 20 Jun 2006 09:39:51 -0700
Message-ID: <20060620163951.GD4257@atomide.com>
References: <20060619165202.GA30055@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060619165202.GA30055@mail.solidboot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Juha Yrj=F6l=E4 <juha.yrjola@solidboot.com> [060619 10:00]:
> Hi,
>=20
> Here's a patch for review.  It is by no means complete yet, but
> at least supporting two slots connected to Menelaus does work.

Nice to have the board-*.c MMC power clean-up done!
=20
> I'd also appreciate patches implementing support for
> omap_mmc_platform_data for the various board-*.c files=20

Let's wait until we have 2.6.17-omap1 ready and tagged before
pushing this.

Tony
