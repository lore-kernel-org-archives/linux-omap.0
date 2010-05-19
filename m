From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/4] omap: cpu: Power tracking support for cgroup cpuacct
Date: Wed, 19 May 2010 17:34:27 +0200
Message-ID: <201005191734.27887.trenn@suse.de>
References: <1274232620-23003-1-git-send-email-mike@android.com> <1274232620-23003-5-git-send-email-mike@android.com> <4BF3E367.5080906@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59553 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab0ESPd0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 11:33:26 -0400
In-Reply-To: <4BF3E367.5080906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mike Chan <mike@android.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "menage@google.com" <menage@google.com>, "balbir@in.ibm.com" <balbir@in.ibm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 19 May 2010 15:11:03 Nishanth Menon wrote:
> Mike Chan had written, on 05/18/2010 08:30 PM, the following:
> > Specify new power field in struct omap_opp, which is
> > power exported in milliWatt.
...
> > +		totalpower += cpuacct_freq[i] * mpu_opps[i + 1].power;
...
> > +	unsigned long power; /* power consumed running at OPP in 
milliWatts */
> 
> this conflicts with the OPP layer implementation. this structure will 
> disappear for good.
Ah yes, another question:
The power variable in struct omap_opp never gets initialized
with a sane value, something is wrong...

     Thomas
