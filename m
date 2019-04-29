From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] soc: ti: pm33xx: Add a print while entering RTC only mode
 with DDR in self-refresh
Date: Mon, 29 Apr 2019 11:39:53 -0700
Message-ID: <b862e2c4-781c-ced9-3a6f-b0095562732a@oracle.com>
References: <20190429044435.19315-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429044435.19315-1-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On 4/28/19 9:44 PM, Keerthy wrote:
> Currently there is no way to distinguish if the SoC entered DS0
> mode or the RTC only mode. Hence add a print before entering
> the RTC only mode.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Tony, Am assuming you will queue this up ?
