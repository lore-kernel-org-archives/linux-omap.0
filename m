From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power domains next
 state
Date: Fri, 29 Jul 2011 11:00:47 -0700
Message-ID: <20110729180047.GA14228@google.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
 <1311841821-10252-9-git-send-email-j-pihet@ti.com>
 <20110729075942.GA26959@google.com>
 <CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:55919 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab1G2SBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 14:01:38 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 29, 2011 at 10:47:43AM +0200, Jean Pihet wrote:
> On Fri, Jul 29, 2011 at 9:59 AM, Todd Poynor <toddpoynor@google.com> wrote:
...
> > All min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
> > free_new_user = 1.
> free_new_user = 1 is only needed if no existing constraint has been
> found, i.e. user stays at NULL. This is implemented in the check for
> an existing constraint (plist_for_each_entry(...)).

Oops, I meant to say it applies in all cases where min_latency ==
PM_QOS_DEV_LAT_DEFAULT_VALUE, since the new node is only used for
adding a constraint (and no existing constraint found).  I'd suggest
something like:

        if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
                new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
                        GFP_KERNEL);
                <check NULL return>
                free_new_user = 1;
        }

and then set free_new_user = 0 only if no existing constraint is found
for the add case.  Because it's easy to miss cases where the
allocated memory needs to be freed when that's not the default, and you
might as well skip the allocate on a constraint removal.  Pretty minor
point, though.


Todd
