From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] scheduler: Extract cgroups_cpuaccount code from
 sched.c into own file
Date: Wed, 19 May 2010 12:27:57 +0200
Message-ID: <1274264877.5605.10541.camel@twins>
References: <1274232620-23003-1-git-send-email-mike@android.com>
	 <1274232620-23003-4-git-send-email-mike@android.com>
	 <201005191130.42851.trenn@suse.de>  <1274261856.5605.10439.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56060 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab0ESK2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 06:28:35 -0400
In-Reply-To: <1274261856.5605.10439.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Mike Chan <mike@android.com>, khilman@deeprootsystems.com, menage@google.com, balbir@in.ibm.com, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mingo@elte.hu, lizf@cn.fujitsu.com, containers@lists.linux-foundation.org

On Wed, 2010-05-19 at 11:37 +0200, Peter Zijlstra wrote:
> On Wed, 2010-05-19 at 11:30 +0200, Thomas Renninger wrote:
> >=20
> > This is a cleanup against current linux-2.6 Linus tree.
> >    =20
> > Having CONFIG_CGROUP_CPUACCT code in kernel/sched.c looks wrong.
> > Move this out to kernel/cgroup_cpuaccount.c
> >    =20
> > Test compiled with and without CONFIG_CGROUP_CPUACCT set on x86_64.
>=20
> Sure, works for me, less code to look at :-)


In file included from /mnt/build/linux-2.6/kernel/sched.c:1908:
/mnt/build/linux-2.6/kernel/sched_fair.c: In function =E2=80=98update_c=
urr=E2=80=99:
/mnt/build/linux-2.6/kernel/sched_fair.c:544: error: implicit declarati=
on of function =E2=80=98cpuacct_charge=E2=80=99
  CC      kernel/sysctl_binary.o
/mnt/build/linux-2.6/kernel/sched.c: In function =E2=80=98account_user_=
time=E2=80=99:
/mnt/build/linux-2.6/kernel/sched.c:3265: error: implicit declaration o=
f function =E2=80=98cpuacct_update_stats=E2=80=99
/mnt/build/linux-2.6/kernel/sched.c:3265: error: =E2=80=98CPUACCT_STAT_=
USER=E2=80=99 undeclared (first use in this function)
/mnt/build/linux-2.6/kernel/sched.c:3265: error: (Each undeclared ident=
ifier is reported only once
/mnt/build/linux-2.6/kernel/sched.c:3265: error: for each function it a=
ppears in.)
/mnt/build/linux-2.6/kernel/sched.c: In function =E2=80=98account_syste=
m_time=E2=80=99:
/mnt/build/linux-2.6/kernel/sched.c:3332: error: =E2=80=98CPUACCT_STAT_=
SYSTEM=E2=80=99 undeclared (first use in this function)
make[2]: *** [kernel/sched.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [kernel/] Error 2
make: *** [sub-make] Error 2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
