From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Tue, 01 Mar 2011 17:39:19 -0800
Message-ID: <4D6D9FC7.1090206@codeaurora.org>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>	<20110216115729.GA29817@besouro.research.nokia.com>	<4D6B78BF.1020102@stericsson.com>	<4D6C7B56.9060109@codeaurora.org>
	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D6D9D06.2020204@bluewatersys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, ext Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, linux-arm-msm@vger.kernel.org, loic.pallardy@stericsson.com, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 03/01/2011 05:27 PM, Ryan Mallon wrote:
> On 03/02/2011 02:19 PM, Saravana Kannan wrote:
>> On 03/01/2011 05:13 PM, Andrei Warkentin wrote:
>>> On Mon, Feb 28, 2011 at 10:51 PM, Saravana Kannan
>>> <skannan@codeaurora.org>   wrote:
>
> <snip>
>
>>> What would an "arch" file mean? The name of the soc platform?
>>
>> The arch file would pretty much be the "xxxx" from arch/arm/mach-xxxx or
>> similar paths. If that info is already available elsewhere, then that
>> file is not needed. I proposed using the arch since that will remove the
>> need to maintain some database of unique/reserved names/numbers for each
>> implementation of socinfo (like the machinetypes list we have).
>
> /proc/cpuinfo already tells you what the CPU is, which gives more
> information than just the architecture name.
>
> Why is the arch information even required by userspace?

The socinfo exported by each soc is different. If userspace is trying to 
make decisions based on socinfo, it will need to know what type of soc 
(really what type of socinfo implementation) it is before trying to 
interpret the rest of the socinfo files. Keep in mind that cpuinfo is 
different from socinfo -- the cpu is just a small part of a soc.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
