From: Jean Pihet <jpihet@mvista.com>
Subject: Re: PM branch updated
Date: Mon, 10 Aug 2009 10:26:07 +0200
Message-ID: <200908101026.07364.jpihet@mvista.com>
References: <87d479921p.fsf@deeprootsystems.com> <200908071029.30047.jpihet@mvista.com> <87ws5f35xj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:37392 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZHJI0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 04:26:46 -0400
In-Reply-To: <87ws5f35xj.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Friday 07 August 2009 19:11:20 Kevin Hilman wrote:
> Jean Pihet <jpihet@mvista.com> writes:
> > On Thursday 06 August 2009 19:13:06 Kevin Hilman wrote:
> >> Kevin Hilman wrote:
> >> > I just pushed an updated PM branch which was rebased to current
> >> > omap/master (which is based on v2.6.31-rc5)
> >>
> >> Also, please check out
> >>
> >>    http://elinux.org/OMAP_Power_Management
> >>
> >> This page includes the stuff I normally put in the announcment of a new
> >> PM branch, but also tries to describe how to use the various features of
> >> the PM branch (which has been sorely missing for a while.)
> >
> > I think this page had been long-awaited. Thanks a lot for putting it
> > together.
> >
> > One question about it:
> >
> > What about the cpufreq interface for doing DVFS? Is it preferred way
> > to change OPPs or is it using /sys/power/vddx_opp? I think cpufreq
> > utils are more standard, easier to use and to understand.
>
> CPUfreq is much preferred.  The /sys/power/vdd* are just for manual
> testing and more fore PM developers than PM users.
Ok, thanks for the confirmation.

> Hey, sounds like a perfect opportunity for you to update the wiki. ;)
Exactly! http://elinux.org/OMAP_Power_Management has been updated with 
per-feature usage, CPUfreq kernel interface and debugging info for power 
users ;p

Can you check it?

>
> Kevin
Jean
