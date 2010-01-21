From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: MUSB crash on OMAP3 board with second load of gadget
Date: Thu, 21 Jan 2010 16:23:17 +0300
Message-ID: <48239d391001210523l5762775dm8382ad82e7b10e4a@mail.gmail.com>
References: <48239d391001210326y25986d59hd10d390ef9c8ddea@mail.gmail.com>
	 <20100121122839.GB26015@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753334Ab0AUNXZ@vger.kernel.org>
In-Reply-To: <20100121122839.GB26015@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 21, 2010 at 3:28 PM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> On Thu, Jan 21, 2010 at 12:26:49PM +0100, ext Sergey Lapin wrote:
>>
>> Hi! I have crashes in MUSB code when working with USB gadget drivers=
=2E
>> Kernel version: linux-omap master d8ebff302ff819587377b123e900e501e4=
135d86
>> To reproduce: (USB device cable should be attached).
>>
>> dd if=3D/dev/zero of=3D/tmp/disk bs=3D1k count=3D1024
>> mkdosfs -F 32 /tmp/disk
>> insmod g_mass_storage =A0file=3D/tmp/disk stall=3D0
>>
>> Wait till disk is mounted on host, then
>>
>> rmmod g_mass_storage
>> insmod g_mass_storage =A0file=3D/tmp/disk stall=3D0
>>
>> And here we get Oops in include/linux/list.h line 93,
>
> I guess it's the list corruption bug, right ?
>
> I've seen that, but couldn't get it to reproduce. Now that you said, =
I'll
> try to find a fix for it.
It seems so,  thanks a lot!

S.
