From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
 OMAP data
Date: Tue, 01 Mar 2011 18:55:45 -0800
Message-ID: <4D6DB1B1.4060908@codeaurora.org>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>	<4D6D9B10.9000606@codeaurora.org>	<4D6D9D06.2020204@bluewatersys.com>	<4D6D9FC7.1090206@codeaurora.org>	<4D6DA290.2010607@bluewatersys.com>	<4D6DAA24.3000204@codeaurora.org> <4D6DAE6E.4030701@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4D6DAE6E.4030701@bluewatersys.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, ext Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, linux-arm-msm@vger.kernel.org, loic.pallardy@stericsson.com, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Paul Mundt <lethal@linux>
List-Id: linux-omap@vger.kernel.org

On 03/01/2011 06:41 PM, Ryan Mallon wrote:
> On 03/02/2011 03:23 PM, Saravana Kannan wrote:
>> I don't have any attachment to the "arch" file suggestion. If there is a
>> better solution to identify the different implementations of socinfo
>> without having to maintain some "unique id" list in the kernel, then I'm
>> all for it. But cpuinfo is not it.
>
> Sorry I am confusing the 'arch' and 'mach' bits here. I definitely have
> an objection to having an 'arch' file (i.e. ARM). A 'mach' (i.e. omap)
> file makes a bit more sense, but should probably be called 'mach' rather
> than 'arch' to avoid this confusion :-).

Sorry for the confusion. Sure, I don't care much for the filename as 
long as we can all agree on it. I care more about the content of the 
file (using names very close to xxxx in mach-xxxx). I like "soc-family" 
better since it's generic enough to not force, say omap3 and omap4, to 
report different values.

Linus Walleij, Eduardo, Maxime, Andrei,

Would like to hear your opinion on the file name (soc-family vs. mach vs 
<somethingelse>) and the path /sys/devices/system/soc/.

If we settle on this, may be it would be easier to get this through.

> I still think it is a solution in search of a problem though. What
> userspace programs need to know what specific SoC they are on? My
> feeling is that if userspace needs to know this information, then it is
> probably dicking around with things that should be managed by the
> kernel. Differences in available peripherals, etc can be determined by
> looking at existing sysfs files.

I certainly have seen several use cases. Couple of easy examples:

* A lot of test scripts would find this very useful. For example, some 
clock (present is all/most MSMs) shouldn't be tested on some SOCs as it 
would lock up the system if you try to turn it off while the CPU is running.

* Some of the user space tools might want to report different "product 
id/type" (nothing to do with USB, etc) depending on what SOC it is 
running on.

Thank,
Saravana
P.S: Removed felipe.balbi@nokia.com <felipe.balbi@nokia.com> since I 
keep getting delivery failure emails.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
