From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] mfd: twl-core: export twl_get_regmap
Date: Wed, 23 Nov 2016 11:12:23 +0000
Message-ID: <20161123111223.GG23750@n2100.armlinux.org.uk>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell>
 <20161121093144.GE23750@n2100.armlinux.org.uk>
 <CAKP5S=28xVyNE=Q7hd2UbtOmT=12ayrcWM5m1OTvk5kGN5pZrw@mail.gmail.com>
 <20161121133755.GF23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161121133755.GF23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2016 at 01:37:55PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 12:03:03PM +0200, Nicolae Rosia wrote:
> > On Mon, Nov 21, 2016 at 11:31 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > Passing data between drivers using *_set_drvdata() is a layering
> > > violation:
> > >
> > > 1. Driver data is supposed to be driver private data associated with
> > >    the currently bound driver.
> > > 2. The driver data pointer is NULL'd when the driver unbinds from the
> > >    device.  See __device_release_driver() and the
> > >    dev_set_drvdata(dev, NULL).
> > > 3. It will break with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled for a
> > >    similar reason to (2).
> > >
> > > So, do not pass data between drivers using *_set_drvdata() - any
> > > examples in the kernel already are founded on bad practice, are
> > > fragile, and are already broken for some kernel configurations.
> > 
> > After inspecting mfd_add_device, it seems that it creates a
> > platform_device which has the parent set to the driver calling the
> > function.
> > Isn't module unloading forbidden if there is a parent->child
> > relationship in place and you're removing the parent?
> 
> Forget this idea that there's any connection between modules and
> the struct device relationships - there isn't anything of the kind!
> 
> Each struct device is refcounted, and child devices will hold a
> reference to their parent device, so the parent device doesn't get
> freed before its children are all gone.
> 
> That's a completely separate issue to when a struct device is bound
> to a struct device_driver - it's entirely possible for parent drivers
> to be unbound at any time, even when there are child drivers in place.
> 
> There are cases where we want that to happen - think of any driver
> which is a bus driver in itself - eg, PCMCIA, MMC, USB, etc.  These
> drivers enumerate their children, and destroy their children when
> the driver is unbound - but the driver has to be in the process of
> being unbound for that to happen.  That process may very well start
> with the child devices being bound to their drivers.
> 
> What makes the child drivers unbind is when the bus driver deletes
> the child struct devices.
> 
> > What should be the best practice to share data between drivers?
> > Reference counted data?
> 
> I guess so, but you will still have a race if you do something like:
> 
> 	struct parent_private_data *parent_priv = dev_get_drvdata(dev->parent);
> 
> Yes, that'll get the parent's driver private data, but what you don't
> know is whether the pointer remains valid, and even if you do as the
> very next step:
> 
> 	kref_get(&parent_priv->kref);
> 
> you don't know whether parent_priv was kfree()d between these two
> statements.
> 
> However, if the parent driver creates the struct device that you're
> using and deletes the struct device before it frees its private data,
> then you can be sure that parent_priv will be valid, because the child
> drivers will be unbound during the parent driver's ->remove function,
> _before_ the private data is freed.
> 
> > In the case of TWL, the twl-core is just a simple container for
> > regmaps - all other "sub devices" are using those regmaps to access
> > the I2C device's registers, it makes no sense to remove the parent
> > driver since it does *nothing*.
> 
> I can't comment on what twl-core is doing, I haven't looked at it in
> ages, but most MFD drivers have the parent device creating and destroying
> their children, so it should be fine.
> 
> My original comment was more along the lines of a parent device poking
> driver-private data into the child devices it was creating for the
> child drivers to pick up.  However, it's worth discussing the validity
> cases of the parent's driver data too, as per the above.

I was just curious, and I took a peek at the OMAP/TWL DT files, and
I see that it's left to DT to create the children.

So, there is already _no_ lifetime relationship between the children
and the parent device drivers being probed.

What's even more fun is this:

static int
twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
{
...
        if (twl_priv) {
                dev_dbg(&client->dev, "only one instance of %s allowed\n",
                        DRIVER_NAME);
                return -EBUSY;
        }
...
        twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
                                GFP_KERNEL);
        if (!twl_priv) {
                status = -ENOMEM;
                goto free;
        }
...
                twl->regmap = devm_regmap_init_i2c(twl->client,
                                                   &twl_regmap_config[i]);
                if (IS_ERR(twl->regmap)) {
                        status = PTR_ERR(twl->regmap);
                        dev_err(&client->dev,
                                "Failed to allocate regmap %d, err: %d\n", i,
                                status);
                        goto fail;
                }
...

So, if we get a failure after successfully allocating twl_priv, then
the driver and device are dead - it can't ever be retried.  What's
more is that twl_priv contains a stale pointer - and use of it would
be a use-after-free bug, even to inspect twl_priv->ready.

That brings us on to the remove path:

static int twl_remove(struct i2c_client *client)
{
...
        twl_priv->ready = false;
        return 0;
}

which is pretty much useless - twl_priv will be kfree()d after this
function returns, so dereferencing twl_priv is again a use-after-free
bug.  What's more is that the memory pointed to by twl_priv can be
reallocated, and ->ready could contain any value.

Now, there's a bunch of sub-nodes declared in DT which cause drivers
to be probed (eg, the twl-pwmled driver).  These make use of
twl_i2c_read_u8() etc to read/write registers on the device.  These
call through to twl_i2c_read() and twl_i2c_write(), both of which
use twl_get_regmap().

twl_get_regmap() dereferences twl_priv, which as established above may
have been kfree()d if the twl-core driver has been unbound.  Even if
twl_priv survives with its stale data, the regmap in twl->regmap will
also have been freed, so the regmap accesses are likely to screw up.

In any case, the result is likely not going to be nice.

Note that you can't fail in a driver's remove method, so you can't stop
the twl-core driver being unbound by returning an error there: the
return value is ignored.

One possible approach to this would be to make twl-core built-in only,
remove the .remove method from the driver, and set suppress_bind_attrs
in the driver structure, so userspace can't bind/unbind the I2C
driver.  However, that's just papering over the problem - if the I2C
_bus_ driver gets unbound, exactly the same problem exists - I2C will
delete the clients on the bus which will cause drivers to be unbound.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
