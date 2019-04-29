From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] soc: ti: pm33xx: Add a print while entering RTC only
 mode with DDR in self-refresh
Date: Mon, 29 Apr 2019 11:42:45 -0700
Message-ID: <20190429184245.GG8007@atomide.com>
References: <20190429044435.19315-1-j-keerthy@ti.com>
 <b862e2c4-781c-ced9-3a6f-b0095562732a@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b862e2c4-781c-ced9-3a6f-b0095562732a@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* santosh.shilimkar@oracle.com <santosh.shilimkar@oracle.com> [190429 18:40]:
> On 4/28/19 9:44 PM, Keerthy wrote:
> > Currently there is no way to distinguish if the SoC entered DS0
> > mode or the RTC only mode. Hence add a print before entering
> > the RTC only mode.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
> Tony, Am assuming you will queue this up ?

OK yeah I'll queue it.

Thanks,

Tony
