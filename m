From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC PATCH] ARM: OMAP3630: Add generic machine descriptor
Date: Fri, 20 Sep 2013 09:19:02 -0700
Message-ID: <CAOesGMj6G7LeYUJsGpZHxKOjiNrk+1U55QFqcQyTb6_Co+n4zQ@mail.gmail.com>
References: <1379693332-10585-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379693332-10585-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 20, 2013 at 9:08 AM, Nishanth Menon <nm@ti.com> wrote:
> An alternative approach may be to (for all SoCs):
> 1. define every SoC entry - ti,omap3430 ti,omap3630...
> 2. have a generic omap3_init which uses "if (of_machine_is_compatible("ti,omap3630"))"
> to invoke the appropriate omap3xxx_init_early.

Yes, this would be better, but you can do add a DT_MACHINE as in this
patch but have ti,omap3630 as the dt_compat table. Then there's no
need to add runtime checks.


-Olof
