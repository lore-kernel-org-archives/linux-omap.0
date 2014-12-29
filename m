From: Amit Virdi <amitvi128-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Mon, 29 Dec 2014 11:59:58 +0530
Message-ID: <CAEOkp45qZD-v5E1+NgJ5XOrAN2P4K8G6BE5R5gOgKh7h+1Ksaw@mail.gmail.com>
References: <cover.1418972323.git.amit.virdi@st.com>
	<1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
	<20141222160431.GC12815@saruman>
	<CAEOkp46psaZjeMc3qQmbnV8iqoXtbPJDrORABqhCt_f9tfOZeg@mail.gmail.com>
	<20141227174409.GA17608@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141227174409.GA17608@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand Thakur <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ajay.khandelwal-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 27, 2014 at 11:14 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Sat, Dec 27, 2014 at 12:39:23PM +0530, Amit Virdi wrote:
>> On Mon, Dec 22, 2014 at 9:34 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> > On Fri, Dec 19, 2014 at 12:40:15PM +0530, Amit Virdi wrote:
>> >> When scatter gather is used, multiple TRBs are prepared from one DWC3 request.
>> >> Hence, we must set the 'last' flag when the SG is last as well as the TRB is
>> >> last. The current implementation uses list_is_last to check if the dwc3_request
>> >> is the last request in the request_list.
>> >>
>> >> This doesn't work when SG is used. This is because, when it is the last request,
>> >> the first TRB preparation (in dwc3_prepare_one_trb) modifies the dwc3_request
>> >> list's next and prev pointers while moving the URB to req_queued.
>> >>
>> >> Hence, list_is_last always return false no matter what. The correct way is not
>> >> to access the modified pointers of dwc3_request but to use list_empty macro
>> >> instead.
>> >>
>> >> Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: fix scatter
>> >> gather implementation"
>> >>
>> >> Signed-off-by: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
>> >
>> > you need to Cc stable here and make sure you point out which kernel
>> > versions this should be backported to. Looks like this sould be:
>> >
>> > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.9+
>>
>> Okay. I checked the git log. The commit ("usb: dwc3: gadget: fix
>> scatter gather implementation") was introduced in v3.8-rc5, hence
>> v3.8, so I need to
>>
>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.8+
>
> hehe, many folks get confused by this. New features will never get
> merged upstream during the -rc cycle. -rc5 is when I applied it to my
> tree so it could be merged on the following merge window, which was
> v3.9.
>

Got it, thanks!

>> > Also, how have you tested this ? I need a test case to make sure it
>> > fails here and this patch really fixes the problem.
>> >
>>
>> This bug can be easily reproduced/tested if the gadget driver submits
>> a urb having number of sg entries mapped to DMA more than 1 on bulk
>
> which gadget driver does this ?
>

I discovered the bug fixed in this patch and the other [2/4], when I
was using our customized uvc webcam gadget.

>> endpoint. Following is the log snippet once this bug is reproduced:
>> ----
>> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
>> dwc3 dwc3.0: queing request 24cc5780 to ep2in-bulk length 960002
>> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 24eb6400 length 2 chain
>> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 25901800 length 960000
>> dwc3 dwc3.0: queing request 24cc5000 to ep2in-bulk length 960002
>> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
>> dwc3 dwc3.0: queing request 24cc5900 to ep2in-bulk length 960002
>> -----
>>
>> Without this fix, the hardware never generates "Transfer Complete"
>> event for the corresponding EP and goes into an unknown state.
>
> whiuch kernel are you using to develop this ? Most of these messages
> don't exist anymore with v3.19-rc because I have converted them into
> tracepoints, considering you're showing me logs with these messages,
> this tells me that you're sending me a patch developed/tested against a
> kernel older than v3.18. I need to see full bootup logs, a register dump
> (/sys/kernel/debug/*dwc3*/regdump) and a much larger debugging log from
> dwc3 in order to accept patches from you. Sorry, but I cannot take
> patches which were not tested against, at a minimum, the latest major
> release.
>
> It would be much better if you developed/tested against v3.19-rc1,
> considering we have 40 different patches which were merged since v3.18
> was tagged.
>

Your comments for this patch and the other are similar. So, I'm
quoting your comments from here to the other thread (of patch 2/4) and
replying there to avoid any duplicacy.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
