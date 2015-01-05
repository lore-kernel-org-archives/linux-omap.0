From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Mon, 05 Jan 2015 06:47:39 -0600
Message-ID: <54AA87EB.1000004@ti.com>
References: <1420309826-7904-1-git-send-email-nm@ti.com> <20150103233949.GA4108@earth.universe>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150103233949.GA4108@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/03/2015 05:39 PM, Sebastian Reichel wrote:

> On Sat, Jan 03, 2015 at 12:30:26PM -0600, Nishanth Menon wrote:
>> [...]
>> +		gpio-fan,speed-map = <0    0
>> +				      13000 1>;
>> [...]
>
> iirc DT maintainers prefer this format:
>
> gpio-fan,speed-map = <0     0>,
>                       <13000 1>;
>
> This should result in the same .dtb, but is a bit easier to read.
>
yes indeed.. :( Thanks for catching it. will repost.

Regards,
Nishanth Menon
