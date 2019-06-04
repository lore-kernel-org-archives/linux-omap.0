From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue, 4 Jun 2019 10:06:58 +0200
Message-ID: <CAJKOXPcY8w7CVkwGWwhssPtz8=tgffzRoAN8-4SMSTYk2_yKEg@mail.gmail.com>
References: <1559634833-19980-1-git-send-email-krzk@kernel.org>
 <CAMuHMdV0RNdB3_n7J0FWfhUTvzq4390HVsuzxXhexZ_zX-+nvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdV0RNdB3_n7J0FWfhUTvzq4390HVsuzxXhexZ_zX-+nvg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Mans Rullgard <mans@mansr.com>, linux-aspeed@lists.ozlabs.org, Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaro Koskinen <aaro.koskinen@iki.fi>, Gregory Clement <gregory.clement@bootlin.com>, Russell King <linux@armlinux.org.uk>, Ludovic Desroches <ludovic.desroches@microchip.com>, arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Gonzalez <marc.w.gonzalez@free.fr>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On Tue, 4 Jun 2019 at 09:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Jun 4, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Remove the CONFIG_UEVENT_HELPER_PATH because:
> > 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
> >    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
> >    made default to 'n',
> > 2. It is not recommended (help message: "This should not be used today
> >    [...] creates a high system load") and was kept only for ancient
> >    userland,
> > 3. Certain userland specifically requests it to be disabled (systemd
> >    README: "Legacy hotplug slows down the system and confuses udev").
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> >  arch/arm/configs/proceq_vf_bck_defconfig  | 255 +++++++++++++++++++++++++++
> >  arch/arm/configs/proceq_vf_crc_defconfig  | 278 ++++++++++++++++++++++++++++++
>
> These look like unrelated changes? Please drop.

Ooops, indeed. Thanks for spotting them.

Best regards,
Krzysztof
