From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints management code
Date: Sun, 14 Aug 2011 15:37:43 +0200
Message-ID: <201108141537.43752.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <201108132234.17377.rjw@sisk.pl> <CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40039 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab1HNNgD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Aug 2011 09:36:03 -0400
In-Reply-To: <CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Sunday, August 14, 2011, Jean Pihet wrote:
> Hi Rafael, Mark,
> 
> On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, August 13, 2011, mark gross wrote:
> >> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.com wrote:
> >> > From: Jean Pihet <j-pihet@ti.com>
> >> >
> >> > In preparation for the per-device constratins support:
> >> > - rename update_target to pm_qos_update_target
> >> > - generalize and export pm_qos_update_target for usage by the upcoming
> >> > per-device latency constraints framework:
> >> >    . operate on struct pm_qos_constraints for constraints management,
> >> >    . introduce an 'action' parameter for constraints add/update/remove,
> >> >    . the return value indicates if the aggregated constraint value has
> >> >      changed,
> >> > - update the internal code to operate on struct pm_qos_constraints
> >> > - add a NULL pointer check in the API functions
> >> >
> >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ...
> >> > +/* Action requested to pm_qos_update_target */
> >> > +enum pm_qos_req_action {
> >> > +   PM_QOS_ADD_REQ,         /* Add a new request */
> >> > +   PM_QOS_UPDATE_REQ,      /* Update an existing request */
> >> > +   PM_QOS_REMOVE_REQ       /* Remove an existing request */
> >> > +};
> >> > +
> >>
> >> What do you need this enum for?  The function names *_update_*, *_add_*,
> >> and  *_remove_* seem to be pretty redundant if you have to pass an enum
> >> that could possibly conflict with the function name.
> >>
> >> >  #ifdef CONFIG_PM
> >> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
> >> > +                    enum pm_qos_req_action action, int value);
> >> The action for update_target better damn well be "PM_QOS_UPDATE_REQ" or
> >> there is something strange going on....  BTW what shold this function do
> >> if the pm_qos_req_action was *not* the UPDATE one?
> 
> The meaning of pm_qos_update_target is 'update the PM QoS target
> constraints lists'. As described in the changelog the intention of
> this patch is to implement the constraints lists management logic in
> update_target and simplify the API functions (add/update/remove). It
> is also exported for the upcoming (patch 06/15]) to use it as well.

The enums are fine by me and they allow us to simplify the code
quite a bit.

Thanks,
Rafael
