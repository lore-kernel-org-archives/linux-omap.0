From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 7/9] OMAP: Devkit8000: Fix wrong usb port on Devkit8000
Date: Tue, 30 Mar 2010 07:16:01 +0000
Message-ID: <4BB1A531.10906@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de> <1269435138-27192-8-git-send-email-weber@corscience.de> <20100324130001.GK29419@nokia.com> <20100329203432.GB31402@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB032231D1BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59349 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab0C3GQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 02:16:26 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032231D1BE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On 03/30/10 05:38, Gadiyar, Anand wrote:
> Felipe Balbi wrote:
>   
>> On Wed, Mar 24, 2010 at 02:00:01PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>>     
>>> On Wed, Mar 24, 2010 at 01:52:16PM +0100, ext Thomas Weber wrote:
>>>       
>>>> Disable the nonexistent ehci port on Devkit8000.
>>>>
>>>> Signed-off-by: Thomas Weber <weber@corscience.de>
>>>>         
>>> can anyone with this board available (other than Thomas of course)
>>> please ack or nak the patch ?
>>>
>>> I don't have this board available.
>>>       
>> nobody ??
>>
>>     
> Why don't we just trust Thomas? After all, he added the
> support for the board in the first place. ;)
>
> The patch looks trivially obvious. If there's no USBHOST port2
> in use on the board, there's certainly no problem disabling it.
> With that assumption, this code is okay
>
> If you really need an ack, feel free to add my:
>
> Acked-by: Anand Gadiyar <gadiyar@ti.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   
Hi,
I tried to find some users but they are in holiday for a longer time or
didn't respond.

I will try to explain the problem why I disabled the usb-port2.
The devkit8000 has only one mini-usb-port and one usb-host port like the
beagleboard. The usb2-port on the devkit8000 has some gpios attached for
mmc and touchscreen. Thatswhy the mmc was not working, when the usb-ehci
was enabled on this port.

The beagleboard has also only one usb-host exposed, but there is no
other thing connected to the not exposed usb-port.

Thomas
