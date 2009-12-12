From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization delay
Date: Fri, 11 Dec 2009 16:49:15 -0800
Message-ID: <87my1pggok.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:39538 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762430AbZLLAtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 19:49:10 -0500
Received: by pzk26 with SMTP id 26so963518pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 16:49:17 -0800 (PST)
In-Reply-To: <87skbhjwjo.fsf@deeprootsystems.com> (Kevin Hilman's message of "Fri\, 11 Dec 2009 08\:38\:19 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

> PMC code is ARM generic and already largely exists in other places
> (oprofile for one.)  So the use of the PMC will need to be generalized
> as well as be shown not to interfere with other users (as raised
> already by Jean Pihet.)

Someone is already trying to generalize a PMC interface.  You might want
to follow this thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005898.html

Kevin
