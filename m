From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv3 03/14] mailbox: OMAP: introduce mailbox framework
Date: Thu, 14 Mar 2013 09:14:26 +0100
Message-ID: <CACRpkdbUBkhkQ-ZiqkLUmsDBp3hw4k3Z1s4i4SD3C2ZfuGUF+w@mail.gmail.com>
References: <1363145044-14442-1-git-send-email-s-anna@ti.com>
	<CACRpkdY8ZWNUVHJorbhN7XvOys9KJH8hKeCBYARih=1FiNk-CQ@mail.gmail.com>
	<37C860A02101E749A747FA2D3C1E3C50498B8E@DLEE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C50498B8E@DLEE11.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic Pallardy <loic.pallardy@st.com>, Omar Ramirez Luna <omar.luna@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 13, 2013 at 10:34 PM, Anna, Suman <s-anna@ti.com> wrote:
>> On Wed, Mar 13, 2013 at 4:24 AM, Suman Anna <s-anna@ti.com> wrote:
>>
>> > From: Omar Ramirez Luna <omar.luna@linaro.org>
>> (...)
>> >
>> > Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
>> > [s-anna@ti.com: Kconfig fixes for build errors]
>> > Signed-off-by: Suman Anna <s-anna@ti.com>
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> It's not like I care super-much, but I think your SoB should be at the bottom.
>>
>> It's a simple git rebase -i anyway...
>
> Sure, will do. Only this patch, right? I have my SoB only on one another original patch, will adjust on that as well, but all the remaining ones will have yours at the bottom.

No I mean that the SoB-order should reflect the code flow path, and
yours should be
at the bottom of all of them, but as noted I don't care much. In my
case the only thing
I did was to pass the code :-)

Yours,
Linus Walleij
