From: Dave Young <dyoung@redhat.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 16:18:09 +0800
Message-ID: <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
References: <201507111405.06048@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507111405.06048@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/11/15 at 02:05pm, Pali Roh=E1r wrote:
> Hello,
>=20
> now I tested 4.2-rc1 release on Nokia N900 and couple of drivers are
> broken and cause kernel oops...
>=20
> Basically wifi, touchscreen and rtc drivers not working...
>=20

Pali, could you tell how do you test mainline kernel on n900?

I used to use n900 as a usb dbgp gadget with a backport patch to
2.6.28 so that I can get early debug kernel message from my laptop.

I tried mainline previously with Fedora arm, text mode works but
no graphics. Is there a way to use maemo UI with mainline kernel?

Thanks
Dave
