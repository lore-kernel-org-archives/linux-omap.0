From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PREVIEW 2] New display subsystem for OMAP2/3
Date: Tue, 23 Sep 2008 12:24:46 +0300
Message-ID: <20080923092445.GA5102@atomide.com>
References: <1222094917.8299.33.camel@tubuntu> <20080922151045.GC8171@atomide.com> <1222157985.8299.38.camel@tubuntu> <47749FCA-154E-4203-892C-5A3544F9CDFC@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55570 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYIWJYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 05:24:51 -0400
Content-Disposition: inline
In-Reply-To: <47749FCA-154E-4203-892C-5A3544F9CDFC@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [080923 11:41]:
>
> Op 23 sep 2008, om 10:19 heeft Tomi Valkeinen het volgende geschreven:
>
>> Hi,
>>
>> On Mon, 2008-09-22 at 18:10 +0300, ext Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080922 17:49]:
>>>> Hi,
>>>>
>>>> I sent a preview of a new display subsystem for OMAP2/3 some time  
>>>> ago:
>>>> http://marc.info/?l=linux-omap&m=122114505030542&w=2
>>>>
>>>> I now have updated it, the patches are at the same place:
>>>> http://www.bat.org/~tomba/omap-dss/
>>>
>>> This discussion should go to linux-fbdev-devel list. Please keep l-o
>>> list Cc'd though. Also you should post the patches as a proper inline
>>> series, please see git-send-email man page.
>>>
>>
>> Ok, I'll move it to linux-fbdev-devel.
>>
>> I didn't post the patches inline, as they are quite big (250k+). I
>> thought there was a "rule" to put big patches to some public place,  
>> not
>> to mail them.
>>
>> What is the proper procedure for this work? Discuss and review the
>> patches on fbdevel, and mail to l-o when finalized? Or go directly to
>> Linus' tree?
>
> Or a branch on l-o (like pm-0)  that will get rebased when things  
> change.

I'd suggest discussing it on fbdevel list, and then have the necessary
patches included into the mainline kernel via fbdevel. If you cc l-o
list, people will have a chance to comment also.

Once you have an ack from the fbdevel list, we can apply the patches
for testing into l-o tree while waiting for the patches to come down
to l-o tree from the mainline tree.

And of course you might want to have your own branch for the patches
like Koen suggested. That will make it easy for people using l-o tree
to try them out by doing a pull from your branch.

Tony
