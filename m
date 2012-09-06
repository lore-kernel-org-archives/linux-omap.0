From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] arm/dts: AM33XX: Add reg and interrupt property for
 all nodes
Date: Thu, 6 Sep 2012 15:57:51 +0200
Message-ID: <5048ABDF.6020609@ti.com>
References: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Vaihbav,

On 08/27/2012 02:31 PM, Vaibhav Hiremath wrote:
> This series is trivial patch-series and should be considered as
> preparation for the future where we supposed to get rid of
> hwmod dependency.
> 
> 1/2: Converts all hex numbers to lowercase, fixing inconsistency
> 2/2: Add reg and interrupt property  to all device/module nodes inside
>      DTS files. 
> 
> Although currently hwmod overwrites resources, I have validated this
> patch series by changing the omap_device layer to respect DT resources
> and boot Tested on BeagleBone platform.
> I will be submitting the changes for omap_device layer as well, still
> needs to fix on certain things.
> 
> Vaibhav Hiremath (2):
>   arm/dts: AM33XX: Convert all hex numbers to lower-case
>   arm/dts: AM33XX: Specify reg and interrupt property for all nodes
> 
>  arch/arm/boot/dts/am335x-bone.dts |    2 +-
>  arch/arm/boot/dts/am335x-evm.dts  |    2 +-
>  arch/arm/boot/dts/am33xx.dtsi     |   62 +++++++++++++++++++++++++++++++------
>  3 files changed, 54 insertions(+), 12 deletions(-)

I'll queue that along with the other DT stuff for 3.7.

Thanks,
Benoit
