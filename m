From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 16:34:27 +0530
Message-ID: <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com>
References: <1333094862.1932.15.camel@deskari> <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
 <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>
 <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>
 <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37544 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759426Ab2C3LEt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 07:04:49 -0400
Received: by qabg27 with SMTP id g27so340400qab.2
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 04:04:48 -0700 (PDT)
In-Reply-To: <4F75915D.9050205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Fri, Mar 30, 2012 at 4:26 PM, Archit Taneja <a0393947@ti.com> wrote:
> On Friday 30 March 2012 03:59 PM, Santosh Shilimkar wrote:
>>
>> On Friday 30 March 2012 03:53 PM, Cousson, Benoit wrote:
>>>
>>> On 3/30/2012 10:44 AM, Santosh Shilimkar wrote:
>>>>
>>>> On Friday 30 March 2012 02:04 PM, Archit Taneja wrote:
>>>>>
>>>>> On Friday 30 March 2012 02:01 PM, Santosh Shilimkar wrote:
>>>>>>
>>>>>> + Kevin
>>>>>>
>>>>>> On Friday 30 March 2012 01:56 PM, Tomi Valkeinen wrote:
>>>>>>>
>>>>>>> On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
>>>>>>>>
>>>>>>>> On Fri, Mar 30, 2012 at 1:37 PM, Tomi
>>>>>>>> Valkeinen<tomi.valkeinen@ti.com> =A0 =A0wrote:
>>>>>>>
>
[...]

>
> I had a general PRCM question regarding this. If an initiator is disa=
bled
> (i.e, clocks are OFF and Power state is OFF), then would the PRCM eve=
n care
> to look at the IdleAck/Mstandby signal of that initiator? Or in other=
 words,
> look at what the initiator had programmed in it's SYSCONFIG register.=
 If it
> does consider them, it seems like that's bad HW design!
>
If a PD 9powerdomain) is already in OFF state, that means all the initi=
ators in
that PD already has standby asserted. The modules in that
PD also have transitioned.

So PRCM won't poke that PD initiators/modules because it has
already have a green signal for power transitions. At least that is
what my understanding from the OMAP PRCM specs.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
