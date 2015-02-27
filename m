From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 4/8] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Fri, 27 Feb 2015 15:05:32 +0100
Message-ID: <CAMdRc4E4+nDvP7V0sGGLJ=K1iCgwo2WqZQdU8cy=H9Yd8dGvoA@mail.gmail.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424961956-29353-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54F04A6A.7040305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F04A6A.7040305@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Fri, Feb 27, 2015 at 11:43 AM, Roger Quadros <rogerq@ti.com> wrote:
>>               time_ns_min = gpmc_ticks_to_ns(l ? l - 1 : 0);
>
> should be
>                 time_ns_min = l ? gpmc_ticks_to_ns(l - 1) + 1 : 0;
That's a micro-optimization.
>
>                 + 1ns since we don't want to fall into the previous tick bracket.
>                 for l == 0 we have t_min as 0. no need to pass it through gpmc_ticks_to_ns() or add 1 ns.
That's why the invervals are half-open. I can make them closed, no problem.

Regards,

Robert
