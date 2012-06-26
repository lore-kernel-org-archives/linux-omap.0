From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: Current state of AM33xx patches
Date: Tue, 26 Jun 2012 17:12:03 +0530
Message-ID: <4FE9A00B.6010908@ti.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49600 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2FZLmS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 07:42:18 -0400
In-Reply-To: <4FE8AB37.7030907@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

Hi Daniel,

On 6/25/2012 11:47 PM, Daniel Mack wrote:
> On 21.06.2012 15:50, Daniel Mack wrote:
>> On 18.06.2012 10:15, Hiremath, Vaibhav wrote:
>>> On Mon, Jun 11, 2012 at 19:21:21, Jason Kridner wrote:
>>>> From: Daniel Mack <zonque@gmail.com>
>>>>> Hey,
>>>>>
>>>>> can anybody give me a quick wrap-up about the current state of AM33xx
>>>>> based SoCs in mainline? What are the next steps to get things merged?
>>>>
>>>> There is a wiki page [1] that is intended to provide a summary, but I'm
>>>> confident it is not up-to-date.  
>>>
>>> Page updated now...
>>>
>>> http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status#AM335x_Linux_Status
>>
>> Great, thanks. So if things get upstreamed, which is the repo/branch
>> they appear in? In other words: where is the code people should write
>> patches against? I couldn't find an answer to that yet.
> 
> ping?

Bug fixes are always accepted against Linus's tree[1].

For features, typically there is a -next branch that each subsystem
maintainer has against which feature development happens. In case of
OMAP, feature development happens against master branch of linux-omap
tree[2]. One way to get to know the -next branches of all subsystem is
to look at Next/Trees file of linux-next tree[3].

Note that in case of ARM, sub-arch maintainers send the code to arm-soc
maintainers who in turn have a branch which gets merged to linux-next.

Hope that helps.

Thanks,
Sekhar

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git
[2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git
[3] http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git


