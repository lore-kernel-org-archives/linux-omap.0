From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2] v4l2_device/v4l2_subdev: final (?) version
Date: Sun, 30 Nov 2008 00:06:21 +0100
Message-ID: <200811300006.22080.hverkuil@xs4all.nl>
References: <200811291852.41794.hverkuil@xs4all.nl> <200811292246.20338.hverkuil@xs4all.nl> <200811291422.20155.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:4323 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbYK2XGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Nov 2008 18:06:44 -0500
In-Reply-To: <200811291422.20155.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@skynet.be>

On Saturday 29 November 2008 23:22:19 David Brownell wrote:
> On Saturday 29 November 2008, Hans Verkuil wrote:
> > > > +void v4l2_device_register(struct device *dev, struct
> > > > v4l2_device *v4l2_dev) +{
> > > > +=A0=A0=A0=A0=A0=A0=A0BUG_ON(!dev || !v4l2_dev || dev_get_drvda=
ta(dev));
> > >
> > > Ouch. =A0Better to return -EINVAL, like most register() calls,
> > > than *ever* use a BUG_ON() for bad parameters. =A0Same applies
> > > every other place you use BUG_ON, from a quick scan ...
> >
> > Are there some documented guidelines on when to use BUG_ON?
>
> Maybe there should be.  I know I've seen flames from Linus on
> the topic.  Basically, treat it like a panic() where the system
> must stop operation lest it catch fire or scribble all over the
> (not-backed-up) disk ... if the system can keep running sanely,
> then BUG() and friends are inappropriate.

I think it would be good to have some document about this, since
from what I've seen from a quick scan I'm not the only one who uses
it incorrectly. There is no documentation in the asm-generic/bug.h
header and there is also no documentation on this in the Documentation
directory.

> > I see it used in other places in this way.
>
> I tend to submit patches fixing bugs like that, when I have time.
>
> > My reasoning was that returning an
> > error makes sense if external causes can result in an error, but
> > this test is more the equivalent of an assert(), i.e. catching a
> > programming bug early.
>
> In which case a WARN() is better.  But in most cases I wouldn't
> even do that.  The kernel's design center is closer to "run
> robustly" than "make developers' lives easier".  Programmers
> who don't check return values for critical operations like
> registering core resources deserve what they get.  And if you
> want to nudge them, the __must_check annotation helps catch
> such goofage even earlier:  compile time, not run time.

I've replaced it as follows (and with __must_check in the header):

int v4l2_device_register(struct device *dev, struct v4l2_device *v4l2_d=
ev)
{
        if (dev =3D=3D NULL || v4l2_dev =3D=3D NULL)
                return -EINVAL;
        /* Warn if we apparently re-register a device */
        WARN_ON(dev_get_drvdata(dev));
        INIT_LIST_HEAD(&v4l2_dev->subdevs);
        spin_lock_init(&v4l2_dev->lock);
        v4l2_dev->dev =3D dev;
        snprintf(v4l2_dev->name, sizeof(v4l2_dev->name), "%s %s",
                        dev->driver->name, dev->bus_id);
        dev_set_drvdata(dev, v4l2_dev);
        return 0;
}
EXPORT_SYMBOL_GPL(v4l2_device_register);

void v4l2_device_unregister(struct v4l2_device *v4l2_dev)
{
        struct v4l2_subdev *sd, *next;

        if (v4l2_dev =3D=3D NULL || v4l2_dev->dev =3D=3D NULL)
                return;
        dev_set_drvdata(v4l2_dev->dev, NULL);
        /* unregister subdevs */
        list_for_each_entry_safe(sd, next, &v4l2_dev->subdevs, list)
                v4l2_device_unregister_subdev(sd);

        v4l2_dev->dev =3D NULL;
}
EXPORT_SYMBOL_GPL(v4l2_device_unregister);

int v4l2_device_register_subdev(struct v4l2_device *dev, struct v4l2_su=
bdev *sd)
{
        /* Check for valid input */
        if (dev =3D=3D NULL || sd =3D=3D NULL || !sd->name[0])
                return -EINVAL;
        /* Warn if we apparently re-register a subdev */
        WARN_ON(sd->dev);
        if (!try_module_get(sd->owner))
                return -ENODEV;
        sd->dev =3D dev;
        spin_lock(&dev->lock);
        list_add_tail(&sd->list, &dev->subdevs);
        spin_unlock(&dev->lock);
        return 0;
}
EXPORT_SYMBOL_GPL(v4l2_device_register_subdev);

void v4l2_device_unregister_subdev(struct v4l2_subdev *sd)
{
        /* return if it isn't registered */
        if (sd =3D=3D NULL || sd->dev =3D=3D NULL)
                return;
        spin_lock(&sd->dev->lock);
        list_del(&sd->list);
        spin_unlock(&sd->dev->lock);
        sd->dev =3D NULL;
        module_put(sd->owner);
}
EXPORT_SYMBOL_GPL(v4l2_device_unregister_subdev);

Thanks for the review!

	Hans

--=20
Hans Verkuil - video4linux developer - sponsored by TANDBERG
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
