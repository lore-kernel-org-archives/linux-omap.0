From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH v5 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
Date: Tue, 11 Sep 2012 09:50:04 +0200
Message-ID: <CAN5iSWp4WhfhLd6K=qfyjvZOhp6K3hhOFJjey_0+00KZTa-+pQ@mail.gmail.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
 <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
 <alpine.DEB.2.00.1208151842380.8833@utopia.booyaka.com>
 <CAMQu2gyV6gX=KFjMZ1r_BwsJXmgjuLMAWHrrLCYLgKEBRne0Ow@mail.gmail.com>
 <1347289778.10702.128.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1347289778.10702.128.camel@sokoban>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: t-kristo@ti.com, Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tero, Paul,

After discussion with Paul at LPC I produced a new version that we are
now internally reviewing.

Paul, what is your plan?

Regards,
Jean

On Mon, Sep 10, 2012 at 5:09 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Thu, 2012-08-16 at 11:20 +0530, Shilimkar, Santosh wrote:
>> Paul,
>>
>> On Thu, Aug 16, 2012 at 6:18 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > Hi Santosh,
>> >
>> > On Wed, 15 Aug 2012, Shilimkar, Santosh wrote:
>> >
>> > > On Wed, Aug 15, 2012 at 3:32 PM, Jean Pihet <jean.pihet@newoldbits.c=
om>
>> > > wrote:
>> > >
>> > > I didn't find any mention here about why are we going in this path a=
nd
>> > > not
>> > > in the direction proposed in another RFC [1]
>> > > I have already given my comments[2] against the introduction of anot=
her
>> > > PD
>> > > layer which can be avoided easily as demonstrated by the RFC[1]. The
>> > > comments
>> > > are still applicable for this series too.
>> > >
>> > > We really need to reduce OMAP specific framework overhead and
>> > > move towards more generic PM frameworks. For me, this series is
>> > > a step back-ward from that direction. Am really sorry for being crit=
ical
>> > > again but I remain unconvinced about this series and the problem it
>> > > is trying to solve.
>> > >
>> > > May be you have valid reasons not to follow the approach in [1] and =
in
>> > > that case, it will be good to clarify that so that some of us get
>> > > to know your rationale.
>> >
>> > I've asked Jean to handle the work of evaluating and/or integrating any
>> > feedback from you and Rajendra into this series.  Jean, has this latest
>> > series fully considered those issues?  Or are there still some areas of
>> > misalignment / lack of clarity?
>> >
>> Thanks for the information. The main objection to this series was to
>> not add un-necessary glue layer which still remains.
>>
>> From our discussion in past on and off list, your main intention for such
>> a series was -
>>
>> 1. Need a way to support OSWR.
>> - OSWR by definition is a RET with configurable logic and memory states.
>> Its a true power state from PD point of view and its not a logical state.
>> Now since we have agreed to make the OSWR as a static definition
>> (in all products so far OSWR is used as a static definition with logic
>> lost, memory retained kind of configuration.)
>>
>> - The above requirement can be easily fixed by adding the OSWR
>> as an additional basic power state as demonstrated in RFC.
>>
>> - There is no need to add another glue layer for above.
>>
>> 2. Locking so that the low level APIs don't race and henec abstracting t=
he
>> exported API to 1 or 2 and making rest as private functions.
>>
>> -- Even before this series, except low level PM code, only one
>> common API was used to set the PD low power state.
>> int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
>>
>> -- Once we make OSWR as basic power state, we also avoid usage of
>> pwrdm_set_logic_retst() API.
>>
>> -- We implement lock at this API and export only above API +
>> may be omap_get_pwrdm_state() kind of API based on need.
>>
>> -- This solves the second requirement too.
>>
>> Even if we have more requirement, they can be addressed
>> too without need of another layer.
>>
>> If you look at the diffstat alone between two approaches, it is
>> evident how small piece of code is needed to support above.
>> Am not too much into the lines of code but basic objection we
>> have is not to add another glue layer.
>>
>> Thinking bit loud, for the logical layer for power domain
>> we should move towards common device power domain
>> APIs and if needed add/enhance them to support OMAP.
>>    drivers/base/power/domain.c
>> May be this though is bit premature but the intetion is
>> to move towards generic linux framework.
>>
>> > Anyway.  If there's a problem with this process, it sounds like you,
>> > Rajendra, Jean, Beno=EEt and I should schedule some time to talk over =
the
>> > same issues that you discussed with me on the phone.  Perhaps next wee=
k?
>> >
>> We can surely do a call if needed. But the comments given so far and the
>> RFC makes things more or less clear the contention point against the
>> $subject series.
>
> What is the latest status with this set? This is kind of blocking the
> omap4 core retention feature also as I am supposed to put the patches on
> top of this set. Do we have a consensus which way this set should
> evolve?
>
> Or, should I just base the core retention patches on top of baseline and
> forget about the functional power states for now?
>
> -Tero
>
