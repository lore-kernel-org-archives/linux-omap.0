From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Fri, 4 Nov 2016 08:13:37 -0700
Message-ID: <20161104151337.GI21430@atomide.com>
References: <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
 <20161028094428.GO12024@localhost>
 <20161028181318.umwn3rx55pg2cvwd@atomide.com>
 <20161031114921.GB4254@localhost>
 <20161103212635.GC21430@atomide.com>
 <20161104141615.GA16119@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161104141615.GA16119@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161104 07:16]:
> On Thu, Nov 03, 2016 at 02:26:35PM -0700, Tony Lindgren wrote:
> > OK. Sorry for the delay responding, had my motherboard fail
> > over the weekend..
> 
> Ouch. Hope the recovery process wasn't too painful.

Only the usual scratches on my knuckles :)

> > > How about using a work struct and synchronous get for the deferred case?
> > 
> > Here's the patch updated to use the existing finish_resume_work.
> > Is that along the lines you were thinking?
> 
> Along those lines, yes, but I'm not sure about reusing
> finish_resume_work currently used to deassert resume signalling only.

OK I'll drop the changes for the other ones. Those can be
then combined later as needed once we're done with fixes.

> If work is already queued it seems you could end up deasserting resume
> prematurely for example. It currently also add unnecessary latency to
> other deferred work.

Yeah good point so best to keep this one strictly limited to
resume work.

> You also forgot to queue musb_host_finish_resume() from
> musb_port_suspend() which looks like it would break port resume.

Oh OK will take a look. Might be best to leave that one out
that change for now.

> > +	struct musb_pending_work *w;
> > +	unsigned long flags;
> > +
> > +	if (!callback)
> > +		return;
> 
> WARN_ON (e.g. in case someone switches the arguments)?

Sure. Will fix also your other comments and make it into a
more minimal patch for fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
