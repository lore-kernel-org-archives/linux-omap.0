From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: resource: Add per-resource mutex for OMAP resource  framework
Date: Wed, 10 Mar 2010 09:27:37 -0800
Message-ID: <87eijsgk8m.fsf@deeprootsystems.com>
References: <-1645286213079228429@unknownmsgid>
	<8bb80c381003091611l7211439ief40c5cf31e782a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8bb80c381003091611l7211439ief40c5cf31e782a0@mail.gmail.com> (Mike Chan's message of "Tue\, 9 Mar 2010 16\:11\:52 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: android-kernel@googlegroups.com, Chunqiu Wang <cqwang@motorola.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> On Tue, Mar 9, 2010 at 4:09 PM,  <y@google.com> wrote:
>> From: Chunqiu Wang <cqwang@motorola.com>
>>
>> Current OMAP resource fwk uses a global res_mutex
>> for resource_request and resource_release calls
>> for all the available resources.It may cause dead
>> lock if resource_request/resource_release is called
>> recursively.
>>
>> For current OMAP3 VDD1/VDD2 resource, the change_level
>> implementation is mach-omap2/resource34xx.c/set_opp(),
>> when using resource_release to remove vdd1 constraint,
>> this function may call resource_release again to release
>> Vdd2 constrait if target vdd1 level is less than OPP3.
>> in this scenario, the global res_mutex down operation
>> will be called again, this will cause the second
>> down operation hang there.
>>
>> To fix the problem, per-resource mutex is added
>> to avoid hangup when resource_request/resource_release
>> is called recursively.
>>
>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>> Signed-off-by: Mike Chan <mike@android.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/resource.h | =A0 =A02 ++
>> =A0arch/arm/plat-omap/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 21=
 ++++++++++-----------
>> =A02 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/resource.h b/arch/arm/p=
lat-omap/include/plat/resource.h
>> index 9acebcc..b5aff1f 100644
>> --- a/arch/arm/plat-omap/include/plat/resource.h
>> +++ b/arch/arm/plat-omap/include/plat/resource.h
>> @@ -54,6 +54,8 @@ struct shared_resource {
>> =A0 =A0 =A0 =A0/* Shared resource operations */
>> =A0 =A0 =A0 =A0struct shared_resource_ops *ops;

[...]

>
> Oops, my git client was slightly screwed up, apologies, I meant to
> send this from mike@android.com, the patch is still good though :)
>

=46YI... SRF is currently only in the PM branch of the OMAP tree, is
deprecated and is not targeted for mainline. =20

I'll merge this there, but please note that there is no new
development happening for SRF.

Thanks,

Kevin
