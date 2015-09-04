From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] security: device_cgroup: fix RCU lockdep splat
Date: Thu, 3 Sep 2015 18:15:11 -0700
Message-ID: <20150904011511.GU4029@linux.vnet.ibm.com>
References: <20150902125608.GA8299@saruman.tx.rr.com>
 <1441199548-29633-1-git-send-email-balbi@ti.com>
 <20150902162450.GJ22326@mtj.duckdns.org>
 <20150903001433.GB4029@linux.vnet.ibm.com>
 <CA+5PVA6NrEhRfaFJgCmH6P3Wznme4W2bPk8=WgmmpM0WSbLjxA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA6NrEhRfaFJgCmH6P3Wznme4W2bPk8=WgmmpM0WSbLjxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Tejun Heo <tj@kernel.org>, Felipe Balbi <balbi@ti.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 03, 2015 at 09:56:05AM -0400, Josh Boyer wrote:
> On Wed, Sep 2, 2015 at 8:14 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Sep 02, 2015 at 12:24:50PM -0400, Tejun Heo wrote:
> >> cc'ing Paul.
> >>
> >> On Wed, Sep 02, 2015 at 08:12:28AM -0500, Felipe Balbi wrote:
> >> > while booting AM437x device, the following splat
> >> > triggered:
> >> >
> >> > [   12.005238] ===============================
> >> > [   12.009749] [ INFO: suspicious RCU usage. ]
> >> > [   12.014116] 4.2.0-next-20150831 #1154 Not tainted
> >> > [   12.019050] -------------------------------
> >> > [   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new_ex called without proper synchronization!
> >> ...
> >> > [   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcgroup_access_write+0x374/0x658)
> >> > [   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800>] (cgroup_file_write+0x28/0x1bc)
> >> > [   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (kernfs_fop_write+0xc0/0x1b8)
> >> > [   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__vfs_write+0x1c/0xd8)
> >> > [   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_write+0x90/0x16c)
> >> > [   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write+0x44/0x9c)
> >> > [   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_syscall+0x0/0x1c)
> >>
> >> This shouldn't be happening because devcgroup_access_write() always
> >> grabs devcgroup_mutex.  Looking at the log, the culprit seems to be
> >> f78f5b90c4ff ("rcu: Rename rcu_lockdep_assert() to
> >> RCU_LOCKDEP_WARN()").  It missed the bang for the second test while
> >> inverting it, so adding rcu_read_lock() isn't the right fix here.
> >>
> >> Paul, can you please fix it?
> >
> > Gah!  Please see below.
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > security/device_cgroup: Fix RCU_LOCKDEP_WARN() condition
> >
> > f78f5b90c4ff ("rcu: Rename rcu_lockdep_assert() to RCU_LOCKDEP_WARN()")
> > introduced a bug by incorrectly inverting the condition when moving from
> > rcu_lockdep_assert() to RCU_LOCKDEP_WARN().  This commit therefore fixes
> > the inversion.
> >
> > Reported-by: Felipe Balbi <balbi@ti.com>
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> 
> Just tested this patch without Felipe's previous version on all my
> machines.  The splat is indeed gone.
> 
> Tested-by: Josh Boyer <jwboyer@fedoraproject.org>

Thank you, added!

							Thanx, Paul

> josh
> 
> >
> > diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> > index 73455089feef..03c1652c9a1f 100644
> > --- a/security/device_cgroup.c
> > +++ b/security/device_cgroup.c
> > @@ -401,7 +401,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
> >         bool match = false;
> >
> >         RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
> > -                        lockdep_is_held(&devcgroup_mutex),
> > +                        !lockdep_is_held(&devcgroup_mutex),
> >                          "device_cgroup:verify_new_ex called without proper synchronization");
> >
> >         if (dev_cgroup->behavior == DEVCG_DEFAULT_ALLOW) {
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
