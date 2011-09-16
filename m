From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device driver
Date: Fri, 16 Sep 2011 09:24:48 +0530
Message-ID: <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com>
	<20110915170548.GB2284@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54617 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751780Ab1IPDyx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 23:54:53 -0400
Received: by bke11 with SMTP id 11so3342058bke.20
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 20:54:49 -0700 (PDT)
In-Reply-To: <20110915170548.GB2284@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

On Thu, Sep 15, 2011 at 10:35 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Tony Lindgren <tony@atomide.com> [110915 09:24]:
>> * Mohammed, Afzal <afzal@ti.com> [110915 01:13]:
>> >
>> > We need clocksource & clockevent to be able to work with
>> > timers requiring addition of offsets. Without this AM335X,
>> > TI816X and TI814X SoC's will not boot.
>>
>> OK. Then how about let's do the following things:
>>
>> 1. Modify the inline access functions to take the PEND and others
>> =A0 =A0if needed registers as a parameter
>>
>> 2. Modify mach-omap2/timer.c to initialize the PEND and others
>> =A0 =A0in the SoC specific timer_init function
>
> Also, let's do these changes first then rebase the dmtimer
> series on those changes as it simplifies the dmtimer series
> a bit.
Alright.... I will start with this.
--
Tarun
>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
