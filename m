From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 02 Mar 2011 21:55:39 -0800
Message-ID: <4D6F2D5B.10009@codeaurora.org>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>	<4D6D9B10.9000606@codeaurora.org>	<4D6D9D06.2020204@bluewatersys.com>	<4D6D9FC7.1090206@codeaurora.org>	<4D6DA290.2010607@bluewatersys.com>	<4D6DAA24.3000204@codeaurora.org>	<4D6DAE6E.4030701@bluewatersys.com>	<4D6DB1B1.4060908@codeaurora.org>	<4D6DFE67.3020801@stericsson.com>	<AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
	<4D6E218F.2020804@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D6E218F.2020804@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, Ryan Mallon <ryan@bluewatersys.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Jouni Hogander <jouni.hogander@noki>
List-Id: linux-omap@vger.kernel.org

On 03/02/2011 02:53 AM, Maxime Coquelin wrote:
> On 03/02/2011 11:36 AM, Linus Walleij wrote:
>> On Wed, Mar 2, 2011 at 9:23 AM, Maxime Coquelin
>> <maxime.coquelin-nonst@stericsson.com> wrote:
>>
>>> I think we should have a tree like this :
>>>
>>> /sys/devices/system/soc/
>>> /sys/devices/system/soc/unique_id<- Unified way to export an ID for
>>> all machs
>> Arbitrary number of bits? Some will have a 64-bit ID, some will have
>> 32-bit
>> etc.
>
> Yes, here is the difficulty. For example, in our case, the SoC unique ID
> is 160 bits long.
> Maybe it would be a better solution to get rid of this unified file, and
> keep only mach specific entries? I mean :
>
> /sys/devices/system/soc/
> /sys/devices/system/soc/mach_name
> /sys/devices/system/soc/foo_id
> /sys/devices/system/soc/bar_id

Sorry for the late reply guys. Got wrapped up is some other stuff.

I'm with Maxime on getting rid of the unique id file. It's not as if 
it's unique across all machs and archs. Any user space caring to look at 
the id will anyway have to check the mach/family first. So, there is no 
point in having this unique id file. It just adds more weirdness and 
complexity to deal with the different formats or ways each family wants 
to export the id. Actually, in the case of MSM, we don't have any need 
to export unique id. We just want to export what type of soc it is 
within the MSM family.

As for the path, it's not clear we have settled on the final path. I see 
us ping-pong between /sys/devices/system/soc/ and 
/sys/devices/system/soc/mach/. Can we drop the "mach" subdir? Seems 
pointless.

The mandatory file, I would like to call it "family", since "mach" is 
too specific (omap3 and omap4 is my usual example -- they can have one 
implementation of socinfo and report the family as "omap"). We don't 
want people to misunderstand "mach" to be an accurate representation of 
the xxxx in mach-xxxx.

The patch that adds this should probably allow each socinfo 
implementation to specify the family name and an array of attributes 
(struct attribute *) that can be used to expose whatever else they want 
to export.

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
