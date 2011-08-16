From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints
 management code
Date: Mon, 15 Aug 2011 21:08:09 -0700
Message-ID: <20110816040809.GA11921@gvim.org>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
 <201108132234.17377.rjw@sisk.pl>
 <CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
 <201108141537.43752.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35103 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1HPEIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 00:08:20 -0400
Received: by gya6 with SMTP id 6so3571013gya.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 21:08:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108141537.43752.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Sun, Aug 14, 2011 at 03:37:43PM +0200, Rafael J. Wysocki wrote:
> On Sunday, August 14, 2011, Jean Pihet wrote:
> > Hi Rafael, Mark,
> > 
> > On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Saturday, August 13, 2011, mark gross wrote:
> > >> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.com wrote:
> > >> > From: Jean Pihet <j-pihet@ti.com>
> > >> >
> > >> > In preparation for the per-device constratins support:
> > >> > - rename update_target to pm_qos_update_target
> > >> > - generalize and export pm_qos_update_target for usage by the upcoming
> > >> > per-device latency constraints framework:
> > >> >    . operate on struct pm_qos_constraints for constraints management,
> > >> >    . introduce an 'action' parameter for constraints add/update/remove,
> > >> >    . the return value indicates if the aggregated constraint value has
> > >> >      changed,
> > >> > - update the internal code to operate on struct pm_qos_constraints
> > >> > - add a NULL pointer check in the API functions
> > >> >
> > >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > ...
> > >> > +/* Action requested to pm_qos_update_target */
> > >> > +enum pm_qos_req_action {
> > >> > +   PM_QOS_ADD_REQ,         /* Add a new request */
> > >> > +   PM_QOS_UPDATE_REQ,      /* Update an existing request */
> > >> > +   PM_QOS_REMOVE_REQ       /* Remove an existing request */
> > >> > +};
> > >> > +
> > >>
> > >> What do you need this enum for?  The function names *_update_*, *_add_*,
> > >> and  *_remove_* seem to be pretty redundant if you have to pass an enum
> > >> that could possibly conflict with the function name.
> > >>
> > >> >  #ifdef CONFIG_PM
> > >> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
> > >> > +                    enum pm_qos_req_action action, int value);
> > >> The action for update_target better damn well be "PM_QOS_UPDATE_REQ" or
> > >> there is something strange going on....  BTW what shold this function do
> > >> if the pm_qos_req_action was *not* the UPDATE one?
> > 
> > The meaning of pm_qos_update_target is 'update the PM QoS target
> > constraints lists'. As described in the changelog the intention of
> > this patch is to implement the constraints lists management logic in
> > update_target and simplify the API functions (add/update/remove). It
> > is also exported for the upcoming (patch 06/15]) to use it as well.
> 
> The enums are fine by me and they allow us to simplify the code
> quite a bit.
>
Ok, but they look a bit sloppy to me as we now have an API that says
"add" we can actually pass in an enum that says "remove".

--mark 
