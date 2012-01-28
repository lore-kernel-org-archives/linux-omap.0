From: <Madhusudhan.Gowda@elektrobit.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Sat, 28 Jan 2012 09:58:14 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com>
References: <87liw8agk4.fsf@ti.com> <AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com> <20120127190239.GC9339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:48730 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751788Ab2A1H6Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Jan 2012 02:58:24 -0500
Received: from fioumg02.ebgroup.elektrobit.com (smtpgw2fi.ebgroup.elektrobit.com [127.0.0.1])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id q0S7wLEd012286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 28 Jan 2012 09:58:21 +0200
Received: (from defang@localhost)
	by fioumg02.ebgroup.elektrobit.com (8.13.8/8.13.8/Submit) id q0S7wG8P012282
	for <linux-omap@vger.kernel.org>; Sat, 28 Jan 2012 09:58:16 +0200
Content-class: urn:content-classes:message
In-Reply-To: <20120127190239.GC9339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Thanks Tony

Hi Kevin 
Please do the needful and pull the same.

Best Regards
Gowda


-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org
[mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Tony
Lindgren
Sent: 27 January 2012 21:03
To: Gowda Madhusudhan
Cc: Kevin Hilman; linux-omap@vger.kernel.org;
linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3

Hi,

* Madhusudhan.Gowda@elektrobit.com <Madhusudhan.Gowda@elektrobit.com>
[120127 10:25]:
> Hi Tony,
> 
> Please pull the PM EMU off mode fix for v3.3

It's best that Kevin queues this as it affects PM. Or it at least needs
an ack from Kevin.

Regards,

Tony
 
> Thanks
> Gowda
> 
> The following changes since commit
> 1c6ece3c23e58d0dbc687407d606f3560ded582a:
> 
>   Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6
> (2012-01-26 16:48:37 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/elektrobit/linux.git linux-omap-emu-fix
> 
> Madhusudhan Gowda (1):
>       ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
> 
>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
>  arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
>  arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> 
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information intended

> solely for the addressee. If you have received this e-mail in error, 
> please do not disclose it to anyone, notify the sender promptly, and 
> delete the message from your system.
> Thank you.
> 
