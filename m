From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 15/23] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable unaligned access
Date: Wed, 22 Mar 2017 20:07:18 +0530
Message-ID: <a3b44129-38b5-fb19-c931-108079b0c382@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
 <20170313142259.25397-16-kishon@ti.com>
 <20170320214316.yah5cvfdabiceywf@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170320214316.yah5cvfdabiceywf@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hch@infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On Tuesday 21 March 2017 03:13 AM, Rob Herring wrote:
> On Mon, Mar 13, 2017 at 07:52:51PM +0530, Kishon Vijay Abraham I wrote:
>> Update device tree binding documentation of TI's dra7xx PCI
>> controller to include property for enabling unaligned mem access.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 190828a5f32a..b69dd7dbd29e 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -39,6 +39,11 @@ DEVICE MODE
>>   - interrupts : one interrupt entries must be specified for main interrupt.
>>   - num-ib-windows : number of inbound address translation windows
>>   - num-ob-windows : number of outbound address translation windows
>> + - ti,syscon-unaligned-access: phandle to the syscon dt node. The 1st argument
>> +			       should contain the register offset within syscon
>> +			       and the 2nd argument should contain the bit field
>> +			       for setting the bit to enable unaligned
>> +			       access.
> 
> This should be setup by the firmware/bootloader or some platform code. 
> Why does the PCI host need to configure this?

That would create a dependency between the bootloader and kernel which is
usually avoided in platforms like dra7xx.

Thanks
Kishon
