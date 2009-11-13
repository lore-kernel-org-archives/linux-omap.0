From: Tony Lindgren <tony@atomide.com>
Subject: Some patches need reposting, inbox cleared, patchwork cleared
Date: Thu, 12 Nov 2009 16:38:51 -0800
Message-ID: <20091113003851.GN24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51024 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbZKMAit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:38:49 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1N8kBj-000Lfe-23
	for linux-omap@vger.kernel.org; Fri, 13 Nov 2009 00:38:55 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm finally done sorting through the patchwork patches to add to
the omap for-next queue. So I've nuked my linux-omap inbox, and
cleared the patches that I'm supposed to deal with in patchwork.

Please check that you patch is applied (or merged into some existing
patch) in the omap for-next branch.

If you don't see your patch in the omap for-next branch, and you
don't see the patch in the patchwork list, please repost your
patch. When reposting, please send the whole series again.

The patchwork pending patches are at:

http://patchwork.kernel.org/project/linux-omap/list/

I have not touched the patches in patchwork that are tagged for
felipebalbi, khilman or pwsan, so this message only concerns the
ones I'm supposed to deal with.

If you have lots of patches, you can also post a git branch that's
rebased on commit 8171d88089ad63fc442b2bf32af7c18653adc5cb.
Don't use the omap for-next for rebasing, as it's still changing.

I've dropped all the patches that did not apply to for-next,
or that have dependency to some other subsystem. I've commented
on few of the patches that don't apply, but not all of them.
Then some fix patches I've merged to the earlier patches,
and for those there's no APPLIED email message.

I've probably also accidentally trashed some perfectly valid
patches too.. So please check and repost as needed!

Cheers,

Tony
