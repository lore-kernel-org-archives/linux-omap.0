From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: dts: DRA72: switch to cpsw slave0 for ethernet
Date: Tue, 14 Jul 2015 04:08:20 -0700
Message-ID: <20150714110820.GR17550@atomide.com>
References: <1434963824-11413-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434963824-11413-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm@ti.com> [150622 02:05]:
> From: Vignesh R <vigneshr@ti.com>
> 
> On DRA72 EVM, cpsw slave1 is muxed with VIN2A, hence switch to cpsw
> slave0 for ethernet. Add gpio hog entry to pcf_gpio_21 in order to
> select cpsw slave0.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applying into omap-for-v4.3/dt thanks.

Tony
