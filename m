From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Thu, 27 Aug 2015 13:51:04 -0700
Message-ID: <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.31980.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150730001124.4012.31980.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 29, 2015 at 5:11 PM, NeilBrown <neil@brown.name> wrote:
> Now that twl4030_bci_probe can safely return -EPROBE_DEFER,
> do so when devm_usb_get_phy_by_node returns that error.
>
> Signed-off-by: NeilBrown <neil@brown.name>

This patch has hit linux-next in the form of coommit 3fc3895e4fe1
(twl4030_charger: correctly handle -EPROBE_DEFER from
devm_usb_get_phy_by_node) and kernelci.org found a regression on
omap3-beagle-xm[1].  Bisecting[2] this boot failure pointed at this
commit, and I verified that reverting it on top of next-20150827 gets
the board booting again.  I haven't debugged any further.

Kevin

[1] http://storage.kernelci.org/next/next-20150827/arm-omap2plus_defconfig/lab-khilman/boot-omap3-beagle-xm.html
[2] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/88/console
