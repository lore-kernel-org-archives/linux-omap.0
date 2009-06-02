From: Sergey Chemishkian <schemish@gmail.com>
Subject: Re: PM branch updates
Date: Tue, 2 Jun 2009 10:35:53 -0700
Message-ID: <697B922F-58E2-4C75-8ED1-BA6DF62DA16E@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:60532 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418AbZFBRl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 13:41:57 -0400
Received: by pxi12 with SMTP id 12so142550pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2009 10:41:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Hi Kevin,

I am very interested in PM patches that work on Overo, and my company  
can loan you an Overo Air module + Summit motherboard, if it helps.  
Note: this will be a loan, not a donation.

Let me know if this works for you, and what is your shipping address.  
I have to work out details on my side: the loan duration, description  
of your contribution, etc. - our accounting department will need a  
paper trail.

Best regards,
Sergey
--
Sergey Chemishkian,
Cupertino, CA

 > From: Kevin Hilman <khilman@deeprootsystems.com>
 > Date: May 13, 2009 11:03:42 AM PDT
 > To: Elvis Dowson <elvis.dowson@mac.com>
 > Cc: linux-omap@vger.kernel.org
 > Subject: Re: PM branch updates
 >
 > Elvis Dowson <elvis.dowson@mac.com> writes:
 >
 >> Hi Kevin,
 >>             Thanks for the reply. I am working with the
 >> gumstix overo TI OMAP  3503, and just finished porting  
android-2.6.29
 >> to this platform.  Towards the end I noticed that there was no power
 >> management available  for the OMAP !! And I used the same git
 >> repository, pulled nearly all  the PM patches, except the SR ones,
 >> which didn't work.
 >
 > It's still not terribly clear to me what PM patches you are or aren't
 > using.   Or what exactly you mean by "didn't work."
 >
 > Until today, there was a bug in the SR series in that you also had to
 > have the OMAP_PM_SRF enabled.  That was fixed by Rajendra and pushed
 > into today's PM branch.  The alternative was to just disable
 > SmartReflex.
 >
 > I don't currently have any Gumstix hardware (hint, hint) but if I  
did,
 > I could add it to the platforms where I validate the PM branch.
 >
 > Kevin
 >
 >> On May 13, 2009, at 8:14 PM, Kevin Hilman wrote:
 >>
 >>> Elvis Dowson <elvis.dowson@mac.com> writes:
 >>>
 >>>> When you say rebase to 2.6.30, where would I get this updated
 >>>> kernel
 >>>> branch from? Can you tell me the git repository location, please?
 >>>
 >>> When I rebase the PM branch, it will still be called 'pm' and will
 >>> be
 >>> remain in my linux-omap-pm git tree[1].
 >>>
 >>> The current 2.6.29-based pm branch will be renamed pm-2.6.29 for
 >>> those
 >>> wanting to keep using a 2.6.29-based version.
 >>>
 >>> Kevin
 >>>
 >>> [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-
 > omap" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
