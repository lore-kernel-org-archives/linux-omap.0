From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: arch/arm/mach-omap2/id.c - IS_ERR_OR_NULL()
Date: Fri, 10 May 2013 16:28:57 +0100
Message-ID: <20130510152857.GQ21614@n2100.arm.linux.org.uk>
References: <20130509090911.GM21614@n2100.arm.linux.org.uk> <CAB=otbRXPoHWPb3O+AYhdq5BccmLWRE=ZPPPQYQXge6w332+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48025 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab3EJP3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 May 2013 11:29:08 -0400
Content-Disposition: inline
In-Reply-To: <CAB=otbRXPoHWPb3O+AYhdq5BccmLWRE=ZPPPQYQXge6w332+fQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 10, 2013 at 12:50:42PM +0300, Ruslan Bilovol wrote:
> Hi Russell,
> 
> On Thu, May 9, 2013 at 12:09 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > So, I eliminated all but a very few of these from arch/arm, and I notice
> > today that there's a new couple of instances introduced by:
> >
> > commit 6770b211432564c562c856d612b43bbd42e4ab5e
> > Author: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > Date:   Thu Feb 14 13:55:24 2013 +0200
> >
> >     ARM: OMAP2+: Export SoC information to userspace
> >
> >     In some situations it is useful for userspace to
> >     know some SoC-specific information. For example,
> >     this may be used for deciding what kernel module to
> >     use or how to better configure some settings etc.
> >     This patch exports OMAP SoC information to userspace
> >     using existing in Linux kernel SoC infrastructure.
> >
> >     This information can be read under
> >     /sys/devices/socX directory
> >
> >     Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> >     [tony@atomide.com: updated for multiplatform changes]
> >     Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> > +       soc_dev = soc_device_register(soc_dev_attr);
> > +       if (IS_ERR_OR_NULL(soc_dev)) {
> > +               kfree(soc_dev_attr);
> > +               return;
> > +       }
> > +
> > +       parent = soc_device_to_device(soc_dev);
> > +       if (!IS_ERR_OR_NULL(parent))
> > +               device_create_file(parent, &omap_soc_attr);
> >
> > This is nonsense.  For the first, IS_ERR() is sufficient.  For the second,
> > tell me what error checking is required in the return value of this
> > function:
> >
> > struct device *soc_device_to_device(struct soc_device *soc_dev)
> > {
> >         return &soc_dev->dev;
> > }
> >
> > when you've already determined that the passed soc_dev is a valid pointer.
> > If you read the comments against the prototype:
> >
> > /**
> >  * soc_device_to_device - helper function to fetch struct device
> >  * @soc: Previously registered SoC device container
> >  */
> > struct device *soc_device_to_device(struct soc_device *soc);
> >
> > if "soc" is valid, it means the "previously registered SoC device container"
> > must have succeeded and that can only happen if the struct device has been
> > registered.  Ergo, there will always be a valid struct device pointer for
> > any registered SoC device container.  Therefore, if soc_device_register()
> > succeeds, then the return value from soc_device_to_device() will always be
> > valid and no error checking of it is required.
> >
> > Simples.  The rule as ever applies here: get to know the APIs your using
> > and don't fumble around in the dark hoping that you'll get this stuff
> > right.
> 
> The interesting thing is that extra IS_ERR_OR_NULL checking was
> introduced by author
> of the SoC API in his implementation for the arm/mach-ux500 platform
> and I used the same checking in my implementation when looked into his
> implementation for reference.
> Thanks for pointing on this, I will be more careful in the future.

Well, the whole reasoning here is that IS_ERR_OR_NULL() is far too easy
to get wrong - there are too many of this kind of crap in the kernel:

	foo = some_func();
	if (IS_ERR_OR_NULL(foo))
		return PTR_ERR(foo);

which is wrong, because if foo _is_ NULL, the function doesn't return an
error, it returns success instead.  Of course, if some_func() never ever
returns NULL in the first place, that can't happen, but then the additional
test there for a NULL pointer is, to put it bluntly, total bollocks.

Instead, what it shows is that the author of the code hasn't been bothered
to really check what the return conditions of the API actually are - and
yes, this kind of crap really has happened.  Where APIs return NULL on
failure and the author has used code similar to the above...

So, the general rule is... if you see IS_ERR_OR_NULL(), it probably is a
bug just waiting to happen in some way.

IS_ERR_OR_NULL() is not a subsitute for putting thought in.
IS_ERR_OR_NULL() is a trap for the unwary kernel programmer.

And there's moves to eliminate it from the kernel - I have a patch prepared
which has a lot of support to mark IS_ERR_OR_NULL() deprecated... that can't
go in until we've eliminated most of the current (probably incorrect) uses.
