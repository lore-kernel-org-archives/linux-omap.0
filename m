From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: Droid 4 regression in 5.5-rc1, armsoc-soc tree
Date: Fri, 3 Jan 2020 16:11:27 +0100
Message-ID: <4839ea34-ba1a-c127-46f9-c574d19f0c4f@gmx.net>
References: <20191228162929.GA29269@duo.ucw.cz>
 <20191228193622.GA13047@duo.ucw.cz> <20191230173507.GM35479@atomide.com>
 <20200102110025.GA29035@amd>
 <CAK8P3a2Ya+GZRRA_THZBVDq7SWO8UYoUPwW5fEyorCVjPnd1qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a2Ya+GZRRA_THZBVDq7SWO8UYoUPwW5fEyorCVjPnd1qA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Partap <mpartap@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, martin_rysavy@centrum.cz, nekit1000@gmail.com, Sebastian Reichel <sre@kernel.org>, Olof Johansson <olof@lixom.net>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Am 02.01.20 um 12:49 schrieb Arnd Bergmann:
> On Thu, Jan 2, 2020 at 12:00 PM Pavel Machek <pavel@ucw.cz> wrote:
>> On Mon 2019-12-30 09:35:07, Tony Lindgren wrote:
>>> * Pavel Machek <pavel@ucw.cz> [191228 19:37]:
>>>> Hi!
>>>>
>>>>> 5.4-based kernel works ok on my droid 4.
>>>>>
>>>>> 5.5-rc3 based kernel has problems; it reboots when I try to kexec it.
>>>>>
>>>>> Vanilla 5.5-rc3 reboots, too.
>>>>>
>>>>> If you have any ideas, let me know.
>>>> I managed to get partial serial dump. This should be 5.5-rc3: And then
>>>> a bit better serial dump (below). But it is silent for few seconds,
>>>> and then it restarts...
>>> If spi or regulators have problems, nothing will really work..
>> arm-soc merge seems to be responsible:
>>
>> bad 38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6 Merge tag 'armsoc-soc' of
>> good d9e48dc2a71a836f17d1febbedb31470f957edb4 Merge tag
>>
>>                                                                         Pavel
>>
>> # bad: [738d2902773e30939a982c8df7a7f94293659810] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
>> git bisect start '738d2902773e' '219d54332a09'
>> # bad: [46cf053efec6a3a5f343fead837777efe8252a46] Linux 5.5-rc3
>> git bisect bad 46cf053efec6a3a5f343fead837777efe8252a46
>> # bad: [e42617b825f8073569da76dc4510bfa019b1c35a] Linux 5.5-rc1
>> git bisect bad e42617b825f8073569da76dc4510bfa019b1c35a
>> # good: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>> git bisect good 9a3d7fd275be4559277667228902824165153c80
>> # good: [0b4295b5e2b9b42f3f3096496fe4775b656c9ba6] io_uring: fix a typo in a comment
>> git bisect good 0b4295b5e2b9b42f3f3096496fe4775b656c9ba6
>> # good: [056df578c2dcac1e624254567f5df5ddaa223234] Merge tag 'arc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
>> git bisect good 056df578c2dcac1e624254567f5df5ddaa223234
>> # bad: [25cfb0c7de3f14e283a43dcd6de903657f9f98c7] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
>> git bisect bad 25cfb0c7de3f14e283a43dcd6de903657f9f98c7
>> # bad: [38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6] Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> git bisect bad 38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6
>> # good: [d9e48dc2a71a836f17d1febbedb31470f957edb4] Merge tag 'pwm/for-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
>> git bisect good d9e48dc2a71a836f17d1febbedb31470f957edb4
> In that branch, I see the following non-merge commits:
>
> ...
> 781fa0a95424 ARM: bcm: Add support for BCM2711 SoC
>
unfortunately this patch breaks multiplatform support and might be
affect you.

Please make sure this one is applied, while bisecting:

59034b9d6af8 ("ARM: bcm: Add missing sentinel to bcm2711_compat[]")

Sorry about this

Stefan
