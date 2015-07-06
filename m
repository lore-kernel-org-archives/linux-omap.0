From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Mon, 6 Jul 2015 05:31:27 -0700
Message-ID: <20150706123126.GG10705@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <20150506114417.GI30910@pali>
 <20150625050138.GL4156@atomide.com>
 <201507061423.23505@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507061423.23505@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150706 05:25]:
>
> into which file should I put documentation about new DT properties?

If it's Linux generic like linux,revision, then how about
Documentation/devicetree/bindings/revision.txt?

=46or the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?

Regards,

Tony
