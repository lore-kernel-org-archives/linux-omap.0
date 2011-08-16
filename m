From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints management code
Date: Tue, 16 Aug 2011 20:01:38 +0200
Message-ID: <201108162001.38894.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <CAORVsuXDp4vYGg9BCLkJm6iMPobSCtE9s_1j4zNV5frKjQY1jg@mail.gmail.com> <20110816174557.GA17027@gvim.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45470 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab1HPR7z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 13:59:55 -0400
In-Reply-To: <20110816174557.GA17027@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Tuesday, August 16, 2011, mark gross wrote:
> On Tue, Aug 16, 2011 at 08:44:19AM +0200, Jean Pihet wrote:
> > On Tue, Aug 16, 2011 at 6:08 AM, mark gross <markgross@thegnar.org> wrote:
> > > On Sun, Aug 14, 2011 at 03:37:43PM +0200, Rafael J. Wysocki wrote:
> > >> On Sunday, August 14, 2011, Jean Pihet wrote:
> > >> > Hi Rafael, Mark,
> > >> >
> > >> > On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >> > > On Saturday, August 13, 2011, mark gross wrote:
> > >> > >> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.com wrote:
> > >> > >> > From: Jean Pihet <j-pihet@ti.com>
> > >> > >> >
> > >> > >> > In preparation for the per-device constratins support:
> > >> > >> > - rename update_target to pm_qos_update_target
> > >> > >> > - generalize and export pm_qos_update_target for usage by the upcoming
> > >> > >> > per-device latency constraints framework:
> > >> > >> >    . operate on struct pm_qos_constraints for constraints management,
> > >> > >> >    . introduce an 'action' parameter for constraints add/update/remove,
> > >> > >> >    . the return value indicates if the aggregated constraint value has
> > >> > >> >      changed,
> > >> > >> > - update the internal code to operate on struct pm_qos_constraints
> > >> > >> > - add a NULL pointer check in the API functions
> > >> > >> >
> > >> > >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > >> > ...
> > >> > >> > +/* Action requested to pm_qos_update_target */
> > >> > >> > +enum pm_qos_req_action {
> > >> > >> > +   PM_QOS_ADD_REQ,         /* Add a new request */
> > >> > >> > +   PM_QOS_UPDATE_REQ,      /* Update an existing request */
> > >> > >> > +   PM_QOS_REMOVE_REQ       /* Remove an existing request */
> > >> > >> > +};
> > >> > >> > +
> > >> > >>
> > >> > >> What do you need this enum for?  The function names *_update_*, *_add_*,
> > >> > >> and  *_remove_* seem to be pretty redundant if you have to pass an enum
> > >> > >> that could possibly conflict with the function name.
> > >> > >>
> > >> > >> >  #ifdef CONFIG_PM
> > >> > >> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
> > >> > >> > +                    enum pm_qos_req_action action, int value);
> > >> > >> The action for update_target better damn well be "PM_QOS_UPDATE_REQ" or
> > >> > >> there is something strange going on....  BTW what shold this function do
> > >> > >> if the pm_qos_req_action was *not* the UPDATE one?
> > >> >
> > >> > The meaning of pm_qos_update_target is 'update the PM QoS target
> > >> > constraints lists'. As described in the changelog the intention of
> > >> > this patch is to implement the constraints lists management logic in
> > >> > update_target and simplify the API functions (add/update/remove). It
> > >> > is also exported for the upcoming (patch 06/15]) to use it as well.
> > >>
> > >> The enums are fine by me and they allow us to simplify the code
> > >> quite a bit.
> > >>
> > > Ok, but they look a bit sloppy to me as we now have an API that says
> > > "add" we can actually pass in an enum that says "remove".
> > We have an API that says 'update target' that we pass in a parameter
> > that says 'add request', 'update request' or 'remove request'.
> > If it is required I could just rename the internal function
> > update_target, in a later patch.
> 
> You are right.  I thought I saw the enum added to the other API's for
> some reason.  Still, with this update we have an API overloaded through
> that enum parameter providing 2 add, 2 delete and 2 update API's  Each
> pair doing about the same thing.
> 
> To me it feels like a baby step toward an ioctl type of API that I don't
> like.  I'm not going to fight about it any more but I don't like such
> API's as they tend to get hard to read and get out of control.
> 
> please rethink this a little.

For real _users_, the API is still "add", "update" and "remove",
but _internally_ those functions use the same "worker" routine with an
argument specifying the operation to carry out.  This reduces code
duplication quite a bit and it quite common in the kernel.

Thanks,
Rafael
