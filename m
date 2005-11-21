From: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Subject: Re: OSK5912 USB Port Problem
Date: Mon, 21 Nov 2005 11:14:05 +0100
Message-ID: <43819DED.9030102@uma.es>
References: <437d78ad.1c0496aa.28bc.29a8@mx.gmail.com>
	<1132524761.8816.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1132524761.8816.8.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Matthew Percival <matthew@capgo.com>
Cc: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I had problems with an USB flash memory, too. I tried several solutions
and kernels which did not work until I recently read a post on the Linux
Omap mailing list regarding USB clock malfunction on kernels
2.6.12-2.6.14 (which were the ones I have tried). Then, I tried kernel
2.6.11 an it worked.



Matthew Percival wrote:

> G'Day,
>
>> Thank you! I have set my USB according to your advices. Now, it seems to
>> work properly. I mount the sda1 use the command: mount -t usbfs /dev/sda1
>> /proc/bus/usb/ and the devices file contain the information like this:
>
>
> When you mount with -t usbfs, you are not actually mounting the device:
> you are simply mounting information about your USB subsystem. It will
> always work, so long as you have USB in your kernel. As such, you do
> not need to provide a device (/dev/sda1/) and can just use `none' in
> this place.
>
>> But the problem is when I use the command mount -t vfat /dev/sda1 /tmp it
>> always gives me an error message like this:
>> mount: Mounting /dev/sda1 on /tmp failed: No such device or address
>
>
> I just tried using one myself (I have not used one in a while, and
> wanted to double-check a couple of points), and am no longer able to
> mount a USb key either. Is anyone else having trouble? Perhaps
> something has been broken along the way: I am using 2.6.14-omap1, but
> have not used a USB device since around 2.6.8-omap1.
>
> -- Matthew
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
> .
>
