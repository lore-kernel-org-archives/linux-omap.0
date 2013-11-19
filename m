From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Tue, 19 Nov 2013 14:24:16 +0100
Message-ID: <20131119132416.GE14587@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On Tue 2013-11-19 11:18:04, Pali Roh=E1r wrote:
> This patch removing set_mode_hook function from board data and replac=
ing it with
> new string variable of notifier power supply device. After this chang=
e it is
> possible to add DT support because driver does not need specific boar=
d function
> anymore. Only static data and name of power supply device is required=
=2E
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
