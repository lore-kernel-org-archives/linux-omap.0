From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/13] mfd: twl-core: Add initial DT support for
	twl4030/twl6030
Date: Mon, 5 Sep 2011 18:05:23 +0200
Message-ID: <4E64F343.7030701@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
	<1314897689-17791-5-git-send-email-b-cousson@ti.com>
	<4690440.pddZTpGgxd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4690440.pddZTpGgxd@wuerfel>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Krishnamoorthy,
	Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On 9/1/2011 8:27 PM, Arnd Bergmann wrote:
> On Thursday 01 September 2011 19:21:20 Benoit Cousson wrote:
>> +#ifdef CONFIG_OF
>> +#define MODALIAS_SIZE 32
>> +
>> +static int add_of_children(struct i2c_client *client, unsigned long features)
>> +{
>> +       u32 reg;
>> +       struct device *child, *dev =&client->dev;
>> +       struct device_node *node, *parent = client->dev.of_node;
>> +       int irq;
>> +       char alias[MODALIAS_SIZE];
>> +
>> +       for_each_child_of_node(parent, node) {
>> +               if (of_property_read_u32(node, "reg",&reg)) {
>> +                       dev_err(dev, "%s(): invalid reg on %s\n", __func__,
>> +                               node->full_name);
>> +                       continue;
>> +               }
>> +
>
> Have you tried just calling calling of_platform_bus_probe on the
> parent? If all child devices are in the device tree, I think that
> should work, too. It probably requires some tweaking in the
> child drivers though.

Good point. That should indeed work for the current children since the 
add_numbered_child is just creating a platform_device.
On top of that, this function is filling some IRQ resources, but DT will 
do that for free and in a much better way thanks to the irq_domain.

I had some concern with the regulator devices that does require some 
custom pdata for the moment, but that should disappear as soon as the 
proper regulator binding will be there.

Since the idea is to move all the children to DT, this is definitively 
the best approach. I'll update the driver to support the DT binding too.

Thanks for the suggestion. I'll try that and repost if it works as 
expected. But it should... at least for the twl_rtc.

Benoit
