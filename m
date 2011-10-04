From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific clocks
Date: Tue, 4 Oct 2011 11:54:28 +0530
Message-ID: <CAMQu2gyXUER6CQBvp7ccTMSWdWpTuoGoOkAhTgX96Tdeuj0cLw@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
 <1316705361-12175-7-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com>
 <20111004004331.GR6324@atomide.com> <alpine.DEB.2.00.1110032145400.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45526 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227Ab1JDGYt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 02:24:49 -0400
Received: by ywb5 with SMTP id 5so193754ywb.5
        for <linux-omap@vger.kernel.org>; Mon, 03 Oct 2011 23:24:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110032145400.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, b-cousson@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

On Tue, Oct 4, 2011 at 9:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
> + Rajendra, Santosh, Beno=EEt
>
> Hi
>
> On Mon, 3 Oct 2011, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [110929 17:40]:
>> > On Thu, 22 Sep 2011, Keerthy wrote:
>> >
>> > > From: Vishwanath BS <vishwanath.bs@ti.com>
>> > >
>> > > OMAP4460 specific clocks are not getting added as the
>> > > cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.
>> > > Changing it to add to OMAP4460 specific clocks also.
>> > > This is clocks are required of temperature sensor.
>> > >
>> > > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
>> > > Cc: paul@pwsan.com
>> >
>> > Thanks, this patch has been queued for 3.2.
>>
>> Should this be a fix for the -rc cycle instead?
>
> I don't think it's needed for the -rc series, since we don't have any
> in-tree users of the 4460 temperature sensor. =A0The only impact I ca=
n see
> is if the bootloader enables the 4460 temperature sensor clock, and
> doesn't disable it. =A0I assume that would probably prevent the L4 WK=
UP
> clockdomain from entering clock stop, which would consume a little mo=
re
> power.
>
You are correct Paul. It would have also gated the low power states
but at this point of time on mainline, we aren't supporting CORE/PER
low power states for OMAP44XX.

IIRC, boot-loader isn't enabling the temperature
sensor clock so this patch can wait for next merge window.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
