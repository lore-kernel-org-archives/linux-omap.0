From: Jean Pihet <jpihet@mvista.com>
Subject: Re: PM branch updated
Date: Fri, 7 Aug 2009 10:29:29 +0200
Message-ID: <200908071029.30047.jpihet@mvista.com>
References: <87d479921p.fsf@deeprootsystems.com> <4A7B0F22.7030103@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:48774 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025AbZHGJBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:01:01 -0400
In-Reply-To: <4A7B0F22.7030103@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Thursday 06 August 2009 19:13:06 Kevin Hilman wrote:
> Kevin Hilman wrote:
> > I just pushed an updated PM branch which was rebased to current
> > omap/master (which is based on v2.6.31-rc5)
>
> Also, please check out
>
>    http://elinux.org/OMAP_Power_Management
>
> This page includes the stuff I normally put in the announcment of a new
> PM branch, but also tries to describe how to use the various features of
> the PM branch (which has been sorely missing for a while.)
I think this page had been long-awaited. Thanks a lot for putting it together.

One question about it:
What about the cpufreq interface for doing DVFS? Is it preferred way to change 
OPPs or is it using /sys/power/vddx_opp? I think cpufreq utils are more 
standard, easier to use and to understand.

Jean
>
> Comments/feedback welcome, and feel free to update/edit as well.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


