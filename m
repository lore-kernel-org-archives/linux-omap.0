From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add minimal support for motorola droid 4 xt894
Date: Sat, 12 Nov 2016 09:01:53 -0800
Message-ID: <20161112170152.GO7138@atomide.com>
References: <20161112165759.17316-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161112165759.17316-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Marcel Partap <mpartap@gmx.net>, linux-arm-kernel@lists.infradead.org, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161112 08:58]:
> Let's add minimal support for droid 4 with MMC and WLAN working.
> It can be booted with appended dtb using kexec to a state where
> MMC and WLAN work with currently no support for it's PMIC or
> display.
> 
> Note that we are currently using fixed regulators as we don't
> have support for it's cpcap PMIC. I'll be posting regmap_spi
> based minimal cpcap patches later on for USB and the debug
> UART on droid 4 multiplexed with the USB connector.

I also posted some notes on the UART wiring at [0].

Regards,

Tony


[0] http://muru.com/linux/d4/
