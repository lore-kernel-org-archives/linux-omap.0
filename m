From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 8/8 v2] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider
 bug
Date: Wed, 25 Feb 2015 18:22:51 +0100
Message-ID: <54EE04EB.6000401@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-8-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDFF20.6030103@ti.com> <54EE0138.7020300@cit-ec.uni-bielefeld.de> <54EE03C5.2090306@ti.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE03C5.2090306@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 25 Feb 2015 18:17, Roger Quadros wrote:
> How will the user know by looking at the kernel log that it was really an error?
> We don't fail probe if set_gpmc_timing_reg() fails so I feel it is necessary to
> clearly show an Error message.
>
> You can probably reword it like "%s: Error!! GPMC CS %d..."

I'll put "error" in there. But just for the record, it's this messaged 
followed by a WARN that explains "failed to add child %s".
So I'd expect the user to put A and B together ;)

Robert
