From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Droid 4 backlight support
Date: Fri, 24 May 2019 23:49:10 +0200
Message-ID: <9285721b-8060-df59-7cdb-9cdd00b843ca@gmail.com>
References: <20190523220047.GA15523@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CA1046244CA7FB683BBA048E"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523220047.GA15523@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------CA1046244CA7FB683BBA048E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/24/19 12:00 AM, Pavel Machek wrote:
> Hi!
> 
> Good news .. we have driver for backlight in mainline, AFAICT.
> 
> Bad news .. it is called "lm3532::backlight" or something like that. I
> guess we should switch to ":backlight" or something? It is quite
> important to do that before someone starts to use the ABI...
> 
> And now... we have the driver, but it is not connected to the
> backlight subsystem. I guess we could make the LED "default on" for
> now... but if there's better plan, let me know.

backlight trigger is added to fb_notifier_list
defined in drivers/video/fbdev/core/fb_notify.c.
Backlight subsystem is registered on the same notifications
in drivers/video/backlight.backlight.c.

So they are somehow related.

Regarding the LED class device name - when I tried to come up
with a description for each standardized LED function I realized
that in case of many functions it would be indeed very useful
to have devicename. For backlight LED it would be "associated
frame buffer device node name, e.g. fb0".

Attached is what I came up with, and I was going to send to the
list officially with the v5 of LED naming patch set.

-- 
Best regards,
Jacek Anaszewski

--------------CA1046244CA7FB683BBA048E
Content-Type: text/plain; charset=UTF-8;
 name="led-functions.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="led-functions.txt"

This file presents standardized LED functions and their meaning.

Each LED function is described using below template:

- LED function name
    NDEV : <function meaning when LED devicename section is absent>
    DEV  : <function meaning when LED devicename section is present>
    DEVICENAME : <expected LED devicename for DEV case>
    TRIGGER: <matching LED trigger>

/* LED functions with corresponding trigger support */

- activity
    NDEV : system activity
    DEV  : n/a
    TRIGGER : "activity"

- backlight
    NDEV : n/a
    DEV  : backlight of a frame buffer device
    DEVICENAME : associated frame buffer device, e.g. fb0
    TRIGGER: "backlight"

- capslock
    NDEV : n/a
    DEV  : keyboard capslock state related to the particular input device
    DEVICENAME : associated input device, e.g. input1
    TRIGGER : "kbd-capslock"

- disk
    NDEV : rw activity on any disk in the system
    DEV  : rw activity on particular disk
    DEVICENAME : associated disk, e.g.: hda, sdb
    TRIGGER : "disk-activity", applies only to NDEV case

- disk-read
    NDEV : read activity on any disk in the system
    DEV  : read activity on particular disk
    DEVICENAME : associted disk, e.g.: hda, sdb
    TRIGGER : "disk-read", applies only to NDEV case

- disk-write
    NDEV : write activity on any disk in the system
    DEV  : write activity on particular disk
    DEVICENAME : associated disk, .e.g" hda, sdb
    TRIGGER : "disk-write", applies only to NDEV case

- flash
    NDEV : flash LED (if there is single available on the platform)
    DEV  : flash LED related to the particular video device
    DEVICENAME : associated video device, e.g. v4l2-subdev3
    TRIGGER : "flash"; this LED can be also controlled by v4l2-flash framework

- flash-front
    NDEV : n/a
    DEV  : front flash LED related to the particular video device
    DEVICENAME : associated video device, e.g. v4l2-subdev3
    TRIGGER : "flash"; this LED can be also controlled by v4l2-flash framework

- flash-rear
    NDEV : n/a
    DEV  : rear flash LED related to the particular video device
    DEVICENAME : associated video device, e.g. v4l2-subdev3
    TRIGGER : "flash"; this LED can be also controlled by v4l2-flash framework

- heartbeat
    NDEV : cpu load average expressed as heartbeat-fashion blink frequency
    DEV  : n/a
    TRIGGER : "heartbeat"

- lan
    NDEV : n/a
    DEV  : network traffic on selected network device
    DEVICENAME : associated phy, e.g. phy1
    TRIGGER : "netdev"

