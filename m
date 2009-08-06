From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: PM branch updated
Date: Wed, 05 Aug 2009 18:14:10 -0700
Message-ID: <87d479921p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:37708 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZHFBOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 21:14:22 -0400
Received: by pzk34 with SMTP id 34so403775pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 18:14:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI...

I just pushed an updated PM branch which was rebased to current
omap/master (which is based on v2.6.31-rc5)

This includes a few fixes from the list, but in particular the
SRF fixes from Ranjith so that DVFS can be done again.

Basic testing on SDP and EVM only.

Kevin
