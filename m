From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin and msecure line
Date: Wed, 29 May 2013 09:13:54 -0700
Message-ID: <87li6x9325.fsf@linaro.org>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org>
	<20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna>
	<87obc0f54r.fsf@linaro.org>
	<CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com>
	<87a9nkf3mu.fsf@linaro.org> <51A5CCA5.7000700@ti.com>
	<87ehcpano0.fsf@linaro.org> <51A60F69.7050203@ti.com>
	<CAGa+x85ZzfX400eEGmTGPzRiC21S83VRiHYj38cqsJLjDF3L7g@mail.gmail.com>
	<51A6269E.2090001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50101 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190Ab3E2QN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 12:13:57 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so5971125pde.23
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 09:13:56 -0700 (PDT)
In-Reply-To: <51A6269E.2090001@ti.com> (Benoit Cousson's message of "Wed, 29
	May 2013 18:02:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 5/29/2013 5:29 PM, Kevin Hilman wrote:
>>
>> On May 29, 2013 8:06 AM, "Cousson, Benoit" <b-cousson@ti.com
>> <mailto:b-cousson@ti.com>> wrote:
>>  >
>>  > On 5/29/2013 4:03 PM, Kevin Hilman wrote:
>>  >>
>>  >> "Cousson, Benoit" <b-cousson@ti.com <mailto:b-cousson@ti.com>> writes:
>>  >>
>>  >> [...]
>>  >>
>>  >>>>
>>  >>>> Let me respin this after some more doc reading.
>>  >>>
>>  >>>
>>  >>> Did you re-spin it already?
>>  >>
>>  >>
>>  >> Yes, v2 is here.
>>  >>
>>  >> http://marc.info/?l=linux-omap&m=136944147521955&w=2
>>  >>
>>  >> It also needed a rework because the fref_clk0_out pin is also in the
>>  >> wkup section of the padconf, not core.
>>  >
>>  >
>>  > OK, I'll wait for the v3 then :-)
>>  >
>>
>> Hmm, why? v2 has the wkup changes included.
>
> Why? Because of my bad understanding of English :-)
> I understood: It also needs a rework...

Re-reading, I wasn't terribly clear.  Sorry for the confusion.

> Sorry, I'll merge it.

I was hoping for an Ack from Nishanth since he had some questions about
it, but with the double checking from you and Grygorii, I think it
should go in for the -rc cycle.  (also, please add an Ack from Grygorii.)

Thanks,

Kevin
