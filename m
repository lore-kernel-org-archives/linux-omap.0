From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
Date: Tue, 15 Feb 2011 14:56:46 -0600
Message-ID: <AANLkTimE=BkNgxUeNXbcPR=yuEWgs1uvSgnnBn9Xectz@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<87ipwq89by.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43715 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751406Ab1BOU4s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 15:56:48 -0500
Received: by mail-gw0-f42.google.com with SMTP id 23so282592gwj.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 12:56:47 -0800 (PST)
In-Reply-To: <87ipwq89by.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Kevin, Benoit,

On Fri, Feb 11, 2011 at 5:01 PM, Kevin Hilman <khilman@ti.com> wrote:
> Omar Ramirez Luna <omar.ramirez@ti.com> writes:
>
>> Mailbox hwmod support for OMAP 2,3,4.
>>
>> This was tested on OMAP3 (3430, 3630), minor testing
>> was made on OMAP4.
>>
>> No testing on OMAP2 since I don't have the hardware.
>
> To help in testing, I wrote a simple mailbox loopback test module for
> OMAP2/3/4 that I used to do send and receive messages on the MPU. =A0=
This
> can be used to test the mailbox without any DSP software.
>
> I tested it against l-o master branch and found a couple bugs in the
> mailbox driver (patches posted earlier today.)
>
> With those patches plus my test I can send & receieve a series of
> messages on the MPU, which is enough to sanity test the basic sending
> and receiving messages on the MPU.
>
> I've tested the master branch, now it's your turn to use this test
> module to validate this hmod conversion series.
>
> The test module is available here:
>
> =A0 =A0git://gitorious.org/omap-test/mailbox.git

I rechecked on OMAP3 (zoom2, zoom3) and OMAP4 (blaze), and
functionality hasn't changed with the hwmod support + Kevin's mbox
test.

On OMAP3, although functionality is ok with this patch set, I noticed
that the interface clock is not being disabled with its corresponding
pm_runtime_disable call. Previously, the driver enabled/disabled the
ick clock on demand, but now the clock stays enabled always (only
affected by the smart-idle feature, I presume).

Should this clock be placed in the main_clk field of omap_hwmod struct
instead of omap_hwmod_ocp_if, I moved it to ocp_if because of the ick
thing, any comment?

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
