From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/17] OMAP3: Base support for VDD2 DVFS
Date: Tue, 13 Jan 2009 09:13:47 -0800
Message-ID: <871vv7ku2c.fsf@deeprootsystems.com>
References: <1231515945-10234-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:43142 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbZAMRNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 12:13:54 -0500
Received: by ug-out-1314.google.com with SMTP id 39so295931ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 09:13:52 -0800 (PST)
In-Reply-To: <1231515945-10234-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  9 Jan 2009 17\:45\:28 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Resending this set against the latest PM branch. This set provides base
> SDRC + SRAM + clock framework support for VDD2 DVFS control. Main reasoning
> for this set is that when VDD2 clock is changed, memory clocking changes also
> and you need to be rather careful when you are doing this.

Pulling this into PM branch for more testing.

BUT.... this series has few (if any) dependencies on other PM branch
code.  I would like to se this rebased against l-o and submitted for
direct merge.

Kevin
