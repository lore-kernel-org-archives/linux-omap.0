From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] DMA: let filter functions of of_dma_simple_xlate possible
 check of_node
Date: Thu, 22 Aug 2013 14:18:27 -0600
Message-ID: <52167213.6090604@wwwdotorg.org>
References: <1375408800-11789-1-git-send-email-rizhao@nvidia.com> <20130822051904.GA2685@rizhao-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130822051904.GA2685@rizhao-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "djbw@fb.com" <djbw@fb.com>
List-Id: linux-omap@vger.kernel.org

On 08/21/2013 11:19 PM, Richard Zhao wrote:
> On Fri, Aug 02, 2013 at 10:00:00AM +0800, Richard Zhao wrote:
>> pass of_phandle_args dma_spec to dma_request_channel in of_dma_simple_xlate,
>> so the filter function could access of_node in of_phandle_args.
>>
>> It also remove restriction of #dma-cells has to be one.
>>
>> Signed-off-by: Richard Zhao <rizhao@nvidia.com>
>> ---
>>  drivers/dma/edma.c     |  7 +++++--
>>  drivers/dma/of-dma.c   | 10 ++++------
>>  drivers/dma/omap-dma.c |  6 ++++--
>>  3 files changed, 13 insertions(+), 10 deletions(-)
>>
> 
> Hi Vinod,
> 
> Can you please pick up this change?
> 
> Hi Stephen,
> 
> Can you please give a ack or reviewed-by etc?

Hmm. Looking at the patch, I'm not sure it's right.

This patch simply passes all the specfier args to the filter function,
and the code to check the equality of the of_node to the filter args is
still duplicated in each DMA driver. Instead, the DMA core should be
implementing the equality check, and only even calling the
driver-specific filter function for devices where the client's phandle
matches the DMA providing device's of_node handle.
