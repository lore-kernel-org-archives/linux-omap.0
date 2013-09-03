From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 3 Sep 2013 12:07:16 -0700
Message-ID: <CAGa+x86XVetqMGMTh7LoX6VAEb-d0W67_SbgTCxk4Q=QovpKTQ@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <87ppsw7cgq.fsf@linaro.org>
 <CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
 <874na8xqfl.fsf@linaro.org>
 <CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
 <87hae8tc6e.fsf@linaro.org>
 <CA+Bv8XaQgOiSiScQW=CVxzXBuG0soafQotApjoVEZ0P9U3netg@mail.gmail.com>
 <87eh9bqi1x.fsf@linaro.org>
 <CA+Bv8XakgQZoeB8OTWsq1uUTcPfuxcD1qP9wnhu4HK22FMxFNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XakgQZoeB8OTWsq1uUTcPfuxcD1qP9wnhu4HK22FMxFNQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: devicetree@vger.kernel.org, =?ISO-8859-1?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>, Mark Brown <broonie@kernel.org>, Vaibhav Bedia <vaibhav.bedia@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 3, 2013 at 11:55 AM, Russ Dill <Russ.Dill@ti.com> wrote:
> On Fri, Aug 30, 2013 at 9:06 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> Well, I was thinking of something much dumber.
>>
>> I was thinking about just _carefully_ writing a single, self-contained C
>> function, with all of its data on the stack (and consts as #defines).
>> Think of it is a step up in readability from straight assembly (which
>> was the stated reason for moving the code to the M3 in the first place.)
>>
>> Kevin
>
> That can only give you your suspend function. You need a resume
> function to undo everything before calling cpu_resume, and the resume
> function needs access to the data that was in the suspend function.

Well, it can be done (and I've seen it done) with various hacks, but I
agree it's not pretty, but it is at least slightly prettier than piles
of asm.  That being said, I saw you posted a more generic solution
that looks like a real solution that can scale.  I'll have a closer
look at that.  Thanks for working on it.

Kevin
