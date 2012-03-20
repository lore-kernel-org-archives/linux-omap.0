From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v4 00/12] gpio/omap: Some more driver cleanup and fixes
Date: Tue, 20 Mar 2012 08:05:29 +0530
Message-ID: <CAC83ZvJnhnh-=Kwd4cuRvuCEKjgNWAdw2OK0_8GHb7_K6qk4mw@mail.gmail.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
	<87aa3c3y6k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36472 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757730Ab2CTCfa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 22:35:30 -0400
Received: by mail-wi0-f177.google.com with SMTP id hj13so3508671wib.0
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 19:35:29 -0700 (PDT)
In-Reply-To: <87aa3c3y6k.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

On Tue, Mar 20, 2012 at 6:07 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> The cleanup is mostly getting rid of redundant fields in struct gpio=
_bank{}
>> as we already have them as part of bank->context now. Also, remove u=
n-used
>> variable from gpio_irq_handler. Also, the suspend/resume callbacks a=
re
>> removed bacause they are not needed any more.
>
> OK.
>
>> The fixes include correction of _set_gpio_irqenable() implementation=
,
>> missing wakeup_en register update in set_gpio_wakeup(), type mismatc=
h
>> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
>> register update in set_gpio_dataout_() and few corrections in contex=
t
>> save logic.
>
> These fixes need to be separated out from the cleanups and prepared f=
or
> v3.4-rc. =A0We need these as standlone fixes (indepenent of the clean=
ups)
> so they can be applied for 3.4-rc. =A0The rest of the cleanups will h=
ave
> to wait until 3.5.
Sure, I will separate out the fixes and prepare new series.

>
>> It is baselined on top of:
>> git://git.secretlab.ca/git/linux-2.6.git gpio/next
>> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
>>
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux=
-omap-dev for_3.4/gpio_more_cleanup_fixes
>>
>> Power Test:
>> Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
>> Also confirmed that dataout register content preserved over
>> off-mode.
>
> I've confirmed these fixes also correct off-mode GPIO ouptut glitches
> that I was seeing on n900.
OK, thanks.
--
Tarun
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
