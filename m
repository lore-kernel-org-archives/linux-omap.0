From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/4] MFD: Palmas: Add TPS659038 PMIC support
Date: Mon, 24 Jun 2013 13:43:22 +0200
Message-ID: <20130624114322.GB30838@zurbaran>
References: <1371726316-10078-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371726316-10078-1-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jun 20, 2013 at 04:35:16PM +0530, J Keerthy wrote:
> The Patch adds TPS659038 PMIC support in the palmas mfd driver.
> The TPS659038 has almost the same registers as of the earlier
> supported variants of PALMAS family such as the TWL6035.
> 
> The critical differences between TPS659038 and TWL6035 being:
> 
> 1) TPS659038 has nothing related to battery charging and back up battery stuff.
> 2) TPS659038 does not have does not have SMPS10(Boost) step up convertor.
> 3) TPS659038 does not have Battery detection and anything related to battery.
> 4) SD card detection, Battery presence detection, Vibrator, USB OTG are missing
>    when compared to TWL6035.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/palmas.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
