From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap2-clk: Add missing lcdc clock definition
Date: Tue, 30 Oct 2012 23:26:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210302324530.6152@utopia.booyaka.com>
References: <1351698962-3923-1-git-send-email-panto@antoniou-consulting.com> <20121030181837.GM11908@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121030181837.GM11908@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, hvaibhav@ti.com
List-Id: linux-omap@vger.kernel.org

+ Vaibhav Hiremath

On Tue, 30 Oct 2012, Tony Lindgren wrote:

> * Pantelis Antoniou <panto@antoniou-consulting.com> [121030 11:04]:
> > Looks like the lcdc clock definition got dropped.
> > It is required for the LCD controller to work. Reintroduce.
> 
> This looks like a regression, can you also add the commit
> causing it?

Looks like probably a new "feature," in that this clock didn't exist in 
the original check-in.  Would be good to get Vaibhav's opinion on this; 
also the common clock patches will need to be updated.


- Paul
