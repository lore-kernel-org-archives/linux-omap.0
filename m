From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] dmaengine: core: Introduce new, universal API to request a channel
Date: Thu, 03 Dec 2015 16:45:38 +0100
Message-ID: <4696298.Uj40YldTVN@wuerfel>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com> <6922343.04ZpTXZq7O@wuerfel> <566062E7.2020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566062E7.2020705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thursday 03 December 2015 17:42:31 Peter Ujfalusi wrote:
> > 
> >> +       if (chan) {
> >> +               /* Valid channel found */
> >> +               if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> >> +                       return chan;
> >> +
> >> +               pr_warn("%s: %s DMA request failed, falling back to legacy\n",
> >> +                       __func__, dev->of_node ? "OF" : "ACPI");
> >> +       }
> > 
> > Maybe print the error code as well?
> 
> Or remove the print altogether?
> In a healthy system we will either get the channel or the EPROBE_DEFER, in
> case of the platforms where the DT lookup does not work we expect errors and
> it is 'normal'.
> I think if we fail via DT/ACPI and we fail with legacy also then the client
> driver will say something about it anyways, or deal with it as it see fits.
> 

Right, that works too. It took me a while to figure out that we only get
there on systems that have ACPI or DT enabled for a particular device,
but where the normal method failed, rather than also systems with traditional
board files. Without the pr_warn, I would not have needed to think about
this ;-)

	Arnd
