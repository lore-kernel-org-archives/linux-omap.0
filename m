From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 3/8 v2] ARM OMAP2+ GPMC: add bus children
Date: Wed, 25 Feb 2015 16:06:25 +0100
Message-ID: <54EDE4F1.10000@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDB9F0.9030701@ti.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EDB9F0.9030701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 25 Feb 2015 13:02, Roger Quadros wrote:
> This creates platform devices for the children of child, but what 
> about platform device for the child itself?
It seems my first try in the other patch set wasn't so wrong after all. 
Maybe unconditionally call

of_platform_device_create(child,...) and
of_platform_populate(child, ...)?

> Shouldn't the bus driver for that bus be responsible for spawning children of its bus?
Well, a bus driver doesn't actually do much work here. The standard buses are just there for offset and so on.
And that's my use case. Have one CS region with fixed settings and multiple devices in it.

Creating code that in effect replicates what simple-bus does isn't worthwhile. Basically, it would replicate half the code that
of_platform_populate goes through anyway without good reason.

If complex bus-behavior is needed -- more than single-bus offset shifts --, a complex bus driver can always be written.
Since it wouldn't match of_default_match_table, it itself would be responsible for creating children.

I think I'll go with my first patch for this one, maybe call of_platform_decide_create unconditionally to check whether buses are
available.

Regards,

Robert
