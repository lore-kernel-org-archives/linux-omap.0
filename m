From: Keerthy <a0393675@ti.com>
Subject: Re: [RFT PATCH] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Tue, 25 Aug 2015 11:12:48 +0530
Message-ID: <55DC0058.7080101@ti.com>
References: <1439892601-19306-1-git-send-email-j-keerthy@ti.com> <20150824212442.GI7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150824212442.GI7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 25 August 2015 02:54 AM, Russell King - ARM Linux wrote:
> On Tue, Aug 18, 2015 at 03:40:01PM +0530, Keerthy wrote:
>> Currently apart from dra7, omap5 and amx3 all the other SoCs
>> are identified using cpu_is_* functions which is not right since
>> they are all SoCs(System on Chips). Hence changing the SoC
>> identific=E4tion code to use soc_is instead of cpu_is and keeping
>             ^
> typo

I will correct and send a v2.

>
>> defines for cpu_is where needed. This allows us to replace the
>> rest of cpu_is usage along with other fixes as needed.
>
> Good to see this change to a more sensible naming of these, despite
> the obvious churn.
>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks Russel. I will fix the above typo and add your Ack in the next=20
version.

>
