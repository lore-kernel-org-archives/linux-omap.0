From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] RX-51: Add missing max_current to
 rx51_lp5523_led_config
Date: Tue, 8 Oct 2013 11:29:45 -0700
Message-ID: <20131008182945.GI8313@atomide.com>
References: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com>
 <201309200020.58671@pali>
 <201309231450.12171@pali>
 <201309231506.37942.joerg@openmoko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309231506.37942.joerg@openmoko.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* joerg Reisenweber <joerg@openmoko.org> [130923 06:14]:
> On Mon 23 September 2013 14:50:12 Pali Roh=C3=A1r wrote:
> > Hi Tony,
> >=20
> > here is new version (v2) of patch which adding max_current values t=
o rx51
> > board data. According to joerg safe value for max_current is 100 (1=
0 mA).
> >=20
> >=20
> > RX-51: Add missing max_current to rx51_lp5523_led_config
> >=20
> > File drivers/leds/leds-lp55xx-common.c refuse to change led_current=
 sysfs
> > attribute if value is higher than max_current specified in board fi=
le. By
> > default global C variables are zero, so changing always failed. Thi=
s patch
> > adding missing max_current and setting it to max safe value 100 (10=
 mA).
=2E..
=20
> Reviewed and found logically and technically correct
> Signed-off-by: Joerg Reisenweber <joerg AT openmoko DOT org>

Thanks, I'll apply this into omap-for-v3.12/fixes as it's a
regression.

Regards,

Tony
