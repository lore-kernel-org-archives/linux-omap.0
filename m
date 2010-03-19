From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Fri, 19 Mar 2010 12:34:04 +0530
Message-ID: <009c01cac732$5d237ee0$518918ac@apr.dhcp.ti.com>
References: <1268407891-22559-1-git-send-email-leslyam@ti.com> <87eijhgqe4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40440 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab0CSHEN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 03:04:13 -0400
In-Reply-To: <87eijhgqe4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi Kevin,

If my understanding is correct.

The clk_setuptime is board specific, depends on the osc/XTAL used on	the
board. So the clk_setuptime has to come from the board file.

Volt_setuptime & volt_offset is PM IC specific, depends on the PM IC's SMPS
characteristics. So this can be updated from the script file.

Finally the voltage cmd values (on, onlp, ret &off) is Si Specific, Varies
with Si(OMAP3430, OMAP3630, ...). So can be updated in voltage file itself.

Just correct if I'm wrong.

Thanks & Regards,
Lesly A M

-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: Friday, March 19, 2010 5:00 AM
To: Lesly A M
Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
Samuel Ortiz
Subject: Re: [PATCH v3 2/5] omap3: pm: Using separate clk/volt setup_time
for RET and OFF states

Lesly A M <leslyam@ti.com> writes:

> Copied the setuptime in each board file, since OMAP3430 & OMAP3630
> has different voltage levels for the same states.

So that suggests there should be 2 tables (one per SoC), rather than
one for each board file.  IOW, the setup times are SoC specific, not
board specific, so they don't belong in board files.

Kevin

