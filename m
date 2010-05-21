From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Future of resource framework?
Date: Fri, 21 May 2010 09:47:51 -0700
Message-ID: <871vd5kxqg.fsf@deeprootsystems.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52836 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479Ab0EUQry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 12:47:54 -0400
Received: by pva18 with SMTP id 18so117257pva.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 09:47:53 -0700 (PDT)
In-Reply-To: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com> (Mike Chan's message of "Thu\, 20 May 2010 15\:37\:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Mike Chan <mike@android.com> writes:

> I'm not sure if this has been discussed, yet but since it seems that
> the resource framework will not be making it upstream, I am curious
> what are the replacements under consideration. I am starting to see
> similar issues on other platforms (msm / tegra) so more generic
> (non-omap) solution might be something to consider.

Hi Mike,

Which parts of the SRF do you currently use and find useful?  It would
be helpful for us to to understand the parts you see as useful and
potentially helpful to generalize.

As you know, the current implementation has a several layers
and attempts to manage several things: OPPs, latencies etc.

Our current plans are essentially to break up the "one framework to
rule them all" philosophy and design of SRF and manage the various
pieces by exending other layers such as the new OPP layer and voltage
layers.  Latencies are being managed by the omap_device layer and we
will hopefully have some discussions with the broader linux-pm
community about generalizing that more into the generic driver model
over this year.

For the OPP management parts, you should expect RFC patches in the
next week or two that will start discussions on this.

Thanks for the input,

Kevin

