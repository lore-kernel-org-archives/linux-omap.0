From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/7] 3430sdp and ldp use custom twl4030 power scripts.
Date: Tue, 14 Oct 2008 09:28:02 -0700
Message-ID: <200810140928.02887.david-b@pacbell.net>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <200810101053.22508.david-b@pacbell.net> <20081013084502.GE4596@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:44518 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752373AbYJNQ2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 12:28:46 -0400
In-Reply-To: <20081013084502.GE4596@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 13 October 2008, Peter 'p2' De Schrijver wrote:
> On Fri, Oct 10, 2008 at 10:53:22AM -0700, ext David Brownell wrote:
> > On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> > > The TI 3430dsp and ldp boards have a custom power script.
> > 
> > And for those of us less conversant in this tech ... could
> > you summarize, in words of one syllable or less, just what
> > these scripts do that's different from the "generic" one?
> > And why the generic script is inappropriate?
> > 
> 
> These scripts are already in linux-omap, so this just maintaining
> existing functionality.

I realize that ...


> I don't have access to an LDP, and have no idea 
> why they don't use the generic script.

Hmm.  Maybe someone from TI can explain.  I suspect
part of it is that several of the other boards aren't
actually battery powered, but it's unclear whether
that's the whole story.

- Dave



