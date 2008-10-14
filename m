From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 1/5] HDQ Driver for OMAP2430/3430
Date: Tue, 14 Oct 2008 18:55:34 +0400
Message-ID: <20081014145534.GA22732@2ka.mipt.ru>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107AF0@dbde02.ent.ti.com> <20081010133845.8b82fac3.akpm@linux-foundation.org> <062801c92d37$3413bdd0$LocalHost@wipultra1303> <20081013085323.f8bd7efb.akpm@linux-foundation.org> <015c01c92dda$1b754340$LocalHost@wipultra1303> <20081014055002.24ff586a.akpm@linux-foundation.org> <20081014134249.GA5611@2ka.mipt.ru> <20081014073058.e5d972e6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752967AbYJNOx7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081014073058.e5d972e6.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: madhu.cr@ti.com, gadiyar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 14, 2008 at 07:30:58AM -0700, Andrew Morton (akpm@linux-foundation.org) wrote:
> > Why not just skipping the waiting and returning error pretending user
> > really sent a signal?
> 
> Better than nothing, but because signal_pending() isn't actually true,
> upper layers wil behave differently.

If they check... 

For example omap_hdq_break() can be interrupted and omap_hdq_probe()
does not check its return value.

-- 
	Evgeniy Polyakov