- micmute
    NDEV : platfrom microphone input mute state
    DEV  : mute state of a microphone belonging to the particular device
    DEVICENAME : associated audio device
    TRIGGER : "audio-micmute"

- mtd
    NDEV : rw actvity on any mtd device in the system
    DEV  : rw actvity on particular mtd device
    DEVICENAME : associated mtd device, e.g mtdN
    TRIGGER : "mtd"

- mute
    NDEV : platform audio output mute state
    DEV  : mute state of particular audio device output
    DEVICENAME : associated audio device
    TRIGGER : "audio-mute"

- numlock
    NDEV : n/a
    DEV  : keyboard numlock state related to the particular input device
    DEVICENAME : associated input device, e.g. input1
    TRIGGER : "kbd-numlock"

- panic
    NDEV : signals kernel panic
    DEV  : n/a
    TRIGGER : "panic"

- scrolllock
    NDEV : n/a
    DEV  : keyboard scrollock state related to the particular input device
    DEVICENAME : associated input device, e.g. input1
    TRIGGER : "kbd-scrolllock"

- torch
    NDEV : torch LED (if there is single available on the platform)
    DEV  : torch LED related to the particular video device
    DEVICENAME : associated video device, e.g. video1, v4l2-subdev3
    TRIGGER : "torch"; this LED can be also controlled by v4l2-flash framework

- usb
    NDEV : activity on any USB port
    DEV  : activity on a particular USB port
    DEVICENAME: associated USB device identifier
    TRIGGER : "usbport"

/* LED functions without corresponding trigger support */

- alarm
    NDEV : system wide alarm
    DEV  : n/a

- bluetooth
    NDEV : activity on platform bluetooth adapter
    DEV  : activity on bluetooth adapter related to the particular device
    DEVICENAME : associated device

- boot
    NDEV : when lit indicates system boot
    DEV  : n/a

- charging
    NDEV : battery charging status
    DEV  : n/a

- debug
    NDEV : signals if device runs in debug mode
    DEV  : n/a

- disk-err
    NDEV : failure on any disk in the system
    DEV  : failure on particular disk
    DEVICENAME : associted disk, e.g.: hda, sdb

- fault
    NDEV : general system fault
    DEV  : fault on particular system device
    DEVICENAME : related device name

- indicator
    NDEV : signals if platform camera sensor is active
    DEV  : signals if camera sensor related to the particular video device is active
    DEVICENAME : associated video device, e.g.: v4l2-subdev3

- kbd_backlight	- keyboard backlight
    NDEV : n/a
    DEV  : backlight state related to the particular input device
    DEVICENAME : associated input device, e.g. input1

- mail
    NDEV : signals a new massage in mailbox
    DEV  : n/a

- programming
    NDEV : platform firmware update is in progress
    DEV  : n/a

- power
    NDEV : power plug presence indicator
    DEV  : n/a

- rx
    NDEV : n/a
    DEV  : activity on rx line of serial port related to the particular tty device
    DEVICENAME: associated tty device, e.g.: tty1, ttyUSB2

- sd
    NDEV : n/a
    DEV  : activity on sd card related to the particular device
    DEVICENAME: associated disk, e.g. sdb

- sleep
    NDEV : signals any variant of system hibernation or suspend state
    DEV  : n/a

- standby
    NDEV : device standby status
    DEV  : n/a

- status
    NDEV : system wide status LED
    DEV  : n/a

- system
    NDEV : system is fully operating
    DEV  : n/a

- tx
    NDEV : n/a
    DEV  : activity on tx line of serial port related to the particular tty device
    DEVICENAME: associated tty device, e.g.: tty1, ttyUSB2

- wan
    NDEV : activity on any WAN device
    DEV  : activity on a particular WAN device
    DEVICENAME: associated WAN device identifier

- wlan
    NDEV : activity on any wlan device
    DEV  : activity on a particular wlan device
    DEVICENAME: associated wlan device identifier

- wps
    NDEV : n/a
    DEV  : wps functionality activation state related to the particular device
    DEVICENAME : associated device name

--------------CA1046244CA7FB683BBA048E--
