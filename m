From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date: Mon, 25 Feb 2019 15:26:00 -0600
Message-ID: <20190225212600.GA12346@bogus>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549295637-24890-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 04, 2019 at 05:53:55PM +0200, Roger Quadros wrote:
> The PRUSS module has a SYSCFG which is unique. Add
> support for it.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/bus/ti-sysc.h     | 11 -----

Did you intend to remove what you just added?

>  include/linux/platform_data/ti-sysc.h |  1 +
>  3 files changed, 78 insertions(+), 11 deletions(-)
