From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2: Intro
Date: Wed, 7 Oct 2009 11:57:27 +0300
Message-ID: <94a0d4530910070157v2dd8062aheffc6345daff9e78@mail.gmail.com>
References: <1253793384-31158-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1254302501.23991.90.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:40928 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729AbZJGI6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 04:58:04 -0400
In-Reply-To: <1254302501.23991.90.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ext Andrew Morton <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Sep 30, 2009 at 12:21 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> Andrew, do you have time to check out the DSS2 driver? Or suggestions
> how should I proceed.
>
> I rebased DSS2 on top of today's linux-tree, and there were no
> conflicts, so the posted patches should apply. But the rebased tree is
> also available in master branch at
> git://gitorious.org/linux-omap-dss2/linux.git

It's also worth noting that DSS2 is used basically on all linux-omap
trees already, I've seen it working at least on N900 and beagleboard
and it makes no sense to try to get some video output without it.

P.S. I had to patch the beagleboard support from Tomi's
'master-before-squash'... it would be nice to get it upstream already

-- 
Felipe Contreras
