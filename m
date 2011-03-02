From: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 2 Mar 2011 09:23:03 +0100
Message-ID: <4D6DFE67.3020801@stericsson.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>	<4D6D9B10.9000606@codeaurora.org>	<4D6D9D06.2020204@bluewatersys.com>	<4D6D9FC7.1090206@codeaurora.org>	<4D6DA290.2010607@bluewatersys.com>	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D6DB1B1.4060908@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, ext Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Andrei Warkentin <andreiw@motorola.com>
List-Id: linux-omap@vger.kernel.org

On 03/02/2011 03:55 AM, Saravana Kannan wrote:
> On 03/01/2011 06:41 PM, Ryan Mallon wrote:
>> On 03/02/2011 03:23 PM, Saravana Kannan wrote:
>>> I don't have any attachment to the "arch" file suggestion. If there is a
>>> better solution to identify the different implementations of socinfo
>>> without having to maintain some "unique id" list in the kernel, then I'm
>>> all for it. But cpuinfo is not it.
>> Sorry I am confusing the 'arch' and 'mach' bits here. I definitely have
>> an objection to having an 'arch' file (i.e. ARM). A 'mach' (i.e. omap)
>> file makes a bit more sense, but should probably be called 'mach' rather
>> than 'arch' to avoid this confusion :-).
> Sorry for the confusion. Sure, I don't care much for the filename as
> long as we can all agree on it. I care more about the content of the
> file (using names very close to xxxx in mach-xxxx). I like "soc-family"
> better since it's generic enough to not force, say omap3 and omap4, to
> report different values.
>
> Linus Walleij, Eduardo, Maxime, Andrei,
>
> Would like to hear your opinion on the file name (soc-family vs. mach vs
> <somethingelse>) and the path /sys/devices/system/soc/.
>
> If we settle on this, may be it would be easier to get this through.
>

I think we should have a tree like this :

/sys/devices/system/soc/
/sys/devices/system/soc/unique_id<- Unified way to export an ID for all machs
/sys/devices/system/soc/mach/
/sys/devices/system/soc/mach/name<- Name of the mach
/sys/devices/system/soc/mach/foo_id
/sys/devices/system/soc/mach/bar_id<- Vendors may have several/different IDs to export (IDCODE for OMAP, Production ID...)

Linus, do you agree?

>> I still think it is a solution in search of a problem though. What
>> userspace programs need to know what specific SoC they are on? My
>> feeling is that if userspace needs to know this information, then it is
>> probably dicking around with things that should be managed by the
>> kernel. Differences in available peripherals, etc can be determined by
>> looking at existing sysfs files.
> I certainly have seen several use cases. Couple of easy examples:
>
> * A lot of test scripts would find this very useful. For example, some
> clock (present is all/most MSMs) shouldn't be tested on some SOCs as it
> would lock up the system if you try to turn it off while the CPU is running.
>
> * Some of the user space tools might want to report different "product
> id/type" (nothing to do with USB, etc) depending on what SOC it is
> running on.
>

For example, we have some user-space tools which need to have serial 
number to write it in logs.

> Thank,
> Saravana
> P.S: Removed felipe.balbi@nokia.com<felipe.balbi@nokia.com>  since I
> keep getting delivery failure emails.
>
