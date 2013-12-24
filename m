From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Mon, 23 Dec 2013 17:58:28 -0800
Message-ID: <20131224015828.GB10223@lizard>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
 <20131119132416.GE14587@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131119132416.GE14587@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 19, 2013 at 02:24:16PM +0100, Pavel Machek wrote:
> On Tue 2013-11-19 11:18:04, Pali Roh=C3=A1r wrote:
> > This patch removing set_mode_hook function from board data and repl=
acing it with
> > new string variable of notifier power supply device. After this cha=
nge it is
> > possible to add DT support because driver does not need specific bo=
ard function
> > anymore. Only static data and name of power supply device is requir=
ed.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks!

Anton
