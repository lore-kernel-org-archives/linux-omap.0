From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: dra7/dra7xx-clocks: ATL related changes
Date: Mon, 16 Jun 2014 07:13:32 -0700
Message-ID: <20140616141331.GK17845@atomide.com>
References: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
 <1399458048-28213-5-git-send-email-peter.ujfalusi@ti.com>
 <539EF8C6.1080207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <539EF8C6.1080207@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@linaro.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140616 07:03]:
> On 05/07/2014 01:20 PM, Peter Ujfalusi wrote:
> >Modify the clock nodes for the ATL clocks to use the ATL clock driver to
> >handle them.
> >
> >Add the ATL device node at the same time for DRA7.
> >
> >Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> This patch missed the merge window due to long dependency chain, however
> Tony promised to pull this with rc-fixes. So, for that purpose:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks applying into omap-for-v3.16/fixes.

Regards,

Tony
