From: dfoley <dfoley@telus.net>
Subject: Re: OMAP3EVM LCD red tint
Date: Sat, 08 Nov 2008 17:50:42 -0800
Message-ID: <491641F2.1070509@telus.net>
References: <48DD441F.6080106@timesys.com> <c656a4d20809270046u341aec27k6d896d4b42e799d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:49220 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbYKIBzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Nov 2008 20:55:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KyzW2-0007l1-Jv
	for linux-omap@vger.kernel.org; Sun, 09 Nov 2008 01:55:02 +0000
Received: from d75-157-1-34.bchsia.telus.net ([75.157.1.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 09 Nov 2008 01:55:02 +0000
Received: from dfoley by d75-157-1-34.bchsia.telus.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 09 Nov 2008 01:55:02 +0000
In-Reply-To: <c656a4d20809270046u341aec27k6d896d4b42e799d4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Daniel Schaeffer <daniel.schaeffer@timesys.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

arun c wrote:
> Try the patch below(Remember that you may have to manually edit because
> this patch is against current HEAD)

The patch works for me after I replace "system_rev" with "omap_rev()"
in the patch.

