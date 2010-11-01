From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 4/4] PERF: fix power:cpu_idle double end events
Date: Mon, 01 Nov 2010 09:11:28 +0100
Message-ID: <1288599088.2712.47.camel@localhost>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
	 <1288136605-10526-5-git-send-email-trenn@suse.de>
	 <201010271742.04545.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:39695 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754727Ab0KAIlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 04:41:17 -0400
In-Reply-To: <201010271742.04545.trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org

Am Mittwoch, den 27.10.2010, 17:42 +0200 schrieb Thomas Renninger:

> Robert: I expect you tested this on a machine with no cpuidle
> driver registered?

You're right, there was no idle driver, but the idle process from
process_64.c which called the idle routine.
I reported my thoughts on this on 14th of May this year 2010, mostly
claiming for a standard on where to report these events.

You're also missing the other idle routines from x86/kernel/process.c
mwait_idle_with_hints and mwait_idle only throw start events, so they
should behave like default_idle. poll_idle on the other hand reports the
end event itself.

Robert

