From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846: add regulator support
Date: Tue, 20 Apr 2010 22:21:57 +0300
Message-ID: <j2p6ed0b2681004201221y6ae69bedp649845f94de64896@mail.gmail.com>
References: <1266078714-18155-1-git-send-email-notasas@gmail.com>
	 <p2j5e088bd91004200931ucbf1eedvc710bebf8236dc1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:61384 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0DTTWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 15:22:00 -0400
Received: by bwz25 with SMTP id 25so7181555bwz.28
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 12:21:58 -0700 (PDT)
In-Reply-To: <p2j5e088bd91004200931ucbf1eedvc710bebf8236dc1a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 20, 2010 at 7:31 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Sat, Feb 13, 2010 at 9:31 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
>> connected to various regulators for power, so add regulator support.
>>
>> Valid regulator will now be required, so boards without complete
>> regulator setup should either disable regulator framework or enable
>> CONFIG_REGULATOR_DUMMY.
>
> I'd prefer not to completely disable the regulator framework and my
> 2.6.33 kernel tree doesn't seem to have the CONFIG_REGULATOR_DUMMY
> option.

Then how did this patch reach your tree? I don't see this in mainline 2.6.33.

> Is there a simple way to handle the case (as exists with the Gumstix
> Overo) where the ADS7846 is supplied by a fixed regulator with no
> software controls?

Not without patching I guess. Otherwise you can set up
reg-fixed-voltage platform device in board file (see
arch/arm/mach-pxa/raumfeld.c for an example), add dummy regulator
patches from mainline of just revert this patch.

>
> Steve
>
