From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume
 support
Date: Wed, 29 Mar 2017 10:13:14 -0700
Message-ID: <20170329171314.GD10760@atomide.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
> Hi,
> This series contains the remaining code to enable suspend to mem and standby on
> am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].

Looks good to me in general. To remove the dependency, can some
of this be merged separately without breaking things before [1]?
Maybe by disabling some of the PM states until [1] is in place?

Regards,

Tony
