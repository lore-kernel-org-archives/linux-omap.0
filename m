From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 16:50:35 +0530
Message-ID: <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com>
References: <1333094862.1932.15.camel@deskari> <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
 <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>
 <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>
 <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com> <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com>
 <4F75963C.2000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:56921 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933839Ab2C3LU7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 07:20:59 -0400
Received: by qcmt36 with SMTP id t36so291472qcm.29
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 04:20:57 -0700 (PDT)
In-Reply-To: <4F75963C.2000508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Fri, Mar 30, 2012 at 4:47 PM, Archit Taneja <a0393947@ti.com> wrote:
> On Friday 30 March 2012 04:34 PM, Shilimkar, Santosh wrote:
>>
>> On Fri, Mar 30, 2012 at 4:26 PM, Archit Taneja<a0393947@ti.com> =A0w=
rote:
>>>
>>> On Friday 30 March 2012 03:59 PM, Santosh Shilimkar wrote:
>>>>
>>>>
>>>> On Friday 30 March 2012 03:53 PM, Cousson, Benoit wrote:
>>>>>
>>>>>
>>>>> On 3/30/2012 10:44 AM, Santosh Shilimkar wrote:
>>>>>>
>>>>>>
>>>>>> On Friday 30 March 2012 02:04 PM, Archit Taneja wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Friday 30 March 2012 02:01 PM, Santosh Shilimkar wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> + Kevin
>>>>>>>>
>>>>>>>> On Friday 30 March 2012 01:56 PM, Tomi Valkeinen wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Fri, Mar 30, 2012 at 1:37 PM, Tomi
>>>>>>>>>> Valkeinen<tomi.valkeinen@ti.com> =A0 =A0 =A0wrote:
>>>>>>>>>
>>>>>>>>>
>>>
>> [...]
>>
>>>
>>> I had a general PRCM question regarding this. If an initiator is di=
sabled
>>> (i.e, clocks are OFF and Power state is OFF), then would the PRCM e=
ven
>>> care
>>> to look at the IdleAck/Mstandby signal of that initiator? Or in oth=
er
>>> words,
>>> look at what the initiator had programmed in it's SYSCONFIG registe=
r. If
>>> it
>>> does consider them, it seems like that's bad HW design!
>>>
>> If a PD 9powerdomain) is already in OFF state, that means all the
>> initiators in
>> that PD already has standby asserted. The modules in that
>> PD also have transitioned.
>
>
> Ah, so if DSS was configured as Nostandby, and if we try to disable D=
SS, it
> would never transition to OFF, and hence never get disabled correctly=
, hence
> giving trouble to PRCM.
>
> So just before disabling DSS, we would need to put it to Force standb=
y, and
> then try to cut the clocks and change the power state. Is this correc=
t? If
> so, then it's equally messy as the suggested workaround :)
>
Exactly. That's what I mean. You tweak sysconfig or clockdomain,
both are messy.

if one need to choose between two bad options, I guess sysconifig
one is better because that is local to IPs and there is some way today
for drivers to manage sysconfig directly.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
