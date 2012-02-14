From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/2] ARM: OMAP4: cminst: Add boot time __init function for cminst
Date: Tue, 14 Feb 2012 22:11:32 +0100
Message-ID: <87bop1unln.fsf@macbook.be.48ers.dk>
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
	<1329233348-23356-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51901 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab2BNVPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 16:15:18 -0500
Received: by eaah12 with SMTP id h12so131000eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 13:15:17 -0800 (PST)
In-Reply-To: <1329233348-23356-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 14 Feb 2012 20:59:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> AM33xx CM module is closer to OMAP4 CM module, and
 Vaibhav> in order to reuse cminst api's we have to address
 Vaibhav> some of the differences like, base addresses and partitions.
 Vaibhav> Unlike OMAP4 CM, AM33xx doesn't have any partitions and
 Vaibhav> maintains only single partition.

 Vaibhav> So, in order to reuse the existing OMAP4 cminst code
 Vaibhav> for AM33xx this patch adds,

 Vaibhav>   - Boot time __init function, to initialize _cm_bases
 Vaibhav>     based on cpu_is_xxx
 Vaibhav>   - Instead of maintaining phy addr for CM partition
 Vaibhav>     in _cm_bases[] table and then changing it to virt addr,
 Vaibhav>     directly maintain respective virt addr.

 Vaibhav> @@ -103,19 +106,19 @@ static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 Vaibhav>  /* Read a register in a CM instance */
 Vaibhav>  u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 Vaibhav>  {
 Vaibhav> -	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 Vaibhav> +	BUG_ON(part >= max_cm_partitions ||
 Vaibhav>  	       part == OMAP4430_INVALID_PRCM_PARTITION ||

How about dropping the OMAP4430_ prefix here as it's no longer 4430 specific?

-- 
Bye, Peter Korsgaard
