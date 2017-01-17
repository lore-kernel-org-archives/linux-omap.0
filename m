From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH 1/2] ARM: dts: dra7-evm: increase QSPI SPL partition size
Date: Tue, 17 Jan 2017 08:14:04 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF6C0A8C367@DBDE04.ent.ti.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
 <1484311234-21978-2-git-send-email-ravibabu@ti.com>
 <20170113181239.GC2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113181239.GC2630@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "nsekhar@list.ti.com" <nsekhar@list.ti.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony

>* Ravi Babu <ravibabu@ti.com> [170113 04:41]:
>> The SPL size for DRA74x platform has increased and is now more than 
>> 64KB. Increase QSPI SPL partition size to 256KB for DRA74x EVM.
>> 
>> QSPI partition numbering changes because of this.

>And this will break the existing partitions potentially..
>See what was discussed on the list few days ago in thread "[PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table".

>It's best to have these left empty or as they originally were and let u-boot configure the partitions.

Agree with you. For dra7xx platform the SPL size has been increased to 256KB and hence the existing QSPI SPL partition in kernel (64K size) will break when latest mainline u-boot is used. 
Here only SPL partition has been changed and other partition & size is NOT changed and kept intact. I feel it will not break the existing partitions for dra7xx platform.

>> Signed-off-by: Ravi Babu <ravibabu@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7-evm.dts | 24 ++++++------------------
>>  1 file changed, 6 insertions(+), 18 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts 
>> b/arch/arm/boot/dts/dra7-evm.dts index 132f2be..2784241 100644
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -681,41 +681,29 @@
>>  		 */
>>  		partition@0 {
>>  			label = "QSPI.SPL";
>> -			reg = <0x00000000 0x000010000>;
>> +			reg = <0x00000000 0x000040000>;
>>  		};
>>  		partition@1 {
>> -			label = "QSPI.SPL.backup1";
>> -			reg = <0x00010000 0x00010000>;
>> -		};
>> -		partition@2 {
>> -			label = "QSPI.SPL.backup2";
>> -			reg = <0x00020000 0x00010000>;
>> -		};
>> -		partition@3 {
>> -			label = "QSPI.SPL.backup3";
>> -			reg = <0x00030000 0x00010000>;
>> -		};
>> -		partition@4 {
>>  			label = "QSPI.u-boot";
>>  			reg = <0x00040000 0x00100000>;
>>  		};
>> -		partition@5 {
>> +		partition@2 {
>>  			label = "QSPI.u-boot-spl-os";
>>  			reg = <0x00140000 0x00080000>;
>>  		};
>> -		partition@6 {
>> +		partition@3 {
>>  			label = "QSPI.u-boot-env";
>>  			reg = <0x001c0000 0x00010000>;
>>  		};
>> -		partition@7 {
>> +		partition@4 {
>>  			label = "QSPI.u-boot-env.backup1";
>>  			reg = <0x001d0000 0x0010000>;
>>  		};
>> -		partition@8 {
>> +		partition@5 {
>>  			label = "QSPI.kernel";
>>  			reg = <0x001e0000 0x0800000>;
>>  		};
>> -		partition@9 {
>> +		partition@6 {
>>  			label = "QSPI.file-system";
>>  			reg = <0x009e0000 0x01620000>;
>>  		};
>> --

Regards
Ravi
