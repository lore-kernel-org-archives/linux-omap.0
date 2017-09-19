From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry
Date: Tue, 19 Sep 2017 10:54:10 -0700
Message-ID: <20170919175409.GE5024@atomide.com>
References: <20170914193007.7246-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914193007.7246-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170914 12:30]:
> From: Yogesh Siraswar <yogeshs@ti.com>
> 
> On am438x EPOS boards there is only one ethernet port, remove extra
> port definition.
> 
> This boot log warnings during PHY detection.

OK applying into omap-for-v4.13/fixes.

Thanks,

Tony
