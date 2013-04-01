From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PRCM fixes for 3.10
Date: Mon, 1 Apr 2013 08:55:51 -0700
Message-ID: <20130401155551.GF10155@atomide.com>
References: <alpine.DEB.2.00.1304011042310.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19690 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758313Ab3DAPzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 11:55:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304011042310.28273@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130401 03:48]:
> Hi Tony
> 
> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> 
>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.10
> 
> for you to fetch changes up to 469d633d20c774ecd34ac615c838193e1e150c62:
> 
>   ARM: OMAP: dpll: enable bypass clock only when attempting dpll bypass (2013-03-31 20:43:06 -0600)
> 
> ----------------------------------------------------------------
> Some miscellaneous OMAP hwmod, powerdomain, and clock fixes for 3.10.
> 
> Basic test logs are here:
> 
> http://www.pwsan.com/omap/testlogs/prcm_fixes_a_3.10/20130331205716/

Thanks applying into omap-for-v3.10/fixes-non-critical.

Regards,

Tony
