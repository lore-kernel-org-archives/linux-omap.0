From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Mon, 12 Oct 2015 13:45:09 -0700
Message-ID: <20151012204509.GT23801@atomide.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com>
 <20151012201640.GQ23801@atomide.com>
 <201510122225.12786@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201510122225.12786@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [151012 13:29]:
> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> >=20
> > Pali, any news on posting an updated series with the comments
> > addressed in this thread? It seems that we all pretty much agree
> > what needs to be done.
>=20
> Tony, I'm not really sure what to do. Just wrap 4 and 5 patches into=20
> CONFIG_KEXEC? Or something more?

Well for most part your patches are fine, I think there were some
minor comments on the series.

=46or the CONFIG_KEXEC dependency, we should just keep the existing
behavior and keep /proc/atags behind CONFIG_KEXEC. That's all
I believe :)

Regards,

Tony
