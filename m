From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: omap7xx rtc ?
Date: Wed, 7 Oct 2009 18:45:16 +0200
Message-ID: <3ea34a000910070945s4a46d7cye27e0989de66c7a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.211.196]:51566 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580AbZJGQpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 12:45:53 -0400
Received: by ywh34 with SMTP id 34so5090167ywh.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 09:45:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

There was a post recently by Alistair Buxton about the omap850 / 730
rtc, and I was wondering if the relevent changes have been made yet.

I'm working on an htc wizard and still fixing a few bugs, one of which
is the rtc. It depends on the 32kHz timer, which is present on the
both the 730 and 850, but it apparently only allows for 8-bit access.

As far as I can tell, this isn't yet in the master git branch, and I'm
not quite sure where to find them otherwise.

Any leads?

Chris
