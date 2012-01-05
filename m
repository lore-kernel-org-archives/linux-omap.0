From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Wed, 4 Jan 2012 17:01:43 -0800
Message-ID: <CAJOA=zPw7UuhE4R3SsBeyzQ2_iN29Zv-ExaUTTFCah+GoFSfNQ@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-4-git-send-email-mturquette@linaro.org>
	<alpine.LFD.2.02.1112141007550.3020@ionos>
	<CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
	<20120104021541.GI2414@b20223-02.ap.freescale.net>
	<4F0462FF.1000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F0462FF.1000308-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 4, 2012 at 6:32 AM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 01/03/2012 08:15 PM, Richard Zhao wrote:
>> On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
>>> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> w=
rote:
>>>> On Tue, 13 Dec 2011, Mike Turquette wrote:
>
> snip
>
>>>>> +/**
>>>>> + * clk_init - initialize the data structures in a struct clk
>>>>> + * @dev: device initializing this clk, placeholder for now
>>>>> + * @clk: clk being initialized
>>>>> + *
>>>>> + * Initializes the lists in struct clk, queries the hardware for the
>>>>> + * parent and rate and sets them both. =A0Adds the clk to the sysfs =
tree
>>>>> + * topology.
>>>>> + *
>>>>> + * Caller must populate clk->name and clk->flags before calling
>>>>
>>>> I'm not too happy about this construct. That leaves struct clk and its
>>>> members exposed to the world instead of making it a real opaque
>>>> cookie. I know from my own painful experience, that this will lead to
>>>> random fiddling in that data structure in drivers and arch code just
>>>> because the core code has a shortcoming.
>>>>
>>>> Why can't we make struct clk a real cookie and confine the data
>>>> structure to the core code ?
>>>>
>>>> That would change the init call to something like:
>>>>
>>>> struct clk *clk_init(struct device *dev, const struct clk_hw *hw,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *parent)
>>>>
>>>> And have:
>>>> struct clk_hw {
>>>> =A0 =A0 =A0 struct clk_hw_ops *ops;
>>>> =A0 =A0 =A0 const char =A0 =A0 =A0 =A0*name;
>>>> =A0 =A0 =A0 unsigned long =A0 =A0 flags;
>>>> };
>>>>
>>>> Implementers can do:
>>>> struct my_clk_hw {
>>>> =A0 =A0 =A0 struct clk_hw =A0 =A0hw;
>>>> =A0 =A0 =A0 mydata;
>>>> };
>>>>
>>>> And then change the clk ops callbacks to take struct clk_hw * as an
>>>> argument.
>> We have to define static clocks before we adopt DT binding.
>> If clk is opaque and allocate memory in clk core, it'll make hard
>> to define static clocks. And register/init will pass a long parameter
>> list.
>
> DT is not a prerequisite for having dynamically created clocks. You can
> make clock init dynamic without DT.

Agreed.

> What data goes in struct clk vs. struct clk_hw could change over time.
> So perhaps we can start with some data in clk_hw and plan to move it to
> struct clk later. Even if almost everything ends up in clk_hw initially,
> at least the structure is in place to have common, core-only data
> separate from platform data.

What is the point of this?

The original clk_hw was defined simply as:

struct clk_hw {
        struct clk *clk;
};

It's only purpose in life was as a handle for navigation between the
opaque struct clk and the hardware-specific struct my_clk_hw.  struct
clk_hw is defined in clk.h and everyone can see it.  If we're suddenly
OK putting clk data in this structure then why bother with an opaque
struct clk at all?

> What is the actual data you need to be static and accessible to the
> platform code? A ptr to parent clk is the main thing I've seen for
> static initialization. So make the parent ptr be struct clk_hw* and
> allow the platforms to access.

To answer your question on what data we're trying to expose: platform
code commonly needs the parent pointer and the clk rate (and by
extension, the rate of the parent).  For debug/error prints it is also
nice to have the clk name.  Generic clk flags are also conceivably
something that platform code might want.

I'd like to spin the question around: if we're OK exposing some stuff
(in your example above, the parent pointer), then what clk data are
you trying to hide?

Regards,
Mike

>
> Rob
