From: Sergio Aguirre <sergio.a.aguirre@gmail.com>
Subject: Re: [PATCH v3 08/10] arm: omap4panda: Add support for omap4iss camera
Date: Wed, 23 May 2012 23:45:22 -0500
Message-ID: <CAC-OdnBLvZ2TR52bRHXDDtsvo-PUJ-N2Qj3gWaGhq3Ri+dv-bw@mail.gmail.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
	<1335971749-21258-9-git-send-email-saaguirre@ti.com>
	<20120508234641.GV5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20120508234641.GV5088@atomide.com>
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, May 8, 2012 at 6:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Sergio Aguirre <saaguirre@ti.com> [120502 08:21]:
>> This adds support for camera interface with the support for
>> following sensors:
>>
>> - OV5640
>> - OV5650
>
> It seems that at this point we should initialize new things like this
> with DT only. We don't quite yet have the muxing in place, but I'd
> rather not add yet another big platform_data file for something that
> does not even need to be there for DT booted devices.

Ok.

I'll look at that.

By the way, I've been very out of the loop on al DT related development=
=2E.

Are these instructions valid for current master k.org branch?

http://omappedia.org/wiki/Device_Tree#Booting_with_DT_blob

Regards,
Sergio

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
