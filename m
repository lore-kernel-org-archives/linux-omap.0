From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in omap2plus_defconfig
Date: Fri, 6 Jul 2012 17:55:23 +0530
Message-ID: <CAP05o4L6CXjgDCe_eoY15aKFNDf7vMcYJGOqxpE3rMPSAxU57w@mail.gmail.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4LAQXzPs_gLBn70X-VbRWTCHOk0b4afH9gn0aUur2C7FQ@mail.gmail.com>
	<CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
	<CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
	<20120706120700.GV1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40030 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937Ab2GFMZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:25:27 -0400
Received: by lbgc1 with SMTP id c1so29525803lbg.1
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 05:25:23 -0700 (PDT)
In-Reply-To: <20120706120700.GV1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Partha Basak <parthab@india.ti.com>, sameo@linux.intel.com, balbi@ti.com, Kevin Hilman <khilman@ti.com>

On Fri, Jul 6, 2012 at 5:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Munegowda, Keshava <keshava_mgowda@ti.com> [120706 05:06]:
>> On Fri, Jul 6, 2012 at 5:29 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> > On Fri, Jul 6, 2012 at 5:25 PM, Munegowda, Keshava
>> > <keshava_mgowda@ti.com> wrote:
>> >> On Fri, Jul 6, 2012 at 5:19 PM, Keshava Munegowda <keshava_mgowda@ti.com> wrote:
>> >>> The usb host is disabled in the omap2 build; This is because
>> >>> usb host is causing the retention to break in cpu idle.
> ...
>> >> Sameo
>> >>     please merge this patch ; this makes the core retention to work in
>> >> omap2plus_defconfig
>> >>
>> > If at all this patch has to be merged, it should be via Tony's tree,
>> > otherwise you
>> > might have merge conflicts.
>
> I think it's best to fix things properly, even if it means that it will
> take longer and go into next kernel version.
>
> Tony

Hi tony

    This requires ehci remote wakeup feature to be implemented, which
will take at least to 3 months to
get reviewed in opensource.
hence for now  kevin is also agreed to disable it by default;


regards
keshava
