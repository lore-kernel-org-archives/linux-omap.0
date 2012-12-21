From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Fri, 21 Dec 2012 20:09:25 +0100
Message-ID: <87a9t78boa.fsf@dell.be.48ers.dk>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:64130 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2LUTJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 14:09:30 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so2971589wib.10
        for <linux-omap@vger.kernel.org>; Fri, 21 Dec 2012 11:09:28 -0800 (PST)
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Fri, 21 Dec 2012 09:28:00 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

>>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:

 Mark> From: "Mark A. Greer" <mgreer@animalcreek.com>
 Mark> [This series supersedes the hwmod related patches sent in the
 Mark>  "crypto: omap-sham updates" and "crypto: omap-aes updates"
 Mark>  series a few weeks ago.]

 Mark> This series adds hwmod support for the OMAP SHAM and AES
 Mark> modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
 Mark> adds device tree info for those modules.

Huh, does am335x have a sham module? I don't see any mention of that in
spruh73g.pdf

-- 
Bye, Peter Korsgaard
