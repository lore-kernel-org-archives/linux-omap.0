From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 1/5] ARM: dts: OMAP: Add timer nodes
Date: Wed, 24 Oct 2012 18:00:37 -0500
Message-ID: <50887315.2000509@ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
 <1350496873-21337-2-git-send-email-jon-hunter@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB49C1B-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 10/24/2012 01:17 PM, Hiremath, Vaibhav wrote:
> On Wed, Oct 17, 2012 at 23:31:09, Hunter, Jon wrote:
>> Add the 12 GP timers nodes present in OMAP2.
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>> Add the 7 GP timers nodes present in AM33xx.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> Please note that for OMAP2/3 devices, there is only one interrupt controller
>> for the ARM CPU (which has the label "intc") and so globally define this as the
>> interrupt parent to save duplicating the interrupt parent for all device nodes.
>>
>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>> Vaibhav's original nodes adding information on which timers support a PWM
>> output.
>>
>> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/omap/timer.txt         |   29 ++++++
>>  arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++++++++
>>  arch/arm/boot/dts/omap2.dtsi                       |   86 ++++++++++++++++++
>>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>>  arch/arm/boot/dts/omap3.dtsi                       |   96 ++++++++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++++++++++
>>  7 files changed, 374 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
>>
> 
> Although I have not tested this version of patch series at my end, but 
> whole patch-series Looks ok to me.
> 
> Acked-By: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>

Thanks. I made a couple cosmetic changes in V4 apart from the
"interrupt-parent" addition which we are now dropping. Care to ACK
patches 2-5 of V4?

Thanks
Jon
