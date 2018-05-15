From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
Date: Mon, 14 May 2018 17:54:42 -0700
Message-ID: <20180515005442.GN98604@atomide.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
 <20180514151907.GK98604@atomide.com>
 <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180514 18:59]:
> On 14 May 2018 at 17:19, Tony Lindgren <tony@atomide.com> wrote:
> > Reverting for 8c123c14bbba ("driver core: Respect all error codes from
> > dev_pm_domain_attach()") fixes the issue for me.
> >
> > Sounds like something is missing, any ideas?
> 
> This should solve the problem:
> 
> https://patchwork.kernel.org/patch/10398597/

Thanks yeah that fixes it for me too.

Regards,

Tony
