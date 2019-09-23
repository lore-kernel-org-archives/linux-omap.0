From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable DRM_TI_TFP410
Date: Mon, 23 Sep 2019 11:23:20 -0700
Message-ID: <20190923182320.GB5610@atomide.com>
References: <20190911174647.29721-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190911174647.29721-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, adam.ford@logicpd.com, sre@kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [190911 10:47]:
> The TFP410 driver was removed but the replacement driver was
> never enabled.  This patch enableds the DRM_TI_TFP410
> 
> Fixes: be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")

Applying into fixes thanks.

Tony
