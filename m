From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am43xx: Enable dual-role mode for USB1
Date: Tue, 20 Mar 2018 07:26:23 -0700
Message-ID: <20180320142623.GV5799@atomide.com>
References: <1521198703-27352-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521198703-27352-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180316 04:12]:
> USB1 port is micro-AB type and can function as peripheral
> as well as host. Enable dual-role mode for USB1.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Tony,
> 
> The USB driver side patches are already in Felipe's next branch.

Thanks applying into omap-for-v4.17/dt.

Regards,

Tony
