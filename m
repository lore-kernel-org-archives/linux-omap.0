From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 3/3] OMAP2+: voltage: clean up error messages
Date: Tue, 30 Aug 2011 18:52:25 +0200
Message-ID: <20110830165225.GB20295@localhost>
References: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
 <1312907661-24436-3-git-send-email-jhovold@gmail.com>
 <87fwkjrkai.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48803 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1H3Qw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 12:52:29 -0400
Received: by bke11 with SMTP id 11so5207454bke.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 09:52:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fwkjrkai.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Aug 29, 2011 at 02:15:49PM -0700, Kevin Hilman wrote:
> Hi Johan,
> 
> Johan Hovold <jhovold@gmail.com> writes:
> 
> > Clean up error messages by adding missing whitespace, reducing excessive
> > verbosity, and fixing a few language issues.
> >
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> 
> I've got a major voltage layer cleanup series in progess (and just
> posted a few series.)  Would you care to rebase this on top my
> pm-wip/voldtm branch[1] where those cleanups are being done?

I just resent patches 1 and 2 with proper CC and will try to respin
patch 3 against your voltdm branch in a few days.

Thanks,
Johan
