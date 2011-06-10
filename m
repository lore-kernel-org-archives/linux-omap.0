From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Fri, 10 Jun 2011 09:52:09 +0300
Message-ID: <1307688729.1823.12.camel@lappyti>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
	 <20110609200335.GD26006@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49230 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753238Ab1FJGwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 02:52:15 -0400
In-Reply-To: <20110609200335.GD26006@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com

On Fri, 2011-06-10 at 05:03 +0900, Paul Mundt wrote:
> On Thu, Jun 09, 2011 at 04:56:42PM +0300, Tomi Valkeinen wrote:
> > +int dispc_runtime_get(void)
> > +{
> > +	int r;
> > +
> > +	DSSDBG("dispc_runtime_get\n");
> > +
> > +	r = pm_runtime_get_sync(&dispc.pdev->dev);
> > +	WARN_ON(r < 0);
> > +	return r < 0 ? r : 0;
> > +}
> > +
> > +void dispc_runtime_put(void)
> > +{
> > +	int r;
> > +
> > +	DSSDBG("dispc_runtime_put\n");
> > +
> > +	r = pm_runtime_put(&dispc.pdev->dev);
> > +	WARN_ON(r < 0);
> >  }
> >  
> This seems a bit odd. Your runtime_get wrapper is explicitly synchronous
> while your put wrapper is explicitly asynchronous, although these details
> (if intentional) are not at all obvious from the wrapper naming. From

Yes, the naming could be improved to make the (a)synchronousness obvious
to the caller. The functions are internal to DSS, but still.

> the use in the error paths and so on you will definitely need to be using
> pm_runtime_put_sync() at least some of the time.

Hmm, why is that? When the user of, say, dispc, has finished with it and
calls dispc_runtime_put(), the caller shouldn't care if the HW is
actually turned off now or later.

pm_runtime_put() can return an error value, but my wrappers discard it,
as I don't know in which situations it could happen, and what could the
driver do about it. If the HW cannot be turned off now, why could it be
turned off later, and when would that be?

> In the interest of avoiding confusion, I would in general just get rid of
> these wrappers and use the pm_runtime calls openly, as you already do for
> some of the other parts of the API. The runtime PM framework has pretty
> verbose debugging already that goes well beyond what you presently have,
> too.

Yes, my main reason for the wrapper is to hide the device pointer from
the users. So when, say, DSI block needs to use DISPC, it can just call
dispc_runtime_get(), instead of having a mechanism to get the dispc
device (dispc_get_dev() perhaps), and then using pm_runtime directly.

Not a big difference, but I'd like to keep the dispc device pointer
internal to dispc, as there's no real need to access it directly from
elsewhere.

Some of the wrappers are actually private to the file already, like for
dsi. These wrappers could be removed without exposing any device
pointers, but having them keeps the pattern consistent in all parts of
the dss. And it allows me to have the WARN_ONs there easily.

> You seem to have adopted this sync/async pattern for all of the users:

Yes, I think the pattern is similar all around: when you get the device,
you want it to be up and running immediately. When you put the device,
you don't care when it's actually disabled.

 Tomi


