From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updates
Date: Wed, 13 May 2009 11:03:42 -0700
Message-ID: <87hbzo6fsx.fsf@deeprootsystems.com>
References: <87pred6jff.fsf@deeprootsystems.com>
	<87bppx6j0q.fsf@deeprootsystems.com>
	<F59CF5AD-5251-4C08-9BEE-70B7E27A62C2@mac.com>
	<87tz3p53j8.fsf@deeprootsystems.com>
	<76CCCDC7-9E68-4965-AD8E-ABE8C11317FD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:53415 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZEMSDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 14:03:44 -0400
Received: by wf-out-1314.google.com with SMTP id 26so535441wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 11:03:44 -0700 (PDT)
In-Reply-To: <76CCCDC7-9E68-4965-AD8E-ABE8C11317FD@mac.com> (Elvis Dowson's message of "Wed\, 13 May 2009 20\:17\:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
> 			Thanks for the reply. I am working with the
> gumstix overo TI OMAP  3503, and just finished porting android-2.6.29
> to this platform.  Towards the end I noticed that there was no power
> management available  for the OMAP !! And I used the same git
> repository, pulled nearly all  the PM patches, except the SR ones,
> which didn't work.

It's still not terribly clear to me what PM patches you are or aren't
using.   Or what exactly you mean by "didn't work."

Until today, there was a bug in the SR series in that you also had to
have the OMAP_PM_SRF enabled.  That was fixed by Rajendra and pushed
into today's PM branch.  The alternative was to just disable
SmartReflex.

I don't currently have any Gumstix hardware (hint, hint) but if I did,
I could add it to the platforms where I validate the PM branch.

Kevin

> On May 13, 2009, at 8:14 PM, Kevin Hilman wrote:
>
>> Elvis Dowson <elvis.dowson@mac.com> writes:
>>
>>> When you say rebase to 2.6.30, where would I get this updated kernel
>>> branch from? Can you tell me the git repository location, please?
>>
>> When I rebase the PM branch, it will still be called 'pm' and will be
>> remain in my linux-omap-pm git tree[1].
>>
>> The current 2.6.29-based pm branch will be renamed pm-2.6.29 for those
>> wanting to keep using a 2.6.29-based version.
>>
>> Kevin
>>
>> [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
