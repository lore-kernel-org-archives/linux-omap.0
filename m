From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest randconfig build errors
Date: Mon, 15 Apr 2013 14:32:45 +0200
Message-ID: <201304151432.45362.arnd@arndb.de>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk> <20130304184649.GO11806@atomide.com> <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 13 April 2013, Rob Clark wrote:
> On Mon, Mar 4, 2013 at 1:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >> drivers/gpu/drm/tilcdc/tilcdc_slave.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_panel.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_drv.o:(.data+0x184): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >
> > Rob, I assume you'll do a patch for this one?
> 
> 
> oh, I apologize for the late reply, I didn't see this email...
> 
> There is a patch that we can merge to make tilcdc bool instead of
> tristate[1], which I suppose is ok for a temporary fix.  Although I'm
> all-ears if someone has a better idea about how to fix this.  The
> problem is that we have multiple sub-devices for different possible
> panel drivers, so that depending on DT tables, the correct ones get
> loaded for the hw.  But they are all built into a single module.

If the master device is always present, that's enough for autoloading
the module anyway, you can just drop the other two MODULE_DEVICE_TABLE
lines.

	Arnd
