From: Tomasz =?utf-8?Q?M=C5=82oduchowski?=
	<tomasz.mloduchowski@xlogic.pl>
Subject: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Sat, 09 Apr 2011 17:27:20 +0200 (CEST)
Message-ID: <58ae76c6-267f-4f94-a97a-ffff366afff2@zimbra.xlogic.pl>
References: <415d270a-fb0c-447b-8f5e-47dba14f0078@zimbra.xlogic.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 81-18-210-90.static.chello.pl ([81.18.210.90]:33346 "EHLO
	mail.xlogic.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab1DIPnx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Apr 2011 11:43:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.xlogic.pl (Postfix) with ESMTP id EE54219A154
	for <linux-omap@vger.kernel.org>; Sat,  9 Apr 2011 17:27:21 +0200 (CEST)
Received: from mail.xlogic.pl ([127.0.0.1])
	by localhost (mail.xlogic.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUPIhm3RXzK7 for <linux-omap@vger.kernel.org>;
	Sat,  9 Apr 2011 17:27:20 +0200 (CEST)
Received: from mail.xlogic.pl (zimbra.xlogic.pl [81.18.210.90])
	by mail.xlogic.pl (Postfix) with ESMTP id 4FC2C19A01B
	for <linux-omap@vger.kernel.org>; Sat,  9 Apr 2011 17:27:20 +0200 (CEST)
In-Reply-To: <415d270a-fb0c-447b-8f5e-47dba14f0078@zimbra.xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

Is there a way to diagnose why the omapdss fails to scale ovl 0?

[ 2470.719604] omapdss OVERLAY: check_overlay 0: (0,0 1280x768 -> 1360x768) disp (1360x768)
[ 2470.719635] omapdss MANAGER: omap_dss_mgr_apply(lcd)
[ 2470.719665] omapdss OVERLAY: check_overlay 0: (0,0 1280x768 -> 1360x768) disp (1360x768)
[ 2470.719726] omapdss MANAGER: configure_overlay(0)
[ 2470.719757] omapdss DISPC: dispc_setup_plane 0, pa 86800000, sw 1280, 0,0, 1280x768 -> 1360x768, ilace 0, cmode 80, rot 0, mir 0 chan 0
[ 2470.719787] omapdss MANAGER error: dispc_setup_plane failed for ovl 0
[ 2470.726593] omapdss DISPC: dispc_enable_plane 0, 0

Cheers,
Tomasz
