From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 00/13]  ARM/DT: edma: IP configuration from hardware
 and cleanups
Date: Mon, 19 May 2014 19:53:13 +0300
Message-ID: <537A36F9.40004@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com> <537A01F2.2090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <537A01F2.2090107@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, joelf@ti.com, arnd@arndb.de
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 05/19/2014 04:06 PM, Sekhar Nori wrote:
> On Friday 16 May 2014 05:47 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v2:
>> - Comments from Sekhar and Arnd has been addressed best as I could.
>> - Use the CCCFG information in all cases instead of pdata provided i=
nformation
>> - To achieve this I needed to do a bit more cleanup in this series
>> - In the documentation patch, retrain the old properties for referen=
ce
>> - Cleanups in the old davinci board files and removing edma_soc_info=
 members
>>
>> Changes sicne v1:
>> - added missing patch to remove the memset from edma_of_parse_dt()
>>
>> We are requesting redundant information via DT for the driver since =
the very same
>> data is available in the HW: by reading and decoding the content of =
CCCFG
>> register we can get:
>> Number of channels: NUM_DMACH
>> Number of regions: NUM_REGN
>> Number of slots (PaRAM sets): NUM_PAENTRY
>> Number of TC/EQ: NUM_EVQUE
>>
>> So these does not need to be provided by the DT binding.
>>
>> The driver will no longer look for these properties from DT and they=
 can be
>> removed from the binding documentation and from the dtsi files as we=
ll.
>> The change will not introduce regression when new kernel is booted u=
sing older
>> DTB (since we just ignore the mentioned properties).
>=20
> Applied all patches and pushed to branch v3.16/edma of:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.g=
it
>=20
> Since the patches did not apply cleanly, please verify. I tested on
> DA850 EVM using MMC/SD as EDMA user.

The patches in this series looks OK in your branch.
However I can not find the following commits in there, which I have in =
linux-next:
c689a7b79c28 Merge remote-tracking branch 'slave-dma/next'
cdae05a0f0f7 dmaengine: edma: Make reading the position of active chann=
els work
cf7eb979116c ARM: common: edma: Fix xbar mapping
232b223d8281 dmaengine: edma: Set DMA_CYCLIC capability flag
7cf2af90cd51 arm: common: edma: Save the number of event queues/TCs

They might come via different route...

>=20
> I will wait to get acks from DT maintainers before sending to ARM-SoC=
=2E
>=20
> Thanks,
> Sekhar
>=20


Thanks,
P=E9ter
