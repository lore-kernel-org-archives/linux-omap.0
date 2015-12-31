From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH] thermal: Schedule a backup thermal shutdown
 workqueue after a known period of time to tackle failed poweroff
Date: Thu, 31 Dec 2015 09:29:07 -0800
Message-ID: <20151231172906.GB11863@localhost.localdomain>
References: <1450676778-7840-1-git-send-email-j-keerthy@ti.com>
 <5681742C.8050805@ti.com>
 <56824F81.7000202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56824F81.7000202@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, linux-omap@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

can we have a shorter title?

On Tue, Dec 29, 2015 at 02:46:49PM +0530, Keerthy wrote:
> Hi Nishanth,
> 

<cut> 
> >
> >I am not sure if this #ifdeffery is even needed.
> >
> >
> >Eduardo, Rui: If this is not the suggested technique, maybe you guys
> >could suggest how we could handle a case where userspace might be
> >hungup due to some reason and a case where a critical temperature
> >event in the middle of device probe was triggered?

Orderly power off is supposed to take care of this. Looking at the code,
it will force a shutdown in case execution of userland command fails:

static int __orderly_poweroff(bool force)
{
        int ret;

        ret = run_cmd(poweroff_cmd);

        if (ret && force) {
                pr_warn("Failed to start orderly shutdown: forcing the issue\n");

                /*
                 * I guess this should try to kick off some daemon to sync and
                 * poweroff asap.  Or not even bother syncing if we're doing an
                 * emergency shutdown?
                 */
                emergency_sync();
                kernel_power_off();
        }

> >
> >Obviously, we'd like to take into consideration userspace latencies as
> >well- but that is very specific to fs being run.. not really a simple
> >problem, IMHO..
> >
