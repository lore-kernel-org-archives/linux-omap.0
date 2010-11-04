From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/4] PERF: fix power:cpu_idle double end events
Date: Thu, 4 Nov 2010 09:57:35 +0100
Message-ID: <201011040957.35611.trenn@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de> <201010271742.04545.trenn@suse.de> <1288599088.2712.47.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54149 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab0KDI5j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 04:57:39 -0400
In-Reply-To: <1288599088.2712.47.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert =?utf-8?q?Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org

Hi Robert,

On Monday 01 November 2010 09:11:28 Robert Sch=C3=B6ne wrote:
> Am Mittwoch, den 27.10.2010, 17:42 +0200 schrieb Thomas Renninger:
>=20
> > Robert: I expect you tested this on a machine with no cpuidle
> > driver registered?
>=20
> You're right, there was no idle driver, but the idle process from
> process_64.c which called the idle routine.
> I reported my thoughts on this on 14th of May this year 2010, mostly
> claiming for a standard on where to report these events.
>=20
> You're also missing the other idle routines from x86/kernel/process.c
> mwait_idle_with_hints and mwait_idle only throw start events, so they
> should behave like default_idle. poll_idle on the other hand reports
> the end event itself.
I added you to CC of a patch that fixes the issue (and all other double=
=20
or missing (for acpi_idle driver) events) in a nice generic way.
It needs further userspace adjustings and I still wait for this
separate patch series to go into some branch.

Thanks,

   Thomas


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
