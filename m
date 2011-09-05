From: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
Date: Mon, 05 Sep 2011 07:46:18 -1000
Message-ID: <4E650AEA.2090109@firmworks.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1377915.IaVE5xAurc@wuerfel> <4E64E527.4040409@ti.com>
	<201109051923.51084.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201109051923.51084.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/5/2011 7:23 AM, Arnd Bergmann wrote:
> On Monday 05 September 2011, Cousson, Benoit wrote:
>> Yeah, I saw that in the "cpus" node documentation. My point here is that
>> I do need to represent the MPU subsystem that will contain the cpus. And
>> thus the Cortex is inside the MPU subsystem.


The device tree hierarchy does not represent "containment", but rather 
addressing from the standpoint of a program running on a CPU.

 From that viewpoint, it might be better to have a phandle reference to 
the mpu in each CPU node.

>>
>> I can potentially keep the CPUs inside the cpus node, and just represent
>> the mpu node inside the soc, with potentially some phandle to the real
>> cpu nodes.
>>
>> Something like that:
>>
>> cpus {
>>          cpu0: cpu@0 {
>>                          compatible = "arm,cortex-a8";
>>          };
>> };
>>
>> [...]
>>
>> soc {
>>          compatible = "ti,omap-infra";
>>          mpu {
>>                  compatible = "ti,omap3-mpu";
>>                  hwmods = "mpu";
>>                  cpu@0 {
>>                          phandle =<&cpu0>;
>>                          [...]
>>                  };
>>          };
>> };
>
> Yes, that looks good. I wouldn't name the attribute "phandle" if I could
> think of anything better (which I can't at the moment).
>
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
