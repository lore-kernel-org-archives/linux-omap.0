From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/15] PM QoS: re-organize data structs
Date: Sun, 14 Aug 2011 15:34:10 +0200
Message-ID: <201108141534.10482.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <201108132258.49283.rjw@sisk.pl> <CAORVsuWHCf3EuQfpCGGSxxUc-K5e1dM2KDf8z5avPpQ=+V1DFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40017 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab1HNNca (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Aug 2011 09:32:30 -0400
In-Reply-To: <CAORVsuWHCf3EuQfpCGGSxxUc-K5e1dM2KDf8z5avPpQ=+V1DFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>

On Sunday, August 14, 2011, Jean Pihet wrote:
> Rafael, Mark,
> 
> On Sat, Aug 13, 2011 at 10:58 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, August 13, 2011, mark gross wrote:
> >> On Thu, Aug 11, 2011 at 05:06:41PM +0200, jean.pihet@newoldbits.com wrote:
> >> > From: Jean Pihet <j-pihet@ti.com>
> >> >
> >> > In preparation for the per-device constratins support, re-organize
> >> > the data strctures:
> >> > - add a struct pm_qos_constraints which contains the constraints
> >> > related data
> >> > - update struct pm_qos_object contents to the PM QoS internal object
> >> > data. Add a pointer to struct pm_qos_constraints
> >> > - update the internal code to use the new data structs.
> >> >
> >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> > ---
> >> >  include/linux/pm_qos.h |   19 ++++++++++
> >> >  kernel/power/qos.c     |   90 ++++++++++++++++++++++-------------------------
> >> >  2 files changed, 61 insertions(+), 48 deletions(-)
> >> >
> >> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> >> > index 6b0968f..9772311 100644
> >> > --- a/include/linux/pm_qos.h
> >> > +++ b/include/linux/pm_qos.h
> >> > @@ -25,6 +25,25 @@ struct pm_qos_request {
> >> >     int pm_qos_class;
> >> >  };
> >> >
> >> > +enum pm_qos_type {
> >> > +   PM_QOS_UNITIALIZED,
> >> what is this for?
> >
> > I seem to remember discussing that previously, but I can't recall what
> > it's for.  Jean?
> >
> 
> Sorry it is a left over from the previous version, it has been used to
> detect non initialized data structs.
> It is still used to detect an error in pm_qos_get_value and so by its
> callers pm_qos_update_target and pm_qos_power_read. I have to admit
> the usefulness is quite limited.
> 
> Is the removal of PM_QOS_UNITIALIZED needed? I would say no.

I agree.

Thanks,
Rafael
