From: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Subject: Re: [PATCH] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 17:59:10 +0200
Message-ID: <4EE8C7CE.3030009@nokia.com>
References: <1323867676-15956-1-git-send-email-vladimir.zapolskiy@nokia.com> <alpine.DEB.2.00.1112141742530.28200@kernel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1112141742530.28200@kernel.research.nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 12/14/2011 05:45 PM, Aaro Koskinen wrote:
> Hi,
>
> On Wed, 14 Dec 2011, Vladimir Zapolskiy wrote:
>> This change adds initialization of TSC2005 touchscreen controller
>> found on Nokia RX-51 board.
>>
>> The change is taken from MeeGo kernel adaptation for Nokia N900,
>> it repeats the work of Aaro Koskinen and Mika Laitio, the original
>> discussion is at
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html
>
> I think Tony applied this already:
>
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=3dad5356aa47097cf67027cf0a07298b4f5baef6
>

great, I haven't noticed that initially. In that case please ignore the 
duplicate.

>
> And that patch was from Maemo, not MeeGo kernel...
>
> A.

--
With best wishes,
Vladimir
