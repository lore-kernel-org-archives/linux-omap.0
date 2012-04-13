From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all
 DSS L3 slave interfaces
Date: Fri, 13 Apr 2012 10:43:22 +0200
Message-ID: <4F87E72A.2050104@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
 <1334304116-18872-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334304116-18872-3-git-send-email-archit@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Archit Taneja <archit@ti.com>
Cc: paul@pwsan.com, tomi.valkeinen@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 4/13/2012 10:01 AM, Archit Taneja wrote:
> The clock for all DSS L3 slave interfaces had been recently changed to
> "dss_fck" from "l3_div_ck". "dss_fck" is an optional clock in DSS clock domain
> which can't autoidle when enabled.
>
> Add OCPIF_SWSUP_IDLE flag to all the L3 slave interfaces used by DSS hwmods so
> that clock is explicitly enabled and disabled by software. Without this,
> "dss_fck" would be left as enabled and the OMAP4 device won't idle even when
> DSS is not in use.

Yeah, that was done on purpose with Tomi knowning well that limitation.

The issue was mainly due to the lack of proper parent / child 
relationship between the DSS (the whole subsystem) and the DSS children 
at that time.

I think that Tomi posted a series to fix that for 3.4. So if we ensure 
that every DSS IPs are children of the DSS, then pm_runtime will always 
ensure that the DSS will be enabled each time a submodule is used.

So the right fix is to put back the proper iclk (l3_div) to the DSS 
instead of the dss_fck.

The current OMAP4 DSS clock setup is clearly a hack that should be fixed.

Regards,
Benoit
