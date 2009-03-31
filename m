From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: PM branch rebased to 2.6.29... for real this time
Date: Tue, 31 Mar 2009 20:25:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com>
References: <87k56dp5zc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45616 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757962AbZCaO4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 10:56:12 -0400
In-Reply-To: <87k56dp5zc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, March 26, 2009 4:26 AM
> To: linux-omap@vger.kernel.org
> Subject: PM branch rebased to 2.6.29... for real this time
> 
> Hello,
> 
> The previous rebase was actually to 2.6.29-rc8.  Now that 2.6.29 is
> out, I've rebased the PM brach onto linux-omap HEAD just after the
> 2.6.29 merge.
> 
> Minimal retention and off-mode on Beagle and RX51.

Another problem that I found on OMAP3EVM:

When I compiled in CPUidle and CPUfreq (over omap3_evm_defconfig),
the kernel did not boot-up. The last few statements are:

<3>clock: dpll5_ck failed transition to 'locked'
clock: dpll5_ck failed transition to 'locked'
<6>Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll4_m6x2_ck"
<6>Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
<6>Disabling unused clock "sys_clkout1"
Disabling unused clock "sys_clkout1"

The PC is at the WFI statement.

Tried other combinations as well:

1) only CPUidle enabled - okay.
2) only CPUfreq enabled - not okay.

Best regards,
Sanjeev
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 