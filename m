From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
Date: Thu, 2 Feb 2012 20:54:08 +0530
Message-ID: <CAMQu2gxuQVYNvo8VeGrmZGo3tqCydhVaOz1VXjeAgrL8Opm8nA@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com>
 <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
 <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
 <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com>
 <CAMQu2gw5uU4kXRWtuUuYAAUcrTJvS_nQhJ42-_hEmHM2NO8ZZg@mail.gmail.com>
 <alpine.DEB.2.00.1202020302400.586@utopia.booyaka.com>
 <CAMQu2gxQHyoH-AC4ut2EGVs6wBvAJqUJ8tzXUm2hH_gZqMGE6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMQu2gxQHyoH-AC4ut2EGVs6wBvAJqUJ8tzXUm2hH_gZqMGE6w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Paul,

On Thu, Feb 2, 2012 at 3:47 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Thu, Feb 2, 2012 at 3:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> On Thu, 2 Feb 2012, Shilimkar, Santosh wrote:
>>
>>> Yes, we do have issue with below APIs for OMAP4 and onwards design
>>> because of the PRCM change.
>>>
>>> pwrdm_clear_all_prev_pwrst
>>> pwrdm_*_mem_*
>>>
>>> There use to be a single power state and memory state register till OMA=
P3
>>> at power domain level which can give you the logic and memory last test
>>> which is needed for OSWR.
>>>
>>> On OMAP4, we have registers per modules and it becomes difficult to mod=
el
>>> this difference in APIs. Initially we tried to fix that with [1] and
>>> then later realized
>>> that's not going to work on OMAP4 + devices because of mentioned issue.
>>
>> If the registers are per-module, it seems like the best place for those
>> would be the hwmod layer. =A0Do you think that makes sense? =A0So, somet=
hing
>> like omap_hwmod_clear_all_prev_pwrst(), etc.? =A0Seems like that should =
be
>> pretty efficient.
>>
> But all these are power domain registers after all. Rajendra did one vers=
ion of
> " pwrdm_clear_all_prev_pwrst" =A0API and inside used hwmod. But then ther=
e he
> has iterate over all the modules belongs to that power domain.
>
> And if you use hwmod or omap_device kind of API, then =A0you need to
> build those devices in init or some where.
>
> All of that was not looking so elegant and hence the other path was chose=
n.
> The mess is, the registers are still part of power domains though they
> are specific
> to module. And Fundamentally power domain is stil the central entity
> decides the fate of all the modules within that PD, in terms of context
> loss/ret etc.
>
I looked at the MPUSS file. There are 3 functions which access
power domain registers directly.

- mpuss_clear_prev_logic_pwrst
- cpu_clear_prev_logic_pwrst
- omap4_mpuss_read_prev_context_state

All of these functions access the context registers which
we don't have support today at power domian APIs for
mentioned issue. This file is using power domain APIs
in all possible scenario's except the OSWR scenario
which needs the context register accesses.

if the context clear and read can be handled part of
PD APIs, then we can certainly kill this functions.

Regards
santosh
