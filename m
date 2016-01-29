From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/2] reboot: Introduce emergency_poweroff function
Date: Fri, 29 Jan 2016 07:15:20 +0530
Message-ID: <56AAC430.3070107@ti.com>
References: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
 <20160128132447.6b8bec2c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128132447.6b8bec2c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, toshi.kani@hp.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com, grygorii.strashko@ti.com, mingo@kernel.org, josh@joshtriplett.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Alan,

On Thursday 28 January 2016 06:54 PM, One Thousand Gnomes wrote:
> On Thu, 28 Jan 2016 18:36:27 +0530
> Keerthy <j-keerthy@ti.com> wrote:
>
>> The series introduces a new function emergency_poweroff which shuts
>> down the system after a configurable period of time. emergency_poweroff
>> is appropriate in case of thermal shutdown scenario.
>
> That depends upon the system.
>
> If your hardware has its own built in thermal reset protection then it
> will merely make things worse by causing unneeded crashes.
>
> If your device doesn't have protection then you have bigger problems
> because a kernel crash or spin in interrupt space could easily mean that
> the thermal thermals but doesn't ever run any delayed work. On those that
> have a watchdog as well it should be using the hardware watchdog for
> protection not relying upon schedule_delayed_work to get work done.
>
> So IMHO this should get a resounding NAK as it stands. For most systems
> it's a backward change, for most of those that need more protection it
> doesn't look the right answer.
>
> In particular if you need to be sure the box goes off *right now* you
> don't want to schedule work because there are so many ways that it might
> never execute the work when the box is failing.

Scheduling work was done to give a configurable delay before powering 
off. I get your point that it might never get scheduled when things go 
wrong.

>
> Do your devices actually *really* need this, are you saying that someone
> who roots the device can disable this code and physically destroy the
> product ? If they do then I'd much rather see thermal_core call
> thermal_poweroff(), and define that on a platform basis - so for x86 it
> would be orderly_poweroff(), for your platform it might well be a
> function that right that instant bangs the registers to force power off,
> devices with watchdogs might write the watchdog with a 5 second timer and
> then try and do an orderly_poweroff and so forth.

Thanks for the feedback. I apologize for Ccing the wrong list. I removed 
it from the thread.

Regards,
Keerthy

>
> Alan
>
