From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Fri, 26 Aug 2011 22:56:39 +0200
Message-ID: <201108262256.39620.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com> <20110826165427.GC9437@gvim.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41202 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab1HZUzB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 16:55:01 -0400
In-Reply-To: <20110826165427.GC9437@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, jean.pihet@newoldbits.com, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Friday, August 26, 2011, mark gross wrote:
> On Fri, Aug 26, 2011 at 11:25:13AM +0900, MyungJoo Ham wrote:
> > On Fri, Jul 1, 2011 at 12:11 AM,  <jean.pihet@newoldbits.com> wrote:
> > > @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_power_fops = {
> > >  /* unlocked internal variant */
> > >  static inline int pm_qos_get_value(struct pm_qos_object *o)
> > >  {
> > > -       if (plist_head_empty(&o->requests))
> > > +       if (plist_head_empty(o->requests))
> > >                return o->default_value;
> > >
> > >        switch (o->type) {
> > > -       case PM_QOS_MIN:
> > > -               return plist_first(&o->requests)->prio;
> > > +               case PM_QOS_MIN:
> > > +                       return plist_first(o->requests)->prio;
> > >
> > > -       case PM_QOS_MAX:
> > > -               return plist_last(&o->requests)->prio;
> > > +               case PM_QOS_MAX:
> > > +                       return plist_last(o->requests)->prio;
> > >
> > > -       default:
> > > -               /* runtime check for not using enum */
> > > -               BUG();
> > > +               default:
> > > +                       /* runtime check for not using enum */
> > > +                       BUG();
> > >        }
> > >  }
> > 
> > Hello,
> > 
> > 
> > Sorry to jump in this late, but, I've got a question in choosing QoS
> > value from the list with pm_qos_get_value function and pm_qos_type.
> > 
> > For QoS objects such as network throughput, wouldn't "PM_QOS_ADD" be
> > more appropriate than PM_QOS_MAX?
> > If A is requesting 10MB/s on NIC-X and B is requesting 5MB/s on NIC-X,
> > I guess PM QOS should say NIC-X that it needs to provide 15MB/s, not
> > 10MB/s. Or, are we assuming that A and B will never put streams at the
> > same time?
> 
> This was brought up a few years back as well.  The reason we kept the
> aggregate QoS for network Throughput as a max instead of a sum was that
> there where already a number of interfaces for network shaping and we
> didn't have a good answer to the problem of what to do when the
> throughput qos requested exceeds hardware capabilities.  
> 
> Now that I have more experience with handsets I'm not sure it makes any
> practical difference to sum or max the throughput qos requests.  So if
> someone would like it to aggregate throughputs by summation of requests
> that could be done.  
> 
> It turns out its the latency requests that are really used.

Moreover, the throughput QoS is really difficult to handle, because
quite often there's no good mapping between energy-saving measures one
can use and the resulting throughput.

Thanks,
Rafael
