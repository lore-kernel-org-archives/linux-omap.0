From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Subject: RE: Booting recent mainline on omap5-uevm
Date: Tue, 24 Sep 2013 23:59:33 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458E05BDB@US01WEMBX2.internal.synopsys.com>
References: <A2CA0424C0A6F04399FB9E1CD98E030458E05AC1@US01WEMBX2.internal.synopsys.com>
 <52421139.1090005@ti.com> <524224CC.5010707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:38182 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab3IXX7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 19:59:35 -0400
In-Reply-To: <524224CC.5010707@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Suman Anna [mailto:s-anna@ti.com]
> Sent: Tuesday, September 24, 2013 4:48 PM
> 
> On 09/24/2013 05:24 PM, Santosh Shilimkar wrote:
> > On Tuesday 24 September 2013 04:30 PM, Paul Zimmerman wrote:
> >>> From: Paul Zimmerman
> >>> Sent: Tuesday, September 24, 2013 1:21 PM
> >>>
> >>> Hi,
> >>>
> >>> I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
> >>> (tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
> >>> which comes with 3.8.4 which works fine.
> >>>
> >>> I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
> >>
> >> Wrong link, should have been http://marc.info/?l=linux-omap&m=137515583214350.
> >>
> > Its because of commit 03ab349ec{ARM: OMAP5: hwmod data: Add mailbox data} which
> > added hwmod data but DT data for mailbox is missing. Reverting that makes
> > things work. Looks like mailbox dt patches missed the last merge window.
> 
> Yeah, the boot sequence tries to enable and idle all the hwmods, and
> this results in an error while initializing the mailbox hwmod during the
> sysc configuration. This is because the OMAP5 hwmod data file no longer
> has the omap_hwmod_addr_space defined in the hwmod_ocp_if data. Two ways
> for now to get past is either revert the mailbox hwmod commit as above
> or add the DT node [2].
> 
> I will be respinning the mailbox DT series very soon targeting 3.13, so
> should not be an issue when OMAP5 boot is supported directly on mainline.

That's good info, but unfortunately it didn't work for me. I must have a
different problem, maybe I need a newer version of u-boot.

So there is no README or wiki that explains how to get Linux to boot on
this board? Is there perhaps a prebuilt SD card image somewhere with a
recent kernel that I can grab?

-- 
Paul

