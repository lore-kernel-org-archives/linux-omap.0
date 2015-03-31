From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 5/7] dmaengine: omap-dma: Take DMA request number from
 DT if it is available
Date: Tue, 31 Mar 2015 17:47:25 +0300
Message-ID: <551AB37D.1090104@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com> <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com> <20150327202446.GB4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150327202446.GB4027@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, tony@atomide.com, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 03/27/2015 10:24 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 27, 2015 at 02:26:51PM +0200, Peter Ujfalusi wrote:
>> +	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
>> +						       "dma-requests",
>> +						       &od->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing dma-requests property, using %u.\n",
>> +			 OMAP_SDMA_REQUESTS);
>> +		od->dma_requests =3D OMAP_SDMA_REQUESTS;
>> +	}
>=20
> Are all OMAPs including OMAP1 being converted to DT?  If not, don't
> introduce noisy printks for which a platform can't do anything about.
> Think about this please - if there's no of_node, then why complain
> about a missing OF property?

Yes, you are perfectly right on this. Will fix it up.

Thanks,
P=E9ter
