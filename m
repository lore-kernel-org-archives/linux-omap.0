From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under DVFS+SR operation
Date: Wed, 17 Mar 2010 11:01:48 -0700
Message-ID: <87pr32q12r.fsf@deeprootsystems.com>
References: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36179 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab0CQSBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 14:01:51 -0400
Received: by pva4 with SMTP id 4so687631pva.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 11:01:51 -0700 (PDT)
In-Reply-To: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com> (Vishwanath BS's message of "Thu\, 11 Mar 2010 18\:46\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Shweta Gulati <shweta.gulati@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
> running DSP codec was earlier restricted as DSP crashed.
> The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> The solution is to make sure DPLL1/DPLL2 bypass clock is always less than 
> maximum supported frequency for the specific OPP
>
> Tested on 3630 ZOOM3.
>
> changes in V2 : Rebased to new OPP implementation
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---

This should be broken up into two parts.  One that applies to mainline
(or l-o master), and another that fixes SRF that can be applied to PM
branch.  The first will be targted for mainline, but the SRF change
will be only in PM branch, as SRF is deprecated and will be replaced.

That being said, the approach in this patch is not the right approach.
It appears to completely ignore the min/max dividers that are already
managed by the clock/DPLL code.

Please add this support by modifying/extending the existing clock/DPLL
management code instead of manually writing registers.

Kevin
