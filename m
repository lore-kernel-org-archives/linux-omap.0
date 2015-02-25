From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 8/8 v2] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider
 bug
Date: Wed, 25 Feb 2015 19:27:34 +0200
Message-ID: <54EE0606.4080201@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-8-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDFF20.6030103@ti.com> <54EE0138.7020300@cit-ec.uni-bielefeld.de> <54EE03C5.2090306@ti.com> <54EE04EB.6000401@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE04EB.6000401@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rabel@cit-ec.uni-bielefeld.de, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 25/02/15 19:22, Robert Abel wrote:
> Hi Roger,
> 
> On 25 Feb 2015 18:17, Roger Quadros wrote:
>> How will the user know by looking at the kernel log that it was really an error?
>> We don't fail probe if set_gpmc_timing_reg() fails so I feel it is necessary to
>> clearly show an Error message.
>>
>> You can probably reword it like "%s: Error!! GPMC CS %d..."
> 
> I'll put "error" in there. But just for the record, it's this messaged followed by a WARN that explains "failed to add child %s".
> So I'd expect the user to put A and B together ;)

Sorry, my bad. We are in fact returning -1 in GPMC_SET_ONE().
So no need to add the "Error" string.

cheers,
-roger
