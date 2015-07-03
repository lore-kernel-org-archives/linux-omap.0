From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Fri, 3 Jul 2015 17:10:46 +0300
Message-ID: <559697E6.5000803@ti.com>
References: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
 <5593DFF6.4090100@ti.com> <20150702155614.GV3246@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150702155614.GV3246@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On 07/02/2015 06:56 PM, Vinod Koul wrote:
> On Wed, Jul 01, 2015 at 03:41:26PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> On 06/08/2015 04:22 PM, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> Changes since v01:
>>> - Drop change in compatible for the crossbar driver and do the conf=
iguration
>>>   based on the DT structure.
>>>
>>> The ti-dma-crossbar driver in it's current form can work when it is=
 used with
>>> sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eD=
MA available.
>>> The sDMA driver expects to get the DMA request line with offset 1. =
The eDMA
>>> stack does not need the offset.
>>> The crosbbar itself is identical for sDMA and eDMA.
>>> At probe time the driver will do a match to figure out which dma en=
gine it is
>>> connected to and based on that information it will configure the of=
fset needed
>>> by the DMA driver.
>>
>> Gentle ping, it has been almost a month ago this series has been sen=
t.
> Sorry I seem to have missed this series. I relooked at this and it lo=
oks
> fine. I will apply it once rc1 is out. If it needs rebase please rese=
nd

No problem,
the patch still applies cleanly.

Thanks,
P=E9ter
