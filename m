From: Tony Lindgren <tony@atomide.com>
Subject: Re: rx51: support for lis3lv02d accelerometer
Date: Tue, 8 May 2012 17:07:34 -0700
Message-ID: <20120509000734.GZ5088@atomide.com>
References: <1621273.5PNGJFOirm@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1621273.5PNGJFOirm@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>, Sebastian Reichel <sre@debian.org>, Felipe Contreras <felipe.contreras@nokia.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [120504 08:41]:
> Hi!
>=20
> Upstream linux kernel has already driver for lis3lv02d accelerometer
> in drivers/misc/lis3lv02d. So now can be added also platform support
> for nokia rx51. Patch exists for long time in meego obs repository:
> https://build.pub.meego.com/package/view_file?file=3Dlinux-2.6-omap-r=
x51-Platform-support-for-lis3lv02d-acceleromet.patch&package=3Dkernel-a=
daptation-n900&project=3DCE%3AAdaptation%3AN900
>=20
> It is possible to include this patch to upstream kernel?

Thanks, applying into board branch with From: Ameya as in the
link above.

Regards,

Tony
