From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Thu, 25 Jun 2015 09:27:11 +0200
Message-ID: <20150625072711.GD2890@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel>
 <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel>
 <20150506114417.GI30910@pali>
 <20150625050138.GL4156@atomide.com>
 <20150625071851.GB2890@pali>
 <20150625072205.GO4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150625072205.GO4156@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 25 June 2015 00:22:05 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150625 00:21]:
> >=20
> > Ok, but what do you mean to forget any string conversion?
>=20
> No need for tohexstr() in the uncommpress code if the system_rev
> value is a number coming from the dts.
>=20
> Regards,
>=20
> Tony

So /revision DT property will be (binary) value, right?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
