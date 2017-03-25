From: Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Sat, 25 Mar 2017 14:21:33 +0700
Message-ID: <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170324185836.GC19814@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2017-03-25 01:58, Bin Liu wrote:
> On Wed, Mar 15, 2017 at 09:08:01AM -0500, Moreno Bartalucci wrote:
>> With usb-musb port in host mode, when the device
>> is disconnected, either logically (because of a mode switch) or
>> physically (by pulling the cable), the USB port should keep
>> suppling VBUS, with no interruption, to prevent power loss on
>> USB powered devices.
>
> The usb device has been disconnected, why it still cares about VBUS
> power?

Morphing devices (3G dongles, wifi dongles, some printers) boots up in 
install mode, usually only as a virtual cd-rom containing Windows 
drivers and software.
They get switched into functional mode by usb_modeswitch sending them
a ctrl msg which makes the device disappear from the USB bus for a very 
short time after which it re-appears with a different interface 
composition and mostly also a different USB Id.

Cutting the VBUS supply while these devices are in progress of switching 
will inhibit switching, the device will reboot when VBUS is again 
asserted and will come up in initial mode as if no switch ctrl msg had 
ever been sent to it.

The problem has been seen both on host only as well as dual-role port 
configs. Dual-role may be a bit more complicated to solve because of
the role switching VBUS detection circuit but I can not see any reason
why a host only configured port should cut the VBUS supply, it could be 
always on right?


/Lars
