From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Mon, 25 Nov 2013 21:21:24 +0100
Message-ID: <5293B144.10006@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-3-git-send-email-zonque@gmail.com> <20131125194629.GA18046@saruman.home> <5293ABDE.4080404@gmail.com> <20131125200121.GE18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:41418 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab3KYUV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 15:21:27 -0500
In-Reply-To: <20131125200121.GE18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

On 11/25/2013 09:01 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 25, 2013 at 08:58:22PM +0100, Daniel Mack wrote:
>> On 11/25/2013 08:46 PM, Felipe Balbi wrote:
>>> On Mon, Nov 25, 2013 at 08:39:50PM +0100, Daniel Mack wrote:
>>>> Make musb_port_suspend() externally available, and call it when to host
>>>> goes into suspend. This allows the core to go into suspend while a
>>>> device is connected.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>> ---
>>>>  drivers/usb/musb/musb_host.c    | 2 ++
>>>>  drivers/usb/musb/musb_host.h    | 2 ++
>>>>  drivers/usb/musb/musb_virthub.c | 2 +-
>>>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
>>>> index 6582a20..81caf9f 100644
>>>> --- a/drivers/usb/musb/musb_host.c
>>>> +++ b/drivers/usb/musb/musb_host.c
>>>> @@ -2433,6 +2433,8 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
>>>>  	struct musb	*musb = hcd_to_musb(hcd);
>>>>  	u8		devctl;
>>>>  
>>>> +	musb_port_suspend(musb, true);
>>>
>>> have you considered the fact that when musb looses context it'll cause a
>>> disconnect on the bus because soft_connect bit is lost ?
>>>
>>> What if you have a mounted file system on a pendrive ? Should we allow
>>> suspend in that case ?
>>
>> Well, I would have expected that, but in fact, the opposite is true.
>> With 3.12, mounting a filesystem on a USB media and accessing it after
>> resume was exactly my test case, and it worked just fine with that patch.
> 
> so you had a mounted file system, suspend, resume, it was still mounted?

Yes, exactly.

> or did it reenumerate and you remounted it ?

No, it did not reenumerate, but the core did a reset on it. See the
following log.

# mount /dev/sda /mnt
# md5sum /mnt/sine_left.wav
bcd90548c1ebf293289072f1a6161f0f  /mnt/sine_left.wav
#
#
# echo mem > /sys/power/state
[   31.553425] PM: Syncing filesystems ... done.
[   31.575462] Freezing user space processes ... (elapsed 0.002 seconds)
done.
[   31.585275] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[   31.595953] PM: Sending message for entering DeepSleep mode
[   31.628887] PM: suspend of devices complete after 21.097 msecs
[   31.641082] PM: late suspend of devices complete after 5.906 msecs
[   31.653834] PM: noirq suspend of devices complete after 6.135 msecs
[   31.660558] PM: GFX domain entered low power state
[   31.660558] PM: Successfully put all powerdomains to target state
[   31.660558] PM: Wakeup source GPIO0
[   31.679130] PM: noirq resume of devices complete after 17.941 msecs
[   31.693371] PM: early resume of devices complete after 4.388 msecs
[   31.702750] net eth0: initializing cpsw version 1.12 (0)
[   31.712084] net eth0: phy found : id is : 0x4dd076
[   31.717317] libphy: PHY  not found
[   31.722448] net eth0: phy  not found on slave 1
[   32.030792] usb 1-1: reset high-speed USB device number 2 using
musb-hdrc <<<< !
[   32.395192] PM: resume of devices complete after 695.279 msecs
[   32.407816] PM: Sending message for resetting M3 state machine
[   32.414683] Restarting tasks ... done.
[   36.701568] libphy: 4a101000.mdio:04 - Link is Up - 100/Full
#
#
# md5sum /mnt/sine_left.wav
bcd90548c1ebf293289072f1a6161f0f  /mnt/sine_left.wav

> Try to do the same with transfers in flight, it's likely to corrupt your
> file system.

I did that as well, and it appeared stable to me. After all, the USB
device was properly put into suspend before VBUS went away, and the usb
storage driver caught up after the core's reset.

In my tests, this was the only approach that would work after resume.



Daniel

