From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ
 pin and msecure line
Date: Wed, 29 May 2013 18:48:12 +0200
Message-ID: <51A6314C.1080803@ti.com>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org> <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna> <87obc0f54r.fsf@linaro.org> <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com> <87a9nkf3mu.fsf@linaro.org> <51A5CCA5.7000700@ti.com> <87ehcpano0.fsf@linaro.org> <51A60F69.7050203@ti.com> <CAGa+x85ZzfX400eEGmTGPzRiC21S83VRiHYj38cqsJLjDF3L7g@mail.gmail.com> <51A6269E.2090001@ti.com> <87li6x9325.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827Ab3E2Qsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 12:48:42 -0400
In-Reply-To: <87li6x9325.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

On 05/29/2013 06:13 PM, Kevin Hilman wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
> 
>> On 5/29/2013 5:29 PM, Kevin Hilman wrote:
>>>
>>> On May 29, 2013 8:06 AM, "Cousson, Benoit" <b-cousson@ti.com
>>> <mailto:b-cousson@ti.com>> wrote:
>>>  >
>>>  > On 5/29/2013 4:03 PM, Kevin Hilman wrote:
>>>  >>
>>>  >> "Cousson, Benoit" <b-cousson@ti.com <mailto:b-cousson@ti.com>> writes:
>>>  >>
>>>  >> [...]
>>>  >>
>>>  >>>>
>>>  >>>> Let me respin this after some more doc reading.
>>>  >>>
>>>  >>>
>>>  >>> Did you re-spin it already?
>>>  >>
>>>  >>
>>>  >> Yes, v2 is here.
>>>  >>
>>>  >> http://marc.info/?l=linux-omap&m=136944147521955&w=2
>>>  >>
>>>  >> It also needed a rework because the fref_clk0_out pin is also in the
>>>  >> wkup section of the padconf, not core.
>>>  >
>>>  >
>>>  > OK, I'll wait for the v3 then :-)
>>>  >
>>>
>>> Hmm, why? v2 has the wkup changes included.
>>
>> Why? Because of my bad understanding of English :-)
>> I understood: It also needs a rework...
> 
> Re-reading, I wasn't terribly clear.  Sorry for the confusion.
> 
>> Sorry, I'll merge it.
> 
> I was hoping for an Ack from Nishanth since he had some questions about
> it, but with the double checking from you and Grygorii, I think it
> should go in for the -rc cycle.  (also, please add an Ack from Grygorii.)

OK, I'll push the fix to Tony ASAP.

Thanks,
Benoit

