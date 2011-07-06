From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/5] OMAP4: prcm: Fix errors in few defines name
Date: Tue, 5 Jul 2011 23:57:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052357190.4217@utopia.booyaka.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com> <1309552060-4547-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1GFF56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:57:58 -0400
In-Reply-To: <1309552060-4547-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> A couple of macros were wrongly changed during the _MOD to _INST
> rename done in the following commit:
> 
>   OMAP4: PRCM: rename _MOD macros to _INST
>   cdb54c4457d68994da7c2e16907adfbfc130060d
> 
> Fix them to their original name.
> 
> Some CM and PRM instances were not well aligned. Align them.
> 
> Remove one blank line in cm2_44xx.h to align the output with
> the other (cm1_44xx.h, prm44xx.h) files.
> 
> Update header copyright date.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>


Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.


- Paul
