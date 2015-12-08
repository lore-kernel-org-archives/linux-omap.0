From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] clk: ti: Add few dm814x clock aliases
Date: Tue, 8 Dec 2015 12:11:37 -0800
Message-ID: <20151208201136.GZ23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-3-git-send-email-tony@atomide.com>
 <20151208165732.GY23396@atomide.com>
 <56672ED0.4050405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56672ED0.4050405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151208 11:25]:
> On 12/08/2015 06:57 PM, Tony Lindgren wrote:
> >
> >Anybody from the clock department care to ack this one?
> 
> Sorry been rather busy lately...
>
> >I'd like to
> >get this series into Linux next as it fixes some some issues.
> 
> Yeah looks good to me, don't have access to dm814x so can't test.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks.

> Are you planning to push this via omap tree if this is critical for you?

Yes this series needs to be merged in certain order to keep t410
booting. Should not conflict with anything else AFAIK.

Regards,

Tony
