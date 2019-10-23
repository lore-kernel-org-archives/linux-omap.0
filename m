From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Wed, 23 Oct 2019 06:41:11 +0200
Message-ID: <1CE62E4E-1A38-448C-9197-8FA16747F942@goldelico.com>
References: <20191007220540.30690-1-aford173@gmail.com>
 <20191022162223.GU5610@atomide.com>
 <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
 <20191022221919.GF5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191022221919.GF5610@atomide.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Adam Ford <aford173@gmail.com>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 23.10.2019 um 00:19 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * Adam Ford <aford173@gmail.com> [191022 19:01]:
>> On Tue, Oct 22, 2019 at 11:22 AM Tony Lindgren <tony@atomide.com> wrote:
>>> 
>>> Hi,
>>> 
>>> * Adam Ford <aford173@gmail.com> [191007 15:06]:
>>>> The some in the OMAP3 family have a bandgap thermal sensor, but
>>>> omap2plus has it disabled.
>>>> 
>>>> This patch enables the OMAP3_THERMAL by default like the rest of
>>>> the OMAP family.
>>> 
>>> Looks like this breaks off mode during idle for omap3, and that's
>>> probably why it never got enabled. The difference in power
>>> consumption during idle is about 7mW vs 32mW for the SoC as
>>> measured from torpedo shunt for main_battery_som.
>>> 
>>> I think the right fix might be simply to add handling for
>>> CPU_CLUSTER_PM_ENTER to the related thermal driver to disable
>>> it during idle like we have for gpio-omap.c for example.
>> 
>> I am not sure I know where to start on fixing that issue.  Would you
>> entertain enabling the driver if we set the device tree to 'disabled'
>> by default?  This way if people want to to use it, it can be enabled
>> on a per-device option.  Once the power stuff gets resolved, we might
>> be able to enable it by default.  For people who are planning on using
>> the DM3730 @ 1GHz in high temp environments, I am not sure they'll
>> care about low power.
> 
> They should both work fine together though. They are not mutually
> exclusive features.
> 
>> I'll try to look into it when I have time, but I was hoping a
>> compromise might be a reasonable work-around.
> 
> It should be hopefully a trivial fix.. I have not looked at the
> driver code though.

If I am taken right, it is the drivers/thermal/ti-soc-thermal/ti-*.c
which is a common driver for omap3, omap4, omap5. They only differ
in the thermal data and which registers and bits are used to access
the ADC.

So is this problem with off mode also known for omap4 and omap5?

BR,
Nikolaus
