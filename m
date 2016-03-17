From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v5 3/6] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
Date: Thu, 17 Mar 2016 10:45:59 -0500
Message-ID: <56EAD137.1080502@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-4-git-send-email-fcooper@ti.com>
 <20160317150619.GA28105@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317150619.GA28105@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: thierry.reding@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org



On 03/17/2016 10:06 AM, Rob Herring wrote:
> On Mon, Mar 07, 2016 at 07:23:41PM -0600, Franklin S Cooper Jr wrote:
>> Devices that utilize the OCP registers and/or PRCM registers and
>> register bit fields should be modelled using hwmod. Since eQEP, ePWM and
> s/modelled/modeled/

Will fix.
>
>> eCAP don't fall under this category, remove their hwmod entries.
>>
>> Instead these clocks simply use the clock that is pass through by its
>> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
>> subdevices.
> Are you breaking compatibility with old DTs here? 

No. The first patch makes sure that the ecap and ehrpwm get
their clocks from their parent which is all they care about.
Old dtbs will have hwmod entries for ecap and ehrpwm which
will end up not doing anything.
>  
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  1 -
>>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  7 +-
>>  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
>>  .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 -----------------
>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 ----------------------
>>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 --------------
>>  7 files changed, 4 insertions(+), 233 deletions(-)
