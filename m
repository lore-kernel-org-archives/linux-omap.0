From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
Date: Thu, 10 Jan 2019 08:44:54 -0800
Message-ID: <20190110164454.GB5544@atomide.com>
References: <20190110095125.GA4491@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110095125.GA4491@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [190110 09:51]:
> pm_runtime_autosuspend_expiration calls ktime_get even when
> its returned value may be unused. Therefore get current time
> later and remove gotos while there.

Acked-by: Tony Lindgren <tony@atomide.com>
