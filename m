From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/7] tty: 8250: omap eliminate use of of_machine_is_compatible()
Date: Thu, 9 Jul 2015 16:48:12 +0530
Message-ID: <559E5874.3040307@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com> <bf1f3478de98a74a3c92246d6a5d86bc71aa0cf8.1436174801.git.nsekhar@ti.com> <559DB989.1040501@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559DB989.1040501-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Thursday 09 July 2015 05:30 AM, Peter Hurley wrote:
> Hi Sekhar,
> 
> On 07/06/2015 05:47 AM, Sekhar Nori wrote:
>> Use of of_machine_is_compatible() for AM335x specific DMA
>> quirk in 8250_omap driver makes it ugly to extend the
>> quirk for other platforms. Instead use a new compatible.
>>
>> The new compatible will also make it easier to care of other
>> quirks specific to AM335x and like SoCs.
>>
>> This patch does break backward DTB compatibility for users of
>> 8250_omap driver on AM335x boards.
> 
> Not ok.
> 
> 8250_omap was released with 3.19 and has been the default driver for
> BeagleBone since 4.0.

Alright, I guess I was really stretching my luck here. Will keep the
of_machine_is_compatible() around so there should be no backward
compatibility issue.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
