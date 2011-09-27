From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Tue, 27 Sep 2011 16:05:11 +0100
Message-ID: <20110927150511.GM4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E81E224.2070408-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 08:18:04PM +0530, Rajendra Nayak wrote:
> On Tuesday 27 September 2011 05:40 PM, Mark Brown wrote:
> >On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:

> >>+	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> >>+						 GFP_KERNEL);
> >>+	if (!init_data)
> >>+		return NULL; /* Out of memory? */

> >This means that the init data will be kept around for the entire
> >lifetime of the device rather than being discarded.

> Wasn't it the same while this was passed around as platform_data?

It was in the past but I remember fixing it at some point.  Perhaps I'm
imagining things.

> >>+	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
> >>+						"regulator-supplies", NULL);

> >I'd expect that in the device tree world the supply regulator would
> >reference the node for that regulator.

> You mean using phandles? Thats what Grant proposed too but
> I thought you instead had an inclination towards names? Or maybe
> I misunderstood.

They need both.  We need to reference the device that provides the
supply and use a name to say which of the potentially multiple supplies
on the consumer device is which.

> >Hrm, I think loosing the signs here is bad karma - negative voltages do
> >exist after all.

> Oops.. they do? didn't know about that.

Yup, ground is just a reference point.
