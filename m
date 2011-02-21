From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap3: Adding vdd_sdi regulator supply to OMAP3EVM
Date: Mon, 21 Feb 2011 11:08:15 +0200
Message-ID: <1298279295.4931.31.camel@deskari>
References: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50696 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab1BUJIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 04:08:21 -0500
In-Reply-To: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, kernel-team@lists.ubuntu.com

Hi,

On Thu, 2011-02-17 at 08:11 +0000, Bryan Wu wrote:
> From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
> 
> https://bugs.launchpad.net/bugs/630885
> 
> When booting, the omapdss subsystem is looking for a regulator named
> "vdds_sdi". When the regulator is not found the initialisation sequence
> is aborted resulting in omapfb not finding a display to work with.  This
> patch allows the omapfb sub system to complete its initialisation
> properly and enable LCD display. The problem was fixed by lumping a
> "vdds_sdi" with the already existing "vdds_dsi" regulator. This fix
> takes its root from work done on the Beagle board and the Pandora board.

This isn't a correct fix.

If we would add the sdi regulator to remove the problem we would need to
add the sdi regulator to all boards, not just EVM.

However, I wouldn't go adding them. The proper fix is to make sdi.c only
use the regulator if SDI is actually used. Currently it tries to acquire
it always.

A simple "fix" for this is to disable SDI from Kconfig, presuming you
don't have boards that use SDI interface. N900 is the only board that I
know of which uses SDI.

 Tomi


