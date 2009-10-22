From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Thu, 22 Oct 2009 04:24:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910220419550.17644@utopia.booyaka.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com> <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58648 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbZJVKX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 06:23:58 -0400
In-Reply-To: <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, girishsg@ti.com, hiroshi.doyu@nokia.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Tero, Ameya, Girish,

On Fri, 16 Oct 2009, Tero Kristo wrote:

> From: Tero Kristo <tero.kristo@nokia.com>
> 
> IVA2 controls its target power state individually, thus suspend should not
> touch IVA2. Without this patch DSP suspend always fails.

We don't allow other device drivers to touch PRCM bits, so we should 
probably should remove all PRCM register accesses from the DSPBridge code, 
so all power control should go through the ARM.

Is there a reason why the ARM code can't handle the DSP powerdomain?


- Paul
