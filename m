From: Kevin Hilman <khilman@mvista.com>
Subject: Re: source.mvista links are broken
Date: Fri, 04 Apr 2008 11:16:16 -0700
Message-ID: <87myo9a3kf.fsf@paris.hilman.org>
References: <5D8B5EC1EB6ED845B1EB216F00C71B65032A8F0F@dlee12.ent.ti.com>
	<20080404110314.GN3505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:22108 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbYDDSQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 14:16:18 -0400
In-Reply-To: <20080404110314.GN3505@atomide.com> (Tony Lindgren's message of "Fri\, 4 Apr 2008 14\:03\:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Iqbal <iqbal@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Iqbal <iqbal@ti.com> [080404 13:07]:
>> 
>> Looks like the OMAP tree links are broken and the summary,short log and other fields don't work.
>> 
>> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commit;h=8a88c221c88399bc694c367dbea01ffc4153ef20
>
> Yeah, I've noticed that too. Probably git needs updating on
> source.mvista.com, it seems to have issues with reading packed objects.
>
> I've fixed it to some extent by scp'ing over some object files, and then
> there was a brief file permissions problem too...
>
> In any case, please use the kernel.org instead:
>
> http://git.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
> I've notified Kevin about the issue, so we probably have to wait for
> git to get updated.

git on source.mvista.com is now updated to 1.5.4.5.  Let me know if
there are any more problems.

Kevin

