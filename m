From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: source.mvista links are broken
Date: Sun, 06 Apr 2008 16:44:04 +0200
Message-ID: <47F8E1B4.2040709@googlemail.com>
References: <5D8B5EC1EB6ED845B1EB216F00C71B65032A8F0F@dlee12.ent.ti.com>	<20080404110314.GN3505@atomide.com> <87myo9a3kf.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:47002 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYDFOoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 10:44:23 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1380236fkr.5
        for <linux-omap@vger.kernel.org>; Sun, 06 Apr 2008 07:44:12 -0700 (PDT)
In-Reply-To: <87myo9a3kf.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, Iqbal <iqbal@ti.com>, linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> 
>>* Iqbal <iqbal@ti.com> [080404 13:07]:
>>
>>>Looks like the OMAP tree links are broken and the summary,short log and other fields don't work.
>>>
>>>http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commit;h=8a88c221c88399bc694c367dbea01ffc4153ef20
>>
>>Yeah, I've noticed that too. Probably git needs updating on
>>source.mvista.com, it seems to have issues with reading packed objects.
>>
>>I've fixed it to some extent by scp'ing over some object files, and then
>>there was a brief file permissions problem too...
>>
>>In any case, please use the kernel.org instead:
>>
>>http://git.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
>>git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>>
>>I've notified Kevin about the issue, so we probably have to wait for
>>git to get updated.
>  
> git on source.mvista.com is now updated to 1.5.4.5.  Let me know if
> there are any more problems.

omap-git> git version
git version 1.5.4.5
omap-git> cg-version
cogito-0.18.2
omap-git> cat .git/HEAD
0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d
omap-git> cat .git/branches/origin
git://source.mvista.com/git/linux-omap-2.6
omap-git> cg-update origin
Recovering from a previously interrupted fetch...
Fetching pack (head and objects)...
error: refs/heads/origin does not point to a valid object!
error: refs/heads/origin does not point to a valid object!
remote: Total 0 (delta 0), reused 0 (delta 0)
remote: aborting due to possible repository corruption on the remote side.
error: waitpid (async) failed
fatal: error in sideband demultiplexer
cg-fetch: fetching pack failed
omap-git>

Switching to git.kernel.org works:

omap-git> cat .git/branches/origin
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
omap-git> cg-update origin
Recovering from a previously interrupted fetch...
Fetching pack (head and objects)...
error: refs/heads/origin does not point to a valid object!
error: refs/heads/origin does not point to a valid object!
remote: Counting objects: 896, done.
remote: Compressing objects: 100% (490/490), done.
remote: Total 896 (delta 453), reused 848 (delta 405)
Receiving objects: 100% (896/896), 1.53 MiB | 108 KiB/s, done.
Resolving deltas: 100% (453/453), done.
Fetching tags...
Missing tag v2.6.25-rc8...
remote: Counting objects: 1, done.
remote: Total 1 (delta 0), reused 1 (delta 0)
Unpacking objects: 100% (1/1), done.
Up to date.

Applying changes...
Fast-forwarding 0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d -> 
722c80b23c0d53c16467e35ea43741c597bfbba3
         on top of 0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d ...
omap-git>

Seems that there is still something broken with MV git?

Dirk
