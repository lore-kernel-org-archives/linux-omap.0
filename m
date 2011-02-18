From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [alsa-devel] [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation for McBSP
Date: Fri, 18 Feb 2011 13:50:54 +0530
Message-ID: <AANLkTimOf1WKHJUTaCWE9+HRmjFa0Ms9Wg2704ZUt+Ua@mail.gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-9-git-send-email-kishon@ti.com>
	<4D47FB19.9040901@nokia.com>
	<20110201194436.74826dd0.jhnikula@gmail.com>
	<AANLkTimzjg3+yGwz1sa+dfWyrjaS1mO+zn_LT3hhDHdQ@mail.gmail.com>
	<20110217234140.GH20795@atomide.com>
	<20110218100822.751b28d5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50288 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752519Ab1BRIUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 03:20:55 -0500
Received: by mail-gx0-f175.google.com with SMTP id 1so1339165gxk.6
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 00:20:55 -0800 (PST)
In-Reply-To: <20110218100822.751b28d5.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com

Hi,

I'll send patch series in a short while.

-Kishon

On Fri, Feb 18, 2011 at 1:38 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Thu, 17 Feb 2011 15:41:40 -0800
> Tony Lindgren <tony@atomide.com> wrote:
>
>> > > Actually this part of code doesn't compile for CONFIG_ARCH_OMAP2=
 if
>> > > CONFIG_ARCH_OMAP3 is not set. Reason is that the buffer_size in =
under
>> > > CONFIG_ARCH_OMAP3 compilation in struct omap_mcbsp_platform_data
>> > > definition.
>> > >
>> > > I think it's easiest if this patch just removes that conditional
>> > > compilation from struct omap_mcbsp_platform_data as it really do=
esn't
>> > > save that much from non !OMAP3 builds.
>> >
>> > =A0 Thanks. Will fix it in the next version.
>>
>> Any news on updating this series?
>>
>> Note that you can now leave out the omap4 hwmod data as that has
>> been merged to omap-for-linus.
>>
> My impression from last round was that there is not that many changes
> required. Of course there must not have bisect issues like above, sho=
uld
> not break OMAP1 (which I think was addressed already) but otherwise I
> think most of the issues were small.
>
> Kevin had concerns about PM testing but I would not put that much
> emphasis on that since the set should not make things any worse but
> should make possible to go forward with PM.
>
> --
> Jarkko
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
