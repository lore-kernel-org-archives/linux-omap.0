From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date: Wed, 14 Nov 2018 10:45:22 +0200
Message-ID: <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com> <20181114003345.GV2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114003345.GV2089@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redha>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 14, 2018 at 2:34 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:
>
> > if we revert the commit then the original issue will re-surfaces. afaik
> > it was not only audio which hit the 'last driver to be probed from the
> > deferred list would never probe, unless we provoke the kernel to load
> > additional module, or remove/reload the module' issue.
>
> Right, aren't we just going to be swapping one bug for another?

Have anyone in possession of Davinchi tested most recent kernel with
this revert?

> > Do I understand correctly that in your case you have two modules
> > (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
> > the drivers returns -EPROBE_DEFER and they just spin?
>
> > If both is deferring, how this supposed to work?
>
> I'm struggling to follow the original explanation too :(

Sorry, guys, I confused a nit myself. The bug is there, but
exxplanation is not fully corrent, indeed. I'll come back with more
details later.

-- 
With Best Regards,
Andy Shevchenko
