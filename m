From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle support in
 clkops
Date: Mon, 14 Feb 2011 09:50:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102140949120.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
 <ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42174 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab1BNQuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:50:12 -0500
In-Reply-To: <ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> A couple of issues on the clk_autoidle_a_2.6.39 branch:
> -1- There seems to be a missing fix which causes an abort
> at boot on omap4
> http://marc.info/?l=linux-omap&m=129768574027232&w=2

This should be fixed now that this branch is rebased on your first two 
clock patches.

> -2- There is a trivial fix (Patch below) needed which otherwise
> breaks build

Thanks for this, I've folded this fix into the original patch.


- Paul
