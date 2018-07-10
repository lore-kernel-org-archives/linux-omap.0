From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] clk: clk: Add functions to save/restore clock
 context en-masse
Date: Mon, 9 Jul 2018 22:56:05 -0700
Message-ID: <20180710055605.GF99251@atomide.com>
References: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, sboyd@kernel.org, linux-clk@vger.kernel.org, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180621 01:18]:
> Deep enough power saving mode can result into losing context of the clock
> registers also, and they need to be restored once coming back from the power
> saving mode. Hence add functions to save/restore clock context.

Patches 1 to 3 look good to me:

Acked-by: Tony Lindgren <tony@atomide.com>

Stephen, if no more comments, can you please set up an immutable
branch for me as otherwise the last patch might cause merge
conflicts?

Regards,

Tony
