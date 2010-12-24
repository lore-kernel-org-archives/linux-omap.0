From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Fri, 24 Dec 2010 11:38:07 +0100
Message-ID: <4D14780F.3070409@free-electrons.com>
References: <4CED8F6E.3000808@free-electrons.com> <87y68i447o.fsf@deeprootsystems.com> <20101223230828.GP20384@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:40399 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0LXKiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 05:38:18 -0500
In-Reply-To: <20101223230828.GP20384@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>

On 12/24/2010 12:08 AM, Grant Likely wrote:
> On Wed, Nov 24, 2010 at 04:49:47PM -0800, Kevin Hilman wrote:
>> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
>>
>>> As request by Grant Likely, there is no more cover letter. Full changelog is following.
>>> I am still reluctant to add this changelog in the patch description, as it adds no value to
>>> the patch itself: when it was needed I try to updat comments or patch description.
>>
>> You're right, the changelog should not be in the patch description.
>> This bit of meta-description and changelog should go after the '---'
>> just after your signoff.  That way, git tools can still auto-apply the
>> email, and git ignores stuff after the '---' so it doesn't end up in the
>> git history.
> 
> Actually, I used to have the same opinion, but dwmw2 clued me in that
> it really is valuable and proper to have the revision history and
> changelog in the patch description.  When looking back at what
> actually got committed into Linus' tree, the changelog gives hints as
> to which exact version of the patch got committed (for instance, if a
> v6 got merged, but a v7 was also posted that didn't get merged.)
> 
OK if it is the rule for spi subsystem, I will conform to it, and I will
add my changelog in the patch description.

> BTW, this thread has some discussion about this patch not actually
> working correctly.  What is the state?  Should this version get
> merged, or do I need to wait for a v6?
Well, I tried to answer to each points to Kevin and to David Brownell. I
was waiting for some feedback. I didn't realize it was already near a
month ago, so it should be OK. Then I will insert the last comments of
Kevin and release the v6.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
