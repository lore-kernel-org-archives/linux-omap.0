From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap5: Fix dual-role mode on Super-Speed port
Date: Fri, 7 Dec 2018 08:25:37 -0800
Message-ID: <20181207162537.GO6707@atomide.com>
References: <1544030864-22842-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544030864-22842-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, hns@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181205 17:28]:
> OMAP5's Super-Speed USB port has a software mailbox register
> that needs to be fed with VBUS and ID events from an external
> VBUS/ID comparator.
> 
> Without this, Host role will not work correctly.
> 
> Fixes: 656c1a65ab55 ("ARM: dts: omap5: enable OTG role for DWC3 controller")
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> 
> Tony,
> 
> Please included this in v4.20-rc cycle. Thanks.

Applying into omap-for-v4.20/fixes.

Thanks,

Tony
