From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support for configuring dsp iommus
	on DRA7xx
Date: Thu, 23 Jul 2015 00:24:56 -0700
Message-ID: <20150723072455.GC16878@atomide.com>
References: <1437522936-19758-1-git-send-email-s-anna@ti.com>
	<1437522936-19758-3-git-send-email-s-anna@ti.com>
	<20150722052600.GF17550@atomide.com> <55AFC34E.4000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55AFC34E.4000603-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [150722 09:25]:
> On 07/22/2015 12:26 AM, Tony Lindgren wrote:
> > 
> > I don't like using syscon for tinkering directly with SoC registers.
> 
> This is not a SoC-level register, but a register within a sub-module of
> the DSP processor sub-system. The DSP_SYSTEM sub-module in general is
> described in Section 5.3.3 of the TRM [1], and it implements different
> functionalities like the PRCM handshaking, wakeup logic and DSP
> subsystem top-level configuration. It is a module present within the DSP
> processor sub-system, so can only be accessed when the sub-system is
> clocked and the appropriate reset is released.

OK so if it's specific to the DSP driver along the lines of sysc and
syss registers.

Typically we handle these registers by mapping them to the PM runtime
functions for the interconnect so we can reset and idle the hardware
modules even if there is no driver, see for example
omap54xx_mmu_dsp_hwmod.
 
> > We should use some Linux generic framework for configuring these
> > bits to avoid nasty dependencies between various hardware modules
> > on the SoC.
> > 
> > What does DSP_SYS_MMU_CONFIG register do? It seems it's probably
> > a regulator or a gate clock? If so, it should be set up as a
> > regulator or a clock and then the omap-iommu driver can just
> > use regulator or clcok framework to request the resource.
> 
> No, its neither. It is a control bit that dictates whether the
> processor/EDMA addresses go through the respective MMU or not. The
> register currently has 4 bits (bit 0 in each nibble), one each for
> enabling each MMU and requesting an MMU abort on each. The MMU
> integration and enablement notes are detailed in Section 5.3.6 of the
> TRM [1], and the DSP_SYS_MMU_CONFIG register layout is in Table 5-28
> (Page 1641).

OK yeah seems like it should be handled by the DSP driver during
probe after doing pm_runtime_get. Then the driver can configure
things like IOMMU and load firmware. Or am I missing something here?

Regards,

Tony

 
> [1] http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
