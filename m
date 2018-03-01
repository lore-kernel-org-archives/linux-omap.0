From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability
 to MMC1/MMC2 dt node
Date: Thu, 1 Mar 2018 10:48:04 +0530
Message-ID: <f657b33e-8d02-4529-fe1f-20693a329fd3@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
 <20180206125806.19350-16-kishon@ti.com>
 <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
 <b411cf11-61e9-e688-6f04-e624fe52ac66@ti.com>
 <4f18dab9-aee3-1023-d301-f142c6e2d358@ti.com>
 <20180228223421.GM5448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180228223421.GM5448@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 01 March 2018 04:04 AM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar@ti.com> [180213 11:11]:
>> On Wednesday 07 February 2018 02:51 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Wednesday 07 February 2018 02:41 PM, Sekhar Nori wrote:
>>>> Kishon,
>>>>
>>>> On Tuesday 06 February 2018 06:28 PM, Kishon Vijay Abraham I wrote:
>>>>> Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.
>>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>
>>>> Along with this, dont we need to have
>>>>
>>>> 	/delete-property/ mmc-hs200-1_8v;
>>>>
>>>> for eMMC on Beagle x15 which does not support HS200?
>>>>
>>>> Or are you planning to depend on lack of pinctrl entries for HS200 to
>>>> take care of that?
>>>
>>> right now it relies on lack of pinctrl entries but I think adding delete
>>> property is appropriate. Actually I missed porting the patch that adds
>>> /delete-property/.
>>
>> Actually, thinking more, this should be probably be handled using
>> "no-1-8-v" property. Reading the comment above SDHCI_QUIRK2_NO_1_8_V, it
>> is specifically meant for the case when system (board) does not support
>> 1.8V even when host (controller) does. Which is exactly the case with
>> Beagle x15.
> 
> OK so that seems to be related to the last patch. I've applied
> the first two defconfig patches into omap-for-v4.17/defconfig
> and patches up to patch 13/15 into omap-for-v4.17/dt-sdhci.
> 
> Kishon, please repost the missing changes or ping me when
> the driver dependencies have cleared for further patches to
> be applied to enable sdhci.

sure, I'll repost when sdhci driver changes gets merged.

Thanks
Kishon
