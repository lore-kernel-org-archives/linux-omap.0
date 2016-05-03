From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
Date: Tue, 3 May 2016 09:50:04 +0530
Message-ID: <572826F4.3080500@ti.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jay.schroeder@garmin.com
List-Id: linux-omap@vger.kernel.org



On Monday 02 May 2016 10:42 PM, J.D. Schroeder wrote:
> This series of patches fixes several discrepancies between the
> AM57/DRA7 clock tree description and the actual hardware behavior and
> frequencies. With these changes a more complete picture of the clock
> tree is represented for a few of the clocks and their resulting
> frequencies.

Tested on my DRA74-evm.

Tested-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> v2 Changes:
> * Rebased on linux-next as requested by Tony Lindgren
> * Eliminated previous patch 2 as another change fixing the same thing
>   was merged in eea08802f586acd6aef377d1b4a541821013cc0b
> * Added to the commit message in patch 2 to clarify the source of the
>   clock being internal to the processor
> * Added a new patch 3 to fix a new warning introduced by
>   eea08802f586acd6aef377d1b4a541821013cc0b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
