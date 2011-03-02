From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 02 Mar 2011 15:41:50 +1300
Message-ID: <4D6DAE6E.4030701@bluewatersys.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>	<4D6D9B10.9000606@codeaurora.org>	<4D6D9D06.2020204@bluewatersys.com>	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D6DAA24.3000204@codeaurora.org>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, ext Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Andrei Warkentin <andreiw@motorola.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, linux-arm-msm@vger.kernel.org, loic.pallardy@stericsson.com, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Jouni Hogander <joun>
List-Id: linux-omap@vger.kernel.org

On 03/02/2011 03:23 PM, Saravana Kannan wrote:
> On 03/01/2011 05:51 PM, Ryan Mallon wrote:
>> On 03/02/2011 02:39 PM, Saravana Kannan wrote:
>>> On 03/01/2011 05:27 PM, Ryan Mallon wrote:
>>>> On 03/02/2011 02:19 PM, Saravana Kannan wrote:
>>>>> On 03/01/2011 05:13 PM, Andrei Warkentin wrote:
>>>>>> On Mon, Feb 28, 2011 at 10:51 PM, Saravana Kannan
>>>>>> <skannan@codeaurora.org>    wrote:
>>>>
>>>> <snip>
>>>>
>>>>>> What would an "arch" file mean? The name of the soc platform?
>>>>>
>>>>> The arch file would pretty much be the "xxxx" from
>>>>> arch/arm/mach-xxxx or
>>>>> similar paths. If that info is already available elsewhere, then that
>>>>> file is not needed. I proposed using the arch since that will
>>>>> remove the
>>>>> need to maintain some database of unique/reserved names/numbers for
>>>>> each
>>>>> implementation of socinfo (like the machinetypes list we have).
>>>>
>>>> /proc/cpuinfo already tells you what the CPU is, which gives more
>>>> information than just the architecture name.
>>>>
>>>> Why is the arch information even required by userspace?
>>>
>>> The socinfo exported by each soc is different. If userspace is trying to
>>> make decisions based on socinfo, it will need to know what type of soc
>>> (really what type of socinfo implementation) it is before trying to
>>> interpret the rest of the socinfo files. Keep in mind that cpuinfo is
>>> different from socinfo -- the cpu is just a small part of a soc.
>>
>> I understand that having a socinfo file for obtaining information about
>> a particular SoC would be useful. A similar discussion came up a few
>> years ago when we talked about having a socinfo file for exposing the
>> ep93xx Maverick crunch id, but nothing ever came out of it.
>>
>> What I don't understand is why you want the 'arch' file (ie the
>> mach-xxxx) name. /proc/cpuinfo already gives you more information than
>> an 'arch' file would. I also can't think of a particularly good
>> situation why userspace would need to know at runtime what the
>> architecture is.
>>
>> Have a socinfo file to expose implementation details of the particular
>> SoC I am fine with (assuming those details are useful to userspace),
>> having an 'arch' file to expose the architecture I am against.
> 
> You probably already understood this, but just to be sure, when I say
> "socinfo implementation" I mean the various ways the socinfo data should
> be interpreted by userspace. "socid" of 1 would mean a different thing
> depending on whether it's for omap, msm, kirkwood, etc.
> 
> I don't have any attachment to the "arch" file suggestion. If there is a
> better solution to identify the different implementations of socinfo
> without having to maintain some "unique id" list in the kernel, then I'm
> all for it. But cpuinfo is not it.

Sorry I am confusing the 'arch' and 'mach' bits here. I definitely have
an objection to having an 'arch' file (i.e. ARM). A 'mach' (i.e. omap)
file makes a bit more sense, but should probably be called 'mach' rather
than 'arch' to avoid this confusion :-).

I still think it is a solution in search of a problem though. What
userspace programs need to know what specific SoC they are on? My
feeling is that if userspace needs to know this information, then it is
probably dicking around with things that should be managed by the
kernel. Differences in available peripherals, etc can be determined by
looking at existing sysfs files.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
