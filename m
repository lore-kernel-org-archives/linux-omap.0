From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: dra72x: Disable usb4_tm target module
Date: Mon, 10 Jun 2019 00:06:02 -0700
Message-ID: <20190610070602.GT5447@atomide.com>
References: <20190604061335.8264-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604061335.8264-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: robh+dt@kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190603 23:13]:
> usb4_tm is unsed on dra72 and accessing the module
> with ti,sysc is causing a boot crash hence disable its target
> module.

Thanks for testing and fixing this, applying into fixes.

Tony
