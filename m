From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq table
Date: Tue, 24 May 2011 20:49:12 +0200
Message-ID: <201105242049.13044.rjw@sisk.pl>
References: <1306192335-19883-1-git-send-email-nm@ti.com> <20110524000549.GA20225@google.com> <BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53061 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1EXSsr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 14:48:47 -0400
In-Reply-To: <BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Todd Poynor <toddpoynor@google.com>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>

On Tuesday, May 24, 2011, Menon, Nishanth wrote:
> On Mon, May 23, 2011 at 19:05, Todd Poynor <toddpoynor@google.com> wrote:
> > On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
> >> cpufreq table allocated by opp_init_cpufreq_table is better
> >> freed by OPP layer itself. This allows future modifications to
> >> the table handling to be transparent to the users.
> > ...
> >> +void opp_free_cpufreq_table(struct device *dev,
> >> +                             struct cpufreq_frequency_table **table)
> >> +{
> >> +     if (!table)
> >> +             return;
> >> +
> >> +     /* Pretend as if I am an updater */
> >> +     mutex_lock(&dev_opp_list_lock);
> >> +     kfree(*table);
> >> +     *table = NULL;
> >> +     mutex_unlock(&dev_opp_list_lock);
> >> +}
> >
> > Not clear what the mutex protects here.  Currently it protects only
> > device opp list modifications.  opp_init_cpufreq_table holds the lock only
> > while looking up and walking the device opp list; the cpufreq table it
> > creates is not complete by the time the lock is dropped.
> 
> hmm.. right.. mutex protection does'nt really make sense here..

Care to post an updated patch?

Rafael
