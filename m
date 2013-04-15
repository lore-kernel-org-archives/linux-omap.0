From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 1/6] drivers: phy: add generic PHY framework
Date: Mon, 15 Apr 2013 12:34:16 +0100
Message-ID: <20130415113416.7C3943E0AA8@localhost>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <1363770725-13717-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363770725-13717-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 20 Mar 2013 14:42:00 +0530, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> The PHY framework provides a set of APIs for the PHY drivers to
> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
> PHY with or without using phandle. To obtain a reference to the PHY without
> using phandle, the platform specfic intialization code (say from board file)
> should have already called phy_bind with the binding information. The binding
> information consists of phy's device name, phy user device name and an index.
> The index is used when the same phy user binds to mulitple phys.
> 
> PHY drivers should create the PHY by passing phy_descriptor that has
> describes the PHY (label, type etc..) and ops like init, exit, suspend, resume,
> poweron, shutdown.
> 
> The documentation for the generic PHY framework is added in
> Documentation/phy.txt and the documentation for the sysfs entry is added
> in Documentation/ABI/testing/sysfs-class-phy.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

Hi Kishon,

For review purposes, I'll skip most of the implementation and focus on
the data structures. I think you need to take another look at the
approach your using. The kernel already provides a lot of support for
implementing devices and binding them to drivers that you should be
able to use...


[...]
> +/**
> + * struct phy - represent the phy device
> + * @dev: phy device
> + * @label: label given to phy
> + * @type: specifies the phy type
> + * @of_node: device node of the phy
> + * @ops: function pointers for performing phy operations
> + */
> +struct phy {
> +	struct device		dev;
> +	const char		*label;
> +	int			type;
> +	struct bus_type		*bus;
> +	struct device_node	*of_node;
> +	struct phy_ops		*ops;
> +};

Alright, so the core of the functionality is this 'struct phy' which
tracks all the instances of PHY devices. As I understand it each
physical phy will have a 'struct phy' instance tracking it. That makes
sense.

struct phy embeds a struct device. Also good. The linux driver model
knows all about devices and how to handle them. However, most of the
rest of this structure looks to be reinventing stuff the driver model
already does.

'label' seems unnecessary. struct device embeds a struct kobject, which
means it has a name and shows up in sysfs. Is there a reason that the
device name cannot be used directly?

'type' I just don't understand. I don't see any users of it in this
patch. I only see where it is set.

'bus' absolutely should not be here. The bus type should be set in the
struct device by this subsystem when the device gets registered. There
is no reason to have a pointer to it here.

'of_node' is already in struct device

Finally, it really doesn't look right for a device object to have an
'ops' structure. The whole point of the driver model is that a struct
device doesn't encapsulate any behaviour. A device gets registers to a
bus type, and then the driver core will associate a struct device_driver
to a device that it is able to drive, and the struct device_driver is
supposed to contain any ops structure used to control the device.

> +
> +/**
> + * struct phy_bind - represent the binding for the phy
> + * @dev_name: the device name of the device that will bind to the phy
> + * @phy_dev_name: the device name of the phy
> + * @index: used if a single controller uses multiple phys
> + * @auto_bind: tells if the binding is done explicitly from board file or not
> + * @phy: reference to the phy
> + * @list: to maintain a linked list of the binding information
> + */
> +struct phy_bind {
> +	const char	*dev_name;
> +	const char	*phy_dev_name;
> +	int		index;
> +	int		auto_bind:1;
> +	struct phy	*phy;
> +	struct list_head list;
> +};

How are PHYs attached to the system. Would the PHY be a direct child of
the host controller device, or would a PHY hang off another bus (like
i2c) for control? (this is how Ethernet phys work; they hang off the
MDIO bus, but may be attached to any Ethernet controller).

Since there is at most a 1:N relationship between host controllers and
PHYs, there shouldn't be any need for a separate structure to describe
binding. Put the inding data into the struct phy itself. Each host
controller can have a list of phys that it is bound to.

Tring to maintain a separate global list of PHY bindings isn't a good
idea. Keep it local to the host controller and the specific phys
instead.

g.
