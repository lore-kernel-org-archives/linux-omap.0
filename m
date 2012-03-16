From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 02/10] ARM: OMAP2+: SmartReflex: move the platform
 specific macros in plat-omap
Date: Fri, 16 Mar 2012 16:19:31 +0100
Message-ID: <CAORVsuUp9VBX1XbkQkcq91XsbRSut1RC6KCNPFHrX+RfWv7hQA@mail.gmail.com>
References: <1331829845-9526-1-git-send-email-j-pihet@ti.com>
	<1331829845-9526-3-git-send-email-j-pihet@ti.com>
	<20120315171359.GA7276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120315171359.GA7276@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thu, Mar 15, 2012 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [120315 09:47]:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Move the platform specific macros from the smartreflex header file
>> (arch/arm/mach-omap2/smartreflex.h) in a new header file in plat-omap
>> (arch/arm/plat-omap/include/plat/smartreflex.h).
>>
>> This change makes the SmartReflex implementation ready for the move
>> to drivers/.
>
> Glad to see this happening!
>
> This would be better located in linux/power/smartreflex.h rather than
> plat/smartreflex.h.
Ok. Is the file name still Ok in that case? Should it mention OMAP?

Thanks,
Jean

>
> Regards,
>
> Tony
