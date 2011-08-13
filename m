From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/15] PM QoS: re-organize data structs
Date: Sat, 13 Aug 2011 22:58:49 +0200
Message-ID: <201108132258.49283.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <1313075212-8366-5-git-send-email-j-pihet@ti.com> <20110813025629.GD639@gvim.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39283 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab1HMU5L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Aug 2011 16:57:11 -0400
In-Reply-To: <20110813025629.GD639@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>
Cc: jean.pihet@newoldbits.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>

On Saturday, August 13, 2011, mark gross wrote:
> On Thu, Aug 11, 2011 at 05:06:41PM +0200, jean.pihet@newoldbits.com wrote:
> > From: Jean Pihet <j-pihet@ti.com>
> > 
> > In preparation for the per-device constratins support, re-organize
> > the data strctures:
> > - add a struct pm_qos_constraints which contains the constraints
> > related data
> > - update struct pm_qos_object contents to the PM QoS internal object
> > data. Add a pointer to struct pm_qos_constraints
> > - update the internal code to use the new data structs.
> > 
> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > ---
> >  include/linux/pm_qos.h |   19 ++++++++++
> >  kernel/power/qos.c     |   90 ++++++++++++++++++++++-------------------------
> >  2 files changed, 61 insertions(+), 48 deletions(-)
> > 
> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> > index 6b0968f..9772311 100644
> > --- a/include/linux/pm_qos.h
> > +++ b/include/linux/pm_qos.h
> > @@ -25,6 +25,25 @@ struct pm_qos_request {
> >  	int pm_qos_class;
> >  };
> >  
> > +enum pm_qos_type {
> > +	PM_QOS_UNITIALIZED,
> what is this for?

I seem to remember discussing that previously, but I can't recall what
it's for.  Jean?
