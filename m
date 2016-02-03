From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 3 Feb 2016 11:25:23 +0100
Message-ID: <CAPDyKFqSVZffQ7WNZqn9qSRibsCgG2rY26z_97agL+LhQRVGcg@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
	<Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
	<20160202030533.GT19432@atomide.com>
	<CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
	<CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
	<20160202163536.GU19432@atomide.com>
	<CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
	<20160202234145.GC19432@atomide.com>
	<CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>
> I don't see the problem, but of course you know omap for better than I do.
>
> So if you are concerned about this, perhaps adding a dev_dbg print
> when the omap hwmod's ->runtime_suspend() callback returns zero could

/s/runtime_suspend/runtime_resume

Kind regards
Uffe
