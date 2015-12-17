From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/19] ARM: dts: omap: replace legacy *,wakeup property
 with wakeup-source
Date: Thu, 17 Dec 2015 09:58:36 -0800
Message-ID: <20151217175835.GV23396@atomide.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
 <567041AD.1020702@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <567041AD.1020702@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [151215 08:37]:
>=20
>=20
> On 21/10/15 11:10, Sudeep Holla wrote:
> >Though the keyboard and other driver will continue to support the le=
gacy
> >"gpio-key,wakeup", "linux,wakeup" boolean property to enable the wak=
eup
> >source, "wakeup-source" is the new standard binding.
> >
> >This patch replaces all the legacy wakeup properties with the unifie=
d
> >"wakeup-source" property in order to avoid any futher copy-paste
> >duplication.
> >
> >Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
> >Cc: Tony Lindgren <tony@atomide.com>
>=20
> Ping, do you prefer taking via your tree or should I send to armsoc
> directly ?

Applying this one too thanks.

Tony
