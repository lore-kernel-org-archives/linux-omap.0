From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 14:27:18 -0500
Message-ID: <CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com>
References: <50648AA2.2010004@johnea.net>
	<CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
	<5064A173.5000909@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56515 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2I0T1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 15:27:19 -0400
Received: by vbbff1 with SMTP id ff1so2321703vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 12:27:19 -0700 (PDT)
In-Reply-To: <5064A173.5000909@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org

On Thu, Sep 27, 2012 at 1:56 PM,  <linux@johnea.net> wrote:
> On 09/27/2012 11:25 AM, Robert Nelson wrote:
>>
>> On Thu, Sep 27, 2012 at 12:19 PM,<linux@johnea.net>  wrote:
>>>
>>>
>>> Hello,
>>>
>>> In a subsequent distro upgrade to 3.4.4 neither dvi, nor buddy=spidev
>>> function anymore.
>>
>>
>> "buddy=xyz" is not upstream, so which 'tree'/'patchset' are you
>> currently using as a basis for your device?  The authors of that
>> patchset might be able to help out..
>>
>
> Thanks Robert,
>
> The 3.4.4 kernel is plain vanilla plus:
>
> http://rcn-ee.net/deb/sid-armhf/v3.4.4-x1/patch-3.4.4-x1.diff.gz
>
> We're running archlinuxarm, and working with devs there to upgrade to 3.5.4,
> in hopes this will address most or all of the issues. That will include:
>
> http://rcn-ee.net/deb/sid-armhf/v3.5.4-x6/patch-3.5.4-x6.diff.gz
>
> We adopted archlinux because it's about as close to a git kernel as can be
> had in a disto packaged format.

Ah, so my external patchset...  Well, for the patch, nothing actually
changed between 3.4.3-x1 -> 3.4.4-x1... (besides the stable patchset)

https://github.com/RobertCNelson/stable-kernel/commits/v3.4.x/

(the 3 commits are related to scripts in that git repo.)

So, i would first look at the config (zcat /proc/config.gz) between
those two releases, and if the arch developers added any more patches
to it..

Looking at the 3.4.4 commit log
http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=shortlog;h=refs/heads/linux-3.4.y;pg=5

No omapdss changes...

>
> If we still experience issues, I'm trying to understand what to clone to be
> relevant to this list.
>
> Which tree are patches submitted against here?

If it's for arm/omap side tony's tree:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary

For the display:
http://gitorious.org/linux-omap-dss2/linux

But everything is now based on mainline..

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
