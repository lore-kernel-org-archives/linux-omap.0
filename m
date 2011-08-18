From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 0/7] omap: iommu migration, relocation and cleanups
Date: Thu, 18 Aug 2011 13:50:46 +0300 (EEST)
Message-ID: <20110818.135046.3757848928175252.Hiroshi.DOYU@nokia.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<201108181112.55592.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201108181112.55592.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ohad@wizery.com
Cc: arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

From: ext Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/7] omap: iommu migration, relocation and cleanups
Date: Thu, 18 Aug 2011 11:12:55 +0200

> Hi Ohad,
> 
> On Thursday 18 August 2011 01:10:01 Ohad Ben-Cohen wrote:
>> 1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
>> to the dedicated iommu folder.
>> 
>> 2. Fix omap3isp appropriately so it doesn't break.
>> 
>> 3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
>> on it. The plan is eventually to remove iovmm and replace it with the
>> upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
>> it belongs there more than it belongs in the OMAP folders.
>> 
>> 4. Start cleaning up OMAP's iommu components towards the end goal, where
>>     1) omap-iommu no longer exports public API (and instead provides its
>>        entire functionality via the generic IOMMU API).
>>     2) omap-iovmm is removed.

Good migration path!

>> Changes:
>> 1. Migrate iommu, iovmm and omap3isp in a single patch for bisectibility
>> sake.
>> 2. Apply Laurent Pinchart's comments (thanks Laurent!)
> 
> You're welcome.
> 
>> 3. Rebase to 3.1-rc2
> 
> For the OMAP3 ISP driver changes,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

For the rest of omap iommu/iovmm patches, they look good:

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
