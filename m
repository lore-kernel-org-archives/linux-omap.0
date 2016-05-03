From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Tue, 3 May 2016 21:08:54 +0300
Message-ID: <5728E936.2010503@ti.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
 <1462209123-7332-3-git-send-email-Linux.HWI@garmin.com>
 <57285E66.2000708@ti.com> <5728A81F.4050906@garmin.com>
 <20160503164323.GN5995@atomide.com> <5728E0BC.3080509@ti.com>
 <5728E495.4010502@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5728E495.4010502@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jay.schroeder@garmin.com, Matthijs van Duin <matthijsvanduin@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 03/05/16 20:49, J.D. Schroeder wrote:
> On 05/03/2016 12:32 PM, Tero Kristo wrote:
>> Personally I would not recommend using this clock for any timing sensitive
>> applications. May I ask why you are interested in the exact clock rate of this
>> clock anyway?
>
> I'm not interested in using this clock and I'm not sure how anyone would use
> this clock outside of the processor. See the inline comment that is part of
> the change and the commit message for the change. There is no hint in my
> change that this is an exact clock rate. It is a clarifying change to help
> others avoid using this clock as a 32 kHz clock (which the current clock name
> and frequency imply) and it more accurately represents the actual hardware
> behavior.
>

Imo, if you want to clarify things up, the whole secure_32k_ck should be 
removed from linux kernel.

-Tero
