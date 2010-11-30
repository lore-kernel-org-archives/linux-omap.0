From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH 00/12] usb: ehci-omap: add OMAP4 support
Date: Wed, 01 Dec 2010 03:34:10 +0530
Message-ID: <4CF574DA.5010103@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com> <20101130174406.GB19977@kroah.com> <AANLkTi=hr3bz6xS8DB+ShE0E_HzFGhtCqi+1NqsWQQa5@mail.gmail.com> <20101130183007.GA27476@suse.de> <20101130184711.GW17222@atomide.com> <AANLkTik3a6Yyt1oOHXK_2caTnzhxLOrBeE2Ue860AD+D@mail.gmail.com> <20101130203038.GB16324@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42925 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab0K3WEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 17:04:24 -0500
In-Reply-To: <20101130203038.GB16324@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 12/1/2010 2:00 AM, Greg KH wrote:
> On Wed, Dec 01, 2010 at 12:22:07AM +0530, Gadiyar, Anand wrote:
>> On Wed, Dec 1, 2010 at 12:17 AM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Greg KH <gregkh@suse.de> [101130 10:22]:
>>>> On Tue, Nov 30, 2010 at 11:53:11PM +0530, Gadiyar, Anand wrote:
>>>>>
>>>>> The only other change is I added back patch descriptions to a couple
>>>>> of patches that I missed out on in v1.
>>>>>
>>>>> I'm okay with either option. Both series could also go via your tree if
>>>>> it's okay with Tony.
>>>>
>>>> Ah, sorry, I see that now.
>>>>
>>>> Tony, it's up to you, what is easier for you?
>>>
>>> I prefer to merge it via linux-usb. Just replied to the arch/arm/*omap*/
>>> related patches in this series with my ack.
>>>
>>
>> Great, thanks!
>>
>> Greg,
>>
>> If it's easier for you, I can set up a branch for you to pull.
>>
>> Otherwise, the two series I posted yesterday should apply
>> cleanly on top of your usb-next branch.
> 
> A branch is nice if you have one, otherwise I can just apply these
> as-is.  Let me know which you want me to do.

I'll set up a branch then, based on your usb-next branch,
with Tony and Paul's acks added.

I'll send a pull request in a while.

- Anand
