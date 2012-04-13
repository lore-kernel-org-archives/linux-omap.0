From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] Fixes in preparation for enabling Dsp in omap4
Date: Fri, 13 Apr 2012 16:02:15 -0700
Message-ID: <87fwc744nc.fsf@ti.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
	<CADVn9RG_WFh3d8P=cfC_O_5vbvE0YELDwbJL66uqO2My8D4bzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58035 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754586Ab2DMXCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 19:02:16 -0400
Received: by pbcxa12 with SMTP id xa12so4884748pbc.37
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 16:02:15 -0700 (PDT)
In-Reply-To: <CADVn9RG_WFh3d8P=cfC_O_5vbvE0YELDwbJL66uqO2My8D4bzQ@mail.gmail.com>
	(Juan Gutierrez's message of "Fri, 13 Apr 2012 16:53:07 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gutierrez, Juan" <jgutierrez@ti.com>
Cc: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s-anna@ti.com

"Gutierrez, Juan" <jgutierrez@ti.com> writes:

> This set of patches provides the foundation for enabling
> OMAP4 Dsp (Tesla) as remote processor.

Looks like this series suffers from space/tab and various whitespace
problems.  

Please run them through scripts/checkpatch.pl, or possibly your mailer
is mangling them.

Kevin
