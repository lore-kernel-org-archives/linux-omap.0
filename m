From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 1/9] mailbox: OMAP: introduce mailbox framework
Date: Fri, 11 Jan 2013 07:34:12 -0600
Message-ID: <CAJ6Av5M==RCCc-ngKMebPgqUwVT5Gr7E=NNk4Rr2OQK5TzfORQ@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<1355836212-17956-2-git-send-email-loic.pallardy-ext@stericsson.com>
	<20121218165909.GF4989@atomide.com>
	<50D423C2.3090009@st.com>
	<B5906170F1614E41A8A28DE3B8D121433EC9CF77@DBDE01.ent.ti.com>
	<50D43FA4.8090000@st.com>
	<B5906170F1614E41A8A28DE3B8D121433ECDD8C1@DBDE01.ent.ti.com>
	<50ED62B3.50000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50ED62B3.50000@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Loic PALLARDY <loic.pallardy@st.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Tony Lindgren <tony@atomide.com>, Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Gutierrez, Juan" <jgutierrez@ti.com>, Arnd Bergmann <arnd@arndb.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>, "Anna, Suman" <s-anna@ti.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, linux-arm-kernel
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 9, 2013 at 6:29 AM, Loic PALLARDY <loic.pallardy@st.com> wrote:
> Hi Vaibhav,
>
> On 01/09/2013 01:11 PM, Bedia, Vaibhav wrote:
>> Hi Loic,
>>
>> On Fri, Dec 21, 2012 at 16:23:24, Loic PALLARDY wrote:
>>>
>>>
>>> On 12/21/2012 11:49 AM, Bedia, Vaibhav wrote:
>>>> On Fri, Dec 21, 2012 at 14:24:26, Loic PALLARDY wrote:
>>>>>
>>>> I have a few patches which are dependent on this patch series.
>>>> Could you please keep me in cc for the future versions.
>>>>
>>> Sure, I'll.
>>>
>>
>> When do you plan to post an updated version of these patches?
> I'm synchronizing with Omar to include TI RPMsg and tidspbridge patches
> in next update.
> So I plan update for end of the week, beginning of next week.

Here are my patches, I didn't post them to the list since they are
meant to be squashed, I also prepared a squashed version of the
original set, in case it is easier to take that one, all rebased into
3.8-rc1. Branches: mailbox-3.8-rc1-separate-changes and
mailbox-3.8-rc1, respectively.

>From tree: https://github.com/omarrmz/upstream-wip

Cheers,

Omar
