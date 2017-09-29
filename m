From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] Update TMDSEVM3530 support for omap3-evm
Date: Fri, 29 Sep 2017 09:20:59 -0700
Message-ID: <20170929162059.GI4394@atomide.com>
References: <20170912034659.13184-1-woods.technical@gmail.com>
 <20170912234824.6706-1-woods.technical@gmail.com>
 <20170929020347.GA30051@exodus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170929020347.GA30051@exodus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Derald D. Woods <woods.technical@gmail.com> [170928 19:05]:
> On Tue, Sep 12, 2017 at 06:48:20PM -0500, Derald D. Woods wrote:
> > This patch set allows TMDSEVM3530(omap3-evm.dts) to boot using common
> > processor module data that is shared with 'omap3-evm-37xx.dts'. A new
> > common file for processor module data is introduced to help facilitate
> > the updated OMAP3530 support.
> > 
> 
> 
> Are there any further concerns after v3?

Looks godo to me thanks. And also still boots on the 37xx-evm,
so applying into omap-for-v4.15/dt.

Regards,

Tony
