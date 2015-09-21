From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] mfd: twl6040: Fix deferred probe handling for clk32k
Date: Mon, 21 Sep 2015 06:59:56 -0700
Message-ID: <20150921135956.GB23801@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-2-git-send-email-tony@atomide.com>
 <55FFD422.2080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55FFD422.2080506@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150921 02:59]:
> On 09/18/2015 07:29 PM, Tony Lindgren wrote:
> > Commit 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
> > added clock handling for the 32k clock from palmas-clk. However, that
> > patch did not consider a typical situation where twl6040 is built-in,
> > and palmas-clk is a loadable module like we have in omap2plus_defconfig.
> > 
> > If palmas-clk is not loaded before twl6040 probes, we will get a
> > "clk32k is not handled" warning during booting. This means that any
> > drivers relying on this clock will mysteriously fail, including
> > omap5-uevm WLAN and audio.
> > 
> > Note that for WLAN, we probably should also eventually get
> > the clk32kgaudio for MMC3 directly as that's shared between
> > audio and WLAN SDIO at least for omap5-uevm. It seems the
> > WLAN chip cannot get it as otherwise MMC3 won't get properly
> > probed.
> 
> While this is going to 'fix' the WLAN because currently the twl6040 is powered
> on all the time (32k clock is enabled). My plan is to finally implement the
> power state handling for the twl6040, which means that w/o audio activity the
> twl6040 will be turned off. This will imply that any clock which is only used
> by twl6040 will be off as well.
> The proper solution would be to add clock handling to the WLAN driver stack.

Yes the place to request this clock is using pwrseq_simple.c for MMC3.
It seems there are some issues with deferred probe handling there too
though.

Regards,

Tony
