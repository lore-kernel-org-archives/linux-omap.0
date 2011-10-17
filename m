From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAP DSS for v3.2
Date: Mon, 17 Oct 2011 09:49:55 +0300
Message-ID: <4E9BD013.3050903@ti.com>
References: <1317972007.2374.12.camel@deskari> <4E9B52E7.7020601@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:47845 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465Ab1JQGuB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 02:50:01 -0400
In-Reply-To: <4E9B52E7.7020601@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

On 10/17/2011 12:55 AM, Florian Tobias Schandinat wrote:
> Hi Tomi,
>
> On 10/07/2011 07:20 AM, Tomi Valkeinen wrote:
>> Hi Florian,
>>
>> Please pull OMAP DSS patches for v3.2 merge window.
>
> Pulled.

Thanks.

>> Note that there are some conflicts with other trees. The board file
>> conflicts are trivial, changes in code which just happen to be next to
>> each other. The LCD driver conflicts are even simpler, there were
>> changes to them from some other tree, but I have removed the files.
>>
>> The conflicts have been solved properly by Stephen in linux-next:
>>
>> https://github.com/sfrothwell/linux-next/commit/3e31b3042760e3906d0a275d7adedfaf55ee5b0a
>>
>> I also attached the output from git show, as github seems to show the
>> full diff for the merge commit.
>>
>> Are you ok with the conflicts?
>
> No problem.
> Well, as I understand, Linus prefers to see (and solve) these conflicts himself,
> so I don't have any work with them at all. I'd only have to resolve them if
> Linus gave up and that would probably point to a more fundamental issue in the
> workflow, like changes going mainline via the wrong tree or such things.

This is also my understanding. However, Linus isn't that fond of ARM 
board files, which is where the conflicts are...

One could argue that the board file changes should go through the OMAP 
tree, but both the driver and the board files need to be changed at the 
same time to keep kernel compiling.

  Tomi
