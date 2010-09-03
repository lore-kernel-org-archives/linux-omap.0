From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH V2 1/2] input: CMA3000 Accelerometer driver
Date: Fri, 3 Sep 2010 09:34:39 -0700
Message-ID: <20100903163438.GB2200@core.coreip.homeip.net>
References: <15445.10.24.255.17.1274424777.squirrel@dbdmail.itg.ti.com>
 <20100829184904.GC26209@core.coreip.homeip.net>
 <017e01cb4b53$45925da0$LocalHost@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <017e01cb4b53$45925da0$LocalHost@wipblrx0099946>
Sender: linux-input-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Hemanth,

On Fri, Sep 03, 2010 at 04:02:11PM +0530, Hemanth V wrote:
> >
> >
> >Do not like repeated release of resources in main and error path... Can
> >we do it like:
> >
> >...
> >disable_irq();
> >error = cma3000_set(data, CMA3000_CTRL, ctrl, "ctrl");
> >if (!error) {
> >/* Settling time delay required after mode change */
> >msleep(CMA3000_SETDELAY);
> >}
> >enable_irq();
> >out:
> >mutex_unlock();
> >return error ? error : count;
> 
> I am thinking I can just add the below statement, and should be able to
> remove repeated release.
> 
> return error ? error : count;
> 

That would make us sleep for CMA3000_SETDELAY even in case of failure...
... But that should be OK.

> >>+
> >>+ if (data->client->irq) {
> >>+ ret = request_threaded_irq(data->client->irq, NULL,
> >>+ cma3000_thread_irq,
> >>+ irqflags | IRQF_ONESHOT,
> >>+ data->client->name, data);
> >>+
> >>+ if (ret < 0) {
> >>+ dev_err(&data->client->dev,
> >>+ "request_threaded_irq failed\n");
> >>+ goto err_op1_failed;
> >>+ }
> >>+ }
> >
> >What is the utility of the driver when there is no IRQ line?
> 
> Not sure I fully understand your comments.
> Currently probe would return a failure.
> 

You have a check for data->client->irq != 0 and finish probe() with
success in case it is 0. The question is what is the use of the
device/driver combo in case when data->client->irq == 0?

-- 
Dmitry
