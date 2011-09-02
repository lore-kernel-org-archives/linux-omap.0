From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 3/4] OMAP: DSS2: Handle manager change in apply
Date: Fri, 2 Sep 2011 13:02:23 +0530
Message-ID: <4E608687.7080806@ti.com>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>	 <1314001636-18036-4-git-send-email-tomi.valkeinen@ti.com>	 <4E607CC3.2000407@ti.com> <1314948322.3374.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33364 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab1IBHdV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 03:33:21 -0400
In-Reply-To: <1314948322.3374.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Friday 02 September 2011 12:55 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-09-02 at 12:20 +0530, Archit Taneja wrote:
>> On Monday 22 August 2011 01:57 PM, Valkeinen, Tomi wrote:
>>> Currently when changing the manager of an overlay, set_manager()
>> directly
>>> calls dispc to set the overlay's destination.
>>>
>>> Change this to be more in line with other overlay configurations,
>> and
>>> this will also remove the need to have dispc clocks enabled when
>> calling
>>> set_manager().
>>>
>>> A new field is added to overlay struct, "manager_changed". This is
>>> similar to "display_changed" field in manager struct, and is used to
>>> inform apply that the manager has changed and thus write to the
>>> registers is needed.
>>
>> I was wondering if it would be better to create an overlay_info
>> member
>> called 'channel_out' rather than having 'manager_enabled' at a higher
>> level? This way, we won't need to do some of the things below(I have
>> pointed them out):
>
> The overlay_info is written by the users of the DSS. So if we had
> channel_out there, we'd need to remove the set/get_manager() functions.
> I made those functions in the first place as I felt changing the manager
> is a bit bigger operation than the normal overlay attributes. Changing
> the manager does effect both the old and the new managers. While I don't
> think we currently do anything related to that, I believe it would be
> needed for optimizations like FIFO merge.

Right, I forgot users of DSS2 will also get the opportunity to change 
channel_out, and we would need to do extra stuff in that case.

>
> It could perhaps be possible to change this so that the overlay_info has
> the channel_out parameter, but that would be a bit bigger change, and
> would needs lots of testing. So I feel this is a safer change, and it
> fixes a problem we had with DRM.

Okay, we could think about this later then.

Archit

>
>   Tomi
>
>

