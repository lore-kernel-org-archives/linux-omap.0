From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS2 questions
Date: Thu, 06 Aug 2009 06:07:52 -0600
Message-ID: <4A7AC798.6070409@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:5090 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbZHFMIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:08:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Tomi,

I've been following your DSS2 work, with reasonable success.
However, when I tried to pull from your repo today, I got
a ton of merge errors.  I cloned your tree a [little] while
back (it seems it was 2009-06-16, but where did the time go?)

Here's what I did:
  git clone http://www.bat.org/~tomba/git/linux-omap-dss.git
    HEAD=5bd374f9b199d46ae434489d56615b240de5a6d7
  git checkout -b my_branch origin/master
    ...
When I went to pull into my_branch, I got the merge errors.
Any clues what I did wrong?  How could/should I have managed
this better?

n.b. you earlier told me that git was better than sliced
bread; I'm still waiting to be shown the light :-)

Second question; I've set up my system much the same as the
boards you are working on, with an LCD and TV outputs.  I'm
a bit confused as to how I configure the overlays and managers
to be able to send YUV data directly through to either the
LCD or TV.  Can you explain this?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
