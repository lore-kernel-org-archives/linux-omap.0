From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] RX-51: Fix probe order of SPI devices
Date: Wed, 10 Apr 2013 10:00:05 -0700
Message-ID: <20130410170001.GY10155@atomide.com>
References: <1364724561-18045-1-git-send-email-pali.rohar@gmail.com>
 <201303311318.41846@pali>
 <20130402163138.GS10155@atomide.com>
 <201304101615.19400@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201304101615.19400@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130410 07:20]:
> On Tuesday 02 April 2013 18:31:38 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130331 04:23]:
> > > On Sunday 31 March 2013 12:52:23 Sebastian Reichel wrote:
> > > > On Sun, Mar 31, 2013 at 12:09:21PM +0200, Pali Roh=C3=A1r wrote=
:
> > > > > From: Joni Lapilainen <joni.lapilainen@gmail.com>
> > > > >=20
> > > > > Without this patch LCD panel on Nokia RX-51 is still
> > > > > black
> > > > >=20
> > > > > Signed-off-by: Joni Lapilainen
> > > > > <joni.lapilainen@gmail.com> Signed-off-by: Pali Roh=C3=A1r
> > > > > <pali.rohar@gmail.com>
> > > >=20
> > > > Tested-by: Sebastian Reichel <sre@debian.org>
> > > >=20
> > > > Please note, that this patch has actually been proposed by
> > > > Aaro Koskinen <aaro.koskinen@iki.fi> quite some time ago
> > > > [0].
> > > >=20
> > > > [0]
> > > > http://permalink.gmane.org/gmane.linux.ports.arm.omap/8172
> > > > 9
> > > >=20
> > > > -- Sebastian
> > >=20
> > > CCing Aaro.
> >=20
> > Any ideas why this is happening?
> >=20
> > Is the touch screen controller somehow pulling one of the SPI
> > lines before it's reset? I don't think there's any other
> > connection between the LCD and touch controller besides the
> > SPI lines?
> >=20
> > In any case there should be something in the description why
> > this is needed..
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Hi Tony, look at this Aaro's email:
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/81729

OK can we have that summarized in the patch description please?

Regards,

Tony
