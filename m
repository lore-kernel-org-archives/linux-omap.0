From: Amit Virdi <amitvi128@gmail.com>
Subject: Re: [PATCH 1/4] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Sat, 27 Dec 2014 12:39:23 +0530
Message-ID: <CAEOkp46psaZjeMc3qQmbnV8iqoXtbPJDrORABqhCt_f9tfOZeg@mail.gmail.com>
References: <cover.1418972323.git.amit.virdi@st.com>
	<1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
	<20141222160431.GC12815@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:51102 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaL0HJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 02:09:24 -0500
In-Reply-To: <20141222160431.GC12815@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, pratyush.anand@gmail.com, ajay.khandelwal@st.com

On Mon, Dec 22, 2014 at 9:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 19, 2014 at 12:40:15PM +0530, Amit Virdi wrote:
>> When scatter gather is used, multiple TRBs are prepared from one DWC3 request.
>> Hence, we must set the 'last' flag when the SG is last as well as the TRB is
>> last. The current implementation uses list_is_last to check if the dwc3_request
>> is the last request in the request_list.
>>
>> This doesn't work when SG is used. This is because, when it is the last request,
>> the first TRB preparation (in dwc3_prepare_one_trb) modifies the dwc3_request
>> list's next and prev pointers while moving the URB to req_queued.
>>
>> Hence, list_is_last always return false no matter what. The correct way is not
>> to access the modified pointers of dwc3_request but to use list_empty macro
>> instead.
>>
>> Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: fix scatter
>> gather implementation"
>>
>> Signed-off-by: Amit Virdi <amit.virdi@st.com>
>
> you need to Cc stable here and make sure you point out which kernel
> versions this should be backported to. Looks like this sould be:
>
> Cc: <stable@vger.kernel.org> # v3.9+

Okay. I checked the git log. The commit ("usb: dwc3: gadget: fix
scatter gather implementation") was introduced in v3.8-rc5, hence
v3.8, so I need to

Cc: <stable@vger.kernel.org> # v3.8+

>
> Also, how have you tested this ? I need a test case to make sure it
> fails here and this patch really fixes the problem.
>

This bug can be easily reproduced/tested if the gadget driver submits
a urb having number of sg entries mapped to DMA more than 1 on bulk
endpoint. Following is the log snippet once this bug is reproduced:
----
dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
dwc3 dwc3.0: queing request 24cc5780 to ep2in-bulk length 960002
dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 24eb6400 length 2 chain
dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 25901800 length 960000
dwc3 dwc3.0: queing request 24cc5000 to ep2in-bulk length 960002
dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
dwc3 dwc3.0: queing request 24cc5900 to ep2in-bulk length 960002
-----

Without this fix, the hardware never generates "Transfer Complete"
event for the corresponding EP and goes into an unknown state.
