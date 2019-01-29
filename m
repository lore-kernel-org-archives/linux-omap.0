From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Variable "reg" in function
 omap4_dsi_mux_pads() could be uninitialized
Date: Tue, 29 Jan 2019 08:54:52 -0800
Message-ID: <20190129165452.GB5720@atomide.com>
References: <20190126063221.8257-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190126063221.8257-1-yzhai003@ucr.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Yizhuo <yzhai003@ucr.edu> [190125 22:32]:
> In function omap4_dsi_mux_pads(), local variable "reg" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the later context, which
> is potentially unsafe.

Thanks applying into omap-for-v5.0/fixes-v2.

Regards,

Tony
