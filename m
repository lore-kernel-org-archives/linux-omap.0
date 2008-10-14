From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 1/5] HDQ Driver for OMAP2430/3430
Date: Tue, 14 Oct 2008 17:42:49 +0400
Message-ID: <20081014134249.GA5611@2ka.mipt.ru>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107AF0@dbde02.ent.ti.com> <20081010133845.8b82fac3.akpm@linux-foundation.org> <062801c92d37$3413bdd0$LocalHost@wipultra1303> <20081013085323.f8bd7efb.akpm@linux-foundation.org> <015c01c92dda$1b754340$LocalHost@wipultra1303> <20081014055002.24ff586a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752932AbYJNNl4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081014055002.24ff586a.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, gadiyar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi.

On Tue, Oct 14, 2008 at 05:50:02AM -0700, Andrew Morton (akpm@linux-foundation.org) wrote:
> I think it's reasonable to permit the driver's operations to be interrupted
> in this manner.  It's done in quite a few other places.  But the problem is
> actually *testing* it.

Why not just skipping the waiting and returning error pretending user
really sent a signal?

-- 
	Evgeniy Polyakov
