From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 0/2] OMAP3: PM: CPUidle cstates names and descriptions
Date: Tue, 16 Feb 2010 13:58:17 +0200
Message-ID: <1266321499-11858-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46693 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab0BPL6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 06:58:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "\\\"Kristo Tero (Nokia-D/Tampere)\\\"" <Tero.Kristo@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello all,

Here is a patch set with minor changes to improve our current cpuidle
name convention and also to add some description about them.

Currently, depending on which Cstates are enabled/disabled,
there is a inconsistency between C-state name and what power domain
states it is supposed to reach when that C-state is selected.
Besides, there is no way to determine what each C-state is supposed to be,
from user space point of view.

So, these two minor changes, first, reports the power domain states inside
the desc node, and also uses a consistent name convention for each cstate,
based on power domain states.


BR,

Eduardo Valentin (2):
  OMAP3: PM: Add cpuidle C-state description information
  OMAP3: PM: Consistently report cpuidle C-state's names

 arch/arm/mach-omap2/cpuidle34xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

