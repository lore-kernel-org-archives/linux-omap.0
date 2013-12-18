From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
Date: Wed, 18 Dec 2013 22:40:58 +0530
Message-ID: <52B1D722.3040500@ti.com>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <52B1D4C7.6030004@ti.com> <20131218170818.GR4970@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131218170818.GR4970@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Markus Pargmann <mpa@pengutronix.de>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 December 2013 10:38 PM, Felipe Balbi wrote:
> On Wed, Dec 18, 2013 at 10:30:55PM +0530, Mugunthan V N wrote:
>> On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
>>> Hi,
>>>
>>> This series introduces a driver to read and use the MACIDs stored in the am335x
>>> control module. These are read-only registers for a unique MACID. At the moment
>>> the MACIDs are generated randomly or they are set by the bootloader.
>>>
>>> A device node is added in am33xx dtsi and used by the cpsw slaves in the bone
>>> board files.
>>>
>>> Regards,
>>>
>>> Markus
>>>
>>>
>>> Markus Pargmann (6):
>>>   DT doc: net: cpsw mac-address is optional
>>>   net: cpsw: header, Add missing include
>>>   net: cpsw: Add control-module macid driver
>>>   net: cpsw: Use cpsw-ctrl-macid driver
>>>   arm: dts: am33xx, Add device node for cpsw-ctrl-macid
>>>   arm: dts: am335x beagle bone use processor macids
>>>
>>>  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
>>>  Documentation/devicetree/bindings/net/cpsw.txt     |   7 +-
>>>  arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
>>>  arch/arm/boot/dts/am335x-boneblack.dts             |   8 ++
>>>  arch/arm/boot/dts/am33xx.dtsi                      |   7 ++
>>>  drivers/net/ethernet/ti/Kconfig                    |   8 ++
>>>  drivers/net/ethernet/ti/Makefile                   |   1 +
>>>  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
>>>  drivers/net/ethernet/ti/cpsw.c                     |  18 ++-
>>>  drivers/net/ethernet/ti/cpsw.h                     |   3 +
>>>  10 files changed, 224 insertions(+), 5 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
>>>  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
>>>
>> Mac ID is to be filled by U-Boot and this kind of approach is already
>> rejected in linux-omap list.
>>
>> If proper ethaddr/eth*addr is populated in U-boot environment variable
>> then mac-address dt property in ethernet* device nodes will be populated
>> before boot kernel in U-boot. So I don't think this patch series is
>> required.
> but will u-boot read MACID from control module ?
>
Yes, U-Boot will read the MACID from control module and if a customer
wants to have his own MACID, U-boot ENV variable ethaddr/eth1addr must
be updated.

Regards
Mugunthan V N
