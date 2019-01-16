From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
Date: Wed, 16 Jan 2019 12:57:13 +0100
Message-ID: <10417091.Yigb8Rxq05@aspire.rjw.lan>
References: <20190110095125.GA4491@lenoch> <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, Ladislav Michl <ladis@linux-mips.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, January 10, 2019 7:56:19 PM CET Vincent Guittot wrote:
> On Thu, 10 Jan 2019 at 10:51, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > pm_runtime_autosuspend_expiration calls ktime_get even when
> > its returned value may be unused. Therefore get current time
> > later and remove gotos while there.
> >
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Patch applied, thanks!
