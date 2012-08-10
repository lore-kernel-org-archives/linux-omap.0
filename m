From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] gpio/omap: add *remove* callback in platform_driver
Date: Fri, 10 Aug 2012 12:27:49 +0530
Message-ID: <CAMQu2gxzBSXrZ5s=ZJP-A+H=1RhzFJ-7FP=jAeBdPNHStYSCbQ@mail.gmail.com>
References: <1344434316-21141-1-git-send-email-tarun.kanti@ti.com>
 <87k3x9wbrk.fsf@ti.com> <CAC83ZvLKk71O=+9U16FoTUU_-ffg+iJsHPgnJx+bzbHhBDXzhQ@mail.gmail.com>
 <87hascgli3.fsf@ti.com> <CAC83Zv++4CO_0xsNbwMYX_5uEv56csprqrrCjshxfb+ay2gBQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAC83Zv++4CO_0xsNbwMYX_5uEv56csprqrrCjshxfb+ay2gBQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 10, 2012 at 11:38 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
>
> On Thu, Aug 9, 2012 at 8:28 PM, Kevin Hilman <khilman@ti.com> wrote:
> > "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
> >
> >> On Wed, Aug 8, 2012 at 10:40 PM, Kevin Hilman <khilman@ti.com> wrote:
> >>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> >>>
> >>>> Add *remove* callback so that necessary cleanup operations are
> >>>> performed when device is unregistered. The device is deleted
> >>>> from the list and associated clock handle is released by
> >>>> calling clk_put() and irq descriptor is released using the
> >>>> irq_free_desc() api.
> >>>>
> >>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >>>> Reported-by: Paul Walmsley <paul@pwsan.com>
> >>>> Reviewed-by: Jon Hunter <jon-hunter@ti.com>
> >>>> Cc: Kevin Hilman <khilman@ti.com>
> >>>> Cc: Rajendra Nayak <rnayak@ti.com>
> >>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>> Cc: Cousson, Benoit <b-cousson@ti.com>
> >>>> Cc: Paul Walmsley <paul@pwsan.com>
> >>>> ---
> >>>> v2:
> >>>> Baseline:
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> >>>> Commit: 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee (Linux 3.6-rc1)
> >>>>
> >>>> (1) Use irq_free_descs() instead of irq_free_desc().
> >>>>     Besides, irq_free_desc() was using wrong parameter,
> >>>>     irq_base, instead of bank->irq.
> >>>> (2) irq_free_descs() moved outside spin_lock/unlock_*()
> >>>>     in order to avoid exception warnings.
> >>>>
> >>>> (3) pm_runtime_disable() added so that bind can happen successfully
> >>>>
> >>>> Test Detail:
> >>>> Step 1: Unbind gpio.5 device in order to invoke the *remove*
> >>>> callback.
> >>>> #echo "omap_gpio.5" > sys/bus/platform/drivers/omap_gpio/unbind
> >>>>
> >>>> Step 2: Bind gpio.5 device and confirm probe() for the device
> >>>> succeeds.
> >>>> #echo "omap_gpio.5" > sys/bus/platform/drivers/omap_gpio/bind
> >>>>
> >>>> Step 3: Execute read/write GPIO test case.
> >>>
> >>> What happens when GPIOs are in use (requested)?
> >> If I try to unbind a currently active GPIO bank then I see an exception
> >> after the irq descriptor is freed by the remove. I believe this is
> >> expected
> >> because interrupt raised by the system would not be handled.
> >
> > ... and the GPIO is still configured to trigger interrupts.
> Right!
>
> >
> > The point is that there is lots to cleanup/unconfigure properly for this
> > to work properly.
> As far as I can think of, all active gpio requests done either in
> board files or through DT
> have to be freed. But if this is done then when we bind() the device
> again initialization
> done in omap_gpio_probe() would not restore the board/DT related
> configuration.
> So the point is are we supposed to do all these cleanup in *remove*
> callback?
> If yes, how do we manage board level gpio usage?

More and more I think of the .remove() for GPIO, the interface not seems to
make sense. Being an infrastructure driver which can be used by many client
drivers like Ethernet, MMC card detect, sensors etc etc. And hence it can
not be made a loadable module.

So I am in favor of dropping the $subject patch completely unless and until
we need it genuinely.

Regards
Santosh
