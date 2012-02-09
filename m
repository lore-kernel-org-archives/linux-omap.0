From: Olof Johansson <olof@lixom.net>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Wed, 8 Feb 2012 17:19:21 -0800
Message-ID: <CAOesGMjm+irNw-kHStLf_H3QyJHa04ProG6i0Zyum1iy7TJxpA@mail.gmail.com>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
 <20120126212319.GE11941@n2100.arm.linux.org.uk>
 <CAOesGMh45HSb4mRMc7q53xhmj_kMFvdVJhNnY7cY6gHi=_KynQ@mail.gmail.com>
 <4F266C13.5080302@atmel.com>
 <CAOesGMh1wHpaDmYY6_oCu_u0s4fmTfKMLiPaa9bHh9YaiDJozw@mail.gmail.com>
 <4F326213.3030500@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F326213.3030500@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: davinci-linux-open-source@linux.davincidsp.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 8, 2012 at 3:52 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wro=
te:
> On 02/08/2012 02:18 AM, Olof Johansson :
>> Hi,
>>
>> On Mon, Jan 30, 2012 at 2:08 AM, Nicolas Ferre <nicolas.ferre@atmel.com>=
 wrote:
>>> On 01/29/2012 12:57 AM, Olof Johansson :
>>>> Hi,
>>>>
>>>>
>>>> On Thu, Jan 26, 2012 at 1:23 PM, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>>
>>>>
>>>>> And we're now there. =A0So...
>>>>>
>>>>> Arnd, Olaf,
>>>>>
>>>>> Please incorporate the latest ARM (for-armsoc branch) changes, which =
can be found at:
>>>>>
>>>>> =A0 =A0 =A0 =A0git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cu=
r/linux-arm.git for-armsoc
>>>>>
>>>>> with SHA1 dcf81c1af839b77b44404453ecae6e5ac5a75f05.
>>>>
>>>> Thanks. I have added this as depends/rmk/for-armsoc in the arm-soc rep=
o.
>>>>
>>>> Any next/ branch we start will have this as the base of said branch,
>>>> so any vendor branches must either already be developed against this
>>>> stable branch, or merge on top of this with minimal conflicts.
>>>
>>> Ok, great.
>>>
>>> I just let you know that there is a conflict between the current Linus'
>>> tree (with recently updated at91 fixes) and this rmk/for-armsoc branch.
>>>
>>> I can give you the resolution of this conflict easily but I would like
>>> to know which way I execute the merge:
>>>
>>> I use this rmk/for-armsoc as a baseline and merge the fixes already in
>>> Linus' tree on top of it or the other way around?
>>>
>>> Maybe it is preferable that I wait for 3.3-rc2 and merge rmk/for-armsoc
>>> on top of it. This result can be the base of our AT91 work for 3.4
>>> preparation.
>>>
>>> Your thought?
>>
>> I missed replying to this email until now when I started looking at
>> picking up branches for the 3.4 staging, sorry for the delay.
>>
>> Russell, would you prefer merging in v3.3-rc2 into your branch so I
>> can pull the exact same resolution from there, or should we do it
>> locally in arm-soc? It probably makes sense for you to do it so
>> there's no more conflicts from there on out for dependent branches.
>
> Olof,
>
> For your information the conflict resolution is already present in
> linux-next (and in my 3.4 preparation branches actually).

Yeah, it's just convenient if it's resolved once in the base branch
instead of every time we pull in something based on it.

I've pulled in and resolved the conflict with v3.3-rc2 into
depends/rmk/for-armsoc now so it should be covered for anyone basing
new branches off of it.


Thanks,

-Olof
