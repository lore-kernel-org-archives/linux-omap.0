From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/3] ARM: dts: Fixes for Overo/Tobi against 3.14-rc1
Date: Thu, 06 Feb 2014 09:09:47 -0800
Message-ID: <87d2j0rwv8.fsf@paris.lan>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
 (Florian Vaussard's message of "Thu, 6 Feb 2014 10:10:15 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Florian Vaussard <florian.vaussard@epfl.ch> writes:

> OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc1 [1].
> This series fixes this, by moving model-agnostic DT into a common dtsi file,
> and creating model-specific DT files:
>
> - omap3-overo-tobi.dts -> older OMAP35xx Overo
> - omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo
>
> People will have to use the right Overo / expansion board combination.
>
> (Patch 2 in an unrelated fix that was waiting in my queue.)
>
> omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
> tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
> mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
> a missing errata.

And I tested with my 35xx/Overo with omap3-overo-tobi.dts and my
37xx/Overo STORM with omap3-overo-storm-tobi.dts and they're both
working.

Tested-by: Kevin Hilman <khilman@linaro.org>

Tony, with your ack, I can apply these directly to arm-soc/fixes.

Florian, thanks for the fixes.

Kevin
