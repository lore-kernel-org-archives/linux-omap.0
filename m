From: Thomas Renninger <trenn@suse.de>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Wed, 6 Oct 2010 23:34:45 +0200
Message-ID: <201010062334.46971.trenn@suse.de>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43851 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933169Ab0JFVfB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 17:35:01 -0400
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com

Hi,

On Monday 04 October 2010 17:20:57 Jean Pihet wrote:
> Here is a re-spin of the patches after discussion.

what is going to happen here now?

Is this supposed to go through Ingo's tree?

Ingo: do you mind commenting on this.

I see 3 possibilities:
  1) Power (or all) perf events are never going to change.
  
  If they are going to change, then now is the right time and
  2) Backward compatibility is provided in some way for some time.

  3) The power events get cleaned up without compatibility to
     former kernels versions.

There are patches for 2. and 3., for 1. there obviously are no
needed.
For 2., the patches (mine or Jeans), need some polishing. IMO
these double events inside of general code aren't that bad.
I trust Jean, that it's not that easy with all the include magic
and macros, partly realized that myself already and it's not worth
it to dig further for a temporary solution.

Votes so far:
1. Arjan
2. Myself, Jean
3. Peter Zijlstra and Mathieu Desnoyers

Jean's work got successfully blocked for weeks now.
If there would be a final decision by a maintainer who is going to
merge Jean's work, that would be great and it would finally be worth
to send updated patches again which hopefully some day find their way into
a linux-next kernel...

Thanks,

      Thomas
