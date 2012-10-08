From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: rx51: Fix a section mismatch warn
Date: Mon, 8 Oct 2012 14:07:59 -0700
Message-ID: <20121008210759.GG13011@atomide.com>
References: <1347460624-25259-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347460624-25259-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [120912 07:38]:
> rx51_si4713_dev is referenced only from rx51_init_si4713.
> So the memory for rx51_si4713_dev can be safely freed after init.
> Also it references rx51_si4713_board_info which is __initdata_or_module.

Thanks applying into fixes.

Tony
