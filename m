From: Georges Toth <georges.toth@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 06 Apr 2008 17:14:45 +0200
Message-ID: <47F8E8E5.7060301@gmail.com>
References: <0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com> <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com> <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com> <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com> <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com> <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com> <47F87EA6.6050504@googlemail.com> <47F8D0A9.40805@gmail.com> <20080406140804.GA21945@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from terman.e-hosting.lu ([80.92.79.12]:50205 "EHLO
	terman.e-hosting.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYDFPOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 11:14:52 -0400
In-Reply-To: <20080406140804.GA21945@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

Brian Swetland wrote:
> [Georges Toth <georges.toth@gmail.com>]
>   
>> The touchscreen doesn't work yet, but I hope we can figure that out too.
>> -> The driver works, there is output when one does a cat on 
>> /dev/input/event3, but android doesn't recognize it.
>>
>> Some buttons don't work ... wrong mapping.
>> If anybody has an idea how to see what keycodes certain buttons are bound 
>> to and how to edit the mapping in android that would be great :-).
>>     
>
> Here's a brute force approach to sorting out input events: run getevent
> on the emulator and on the target hardware and compare the results.  It's
> in /system/bin.
>
> I believe the touchpad issue has to do with sending events that the
> system recognizes as "pen down" and "pen up" events.  Haven't looked at
> this in a while.
>   
Thanks for the tip, I'll have a look at that.

> Keylayouts live in /system/usr/keylayout/*.kl and are used to translate
> from the raw input event codes to android keycodes.
>
> Keymaps live in /system/user/keychars/*.kcm.bin (undocumented binary
> format right now, sorry) and are used to describe how the key events
> and modifiers and such are related.
>   
I would need to add/change the event code for the DPAD_CENTER event.
Do you perhaps know of a simple way of seeing what code a certain button 
generates ?


-- 
regards,

Georges Toth

