From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2+: hwmod: remove link arrays
Date: Thu, 8 Mar 2012 21:27:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203082123540.26656@utopia.booyaka.com>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab2CIE12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 23:27:28 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


This series has been rebased on top of a merge of the hwmod_misc_devel_3.4 
branch and the hwmod_data_cleanup_3.4 branch, both previously posted.  
Fortunately the auto-merger came up with something reasonable.  Patches 5 
and 7 have been trivially updated to take account of the SmartReflex 
changes.  The updated series has been posted at:

http://www.pwsan.com/omap/patches-hwmod_remove_link_arrays_cleanup_3.4_2

since the two patches that changed were the ones that were too big to make 
it onto the lists.

The updated branch is in the same place as before: 
git://git.pwsan.com/linux-2.6 in the 
'hwmod_remove_link_arrays_cleanup_3.4' branch.


- Paul
