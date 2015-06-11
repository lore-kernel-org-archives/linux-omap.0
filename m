From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [RFC PATCH] usb: dwc3: ep0: Fix mem corruption on OUT transfers
 of more than 512 bytes
Date: Thu, 11 Jun 2015 19:57:05 +0100
Message-ID: <CAOf5uwn3ZOPjGBkrrsBg=YKgeb8kxNmY0OjVG0mozUKF976E0A@mail.gmail.com>
References: <1433860550-25636-1-git-send-email-kishon@ti.com>
	<CAOf5uwmVRaHbiHaRsiwKjCbxg5BxjyP8WPq9whrtK-UdSsL47w@mail.gmail.com>
	<5576FBBA.4000905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5576FBBA.4000905-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, Jun 9, 2015 at 3:44 PM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Tuesday 09 June 2015 08:09 PM, Michael Trimarchi wrote:
>>
>> Hi
>>
>> On Jun 9, 2015 4:36 PM, "Kishon Vijay Abraham I" <kishon-l0cyMroinI0@public.gmane.org
>> <mailto:kishon-l0cyMroinI0@public.gmane.org>> wrote:
>>  >
>>  > DWC3 uses bounce buffer to handle non max packet aligned OUT transfers
>> and
>>  > the size of bounce buffer is 512 bytes. However if the host initiates
>> OUT
>>  > transfers of size more than 512 bytes (and non max packet aligned), the
>>  > driver throws a WARN dump but still programs the TRB to receive more
>> than
>>  > 512 bytes. This will cause bounce buffer to overflow and corrupt the
>>  > adjacent memory locations which can be fatal.
>>  >
>>  > Fix it by programming the TRB to receive a maximum of
>> DWC3_EP0_BOUNCE_SIZE
>>  > (512) bytes.
>>  >
>>  > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org
>> <mailto:kishon-l0cyMroinI0@public.gmane.org>>
>>
>>  > ---
>>  > Steps to see the issue (before this patch)
>>  > 1) Insert g_zero in DUT
>>  > 2) run './testusb -t 14 -c 1 -s 520 -v 1' in host (size should be >
>> 512)
>>  >
>>  > The test should FAIL since bounce buffer can handle only 512 bytes, but
>> the
>>  > test PASS. There is a WARN dump in DUT but still there will be memory
>>  > corruption since the bounce buffer overflows.
>>  >
>>  > Tested this patch using USB3 Gen X CV (ch9 tests: usb2 and usb3, link
>> layer
>>  > testing and MSC tests) and using USB2 X CV (ch9 tests, MSC tests).
>>  >
>>  > After the patch, the tests timeout!
>>  > ./testusb -t 14 -c 1 -s 514 -v 1
>>  > unknown speed   /dev/bus/usb/001/018    0
>>  > /dev/bus/usb/001/018 test 14 --> 110 (Connection timed out)
>>  >
>>  > IMO a patch to fix this is required for stable releases too. So If this
>>  > patch is alright, I can post the patch cc'ing stable. While the actual
>> fix
>>  > would be to have chained TRB, I'm not sure if it can go to stable
>>  > releases.
>>  >  drivers/usb/dwc3/ep0.c |   12 ++++++++++--
>>  >  1 file changed, 10 insertions(+), 2 deletions(-)
>>  >
>>  > diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>  > index 2ef3c8d..8858c60 100644
>>  > --- a/drivers/usb/dwc3/ep0.c
>>  > +++ b/drivers/usb/dwc3/ep0.c
>>  > @@ -816,6 +816,11 @@ static void dwc3_ep0_complete_data(struct dwc3
>> *dwc,
>>  >                 unsigned maxp = ep0->endpoint.maxpacket;
>>  >
>>  >                 transfer_size += (maxp - (transfer_size % maxp));
>>  > +
>>  > +               /* Maximum of DWC3_EP0_BOUNCE_SIZE can only be received
>> */
>>  > +               if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
>>  > +                       transfer_size = DWC3_EP0_BOUNCE_SIZE;
>>  > +
>>
>> Can you just use maxp in the correct way?
>
>
> what do you mean by correct way? Using roundup() to calculate transfer_size?
>

just a max

Michael

> Thanks
> Kishon



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
