From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 1/4] omap: voltage: add a stub header file
Date: Fri, 05 Aug 2011 12:35:34 -0700
Message-ID: <87r54zslbt.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:52257 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753200Ab1HETfi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 15:35:38 -0400
Received: by mail-pz0-f47.google.com with SMTP id 2so4730492pzk.34
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 12:35:37 -0700 (PDT)
In-Reply-To: <1311853739-18984-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 28 Jul 2011 14:48:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Needed as some of the voltage layer functionality is accessed from the
> SMPS regulator driver.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Looks good, I'll add this to my pm-wip/voltdm branch.

Kevin
