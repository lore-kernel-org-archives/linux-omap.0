From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: when to submit new board support
Date: Mon, 22 Aug 2011 10:59:03 +0200
Message-ID: <4E521A57.8080508@matrix-vision.de>
References: <4E425B4A.3050808@matrix-vision.de> <20110810103336.GE1939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:37438 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab1HVI7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 04:59:06 -0400
In-Reply-To: <20110810103336.GE1939@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

Thanks for the reply.

On 08/10/2011 12:33 PM, Tony Lindgren wrote:
> 
> * Michael Jones <michael.jones@matrix-vision.de> [110810 03:14]:
>> I would like to submit some patches to add support for a new OMAP board...
>>
>> Is there a right or wrong time to post such patches to this list? How
>> does the kernel merge window effect what kind of patches are expected
>> here on the OMAP list?
> 
> Well this is the right time, however we're moving things to device tree
> and coalescing code. So you may need to be prepared to update the patches
> a few times before we get them to mainline.

Unfortunately I am not ready to pull the trigger on submitting my code
right _now_, so I was hoping to get a better understanding of the
system- when the right time would be AND when the wrong time would be.
I.e. what makes "this" the right time?

Also, I'm uncertain whether my submission will generally be welcome. Are
there criteria for which boards are desirable to merge upstream? In
April [1] you said in response to the inquiry about submitting support
for the Nook Color that usually supporting a new machine adds "a few
tens of lines". My machine is not even on the market yet, and its board
file is currently 384 lines long, which is more than a few tens. I don't
want to submit unwanted bloat.

I'm not familiar yet with Device Tree, so I don't understand what the
implications are for existing supported boards and their board files,
but I would of course be prepared to make necessary changes after review.

-Michael

[1] http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg48348.html

>  
>> What should I use as the base for my patches? At
>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git,
>> at the moment 'master' hasn't been updated for 4 weeks. Should I base it
>> on v3.1-rc1 instead (as an example, since I won't manage to submit it
>> while v3.1-rc1 is the most recent tag)?
> 
> Yes v3.1-rc1 should be used as the base. I've been on vacation and
> have not updated the omap tree for a while, will updated it soonish,
> but will be just v3.1-rc1 + bug fixes.
> 
> Tony


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
