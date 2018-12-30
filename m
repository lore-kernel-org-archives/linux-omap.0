From: Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 14:46:50 -0600
Message-ID: <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com> <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181230202454.GF6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ofono.org/mailman/options/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono/>
List-Post: <mailto:ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ofono.org/mailman/listinfo/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Sender: "ofono" <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 12/30/2018 02:24 PM, Tony Lindgren wrote:
> * Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [181230 19:32]:
>> You still need someone to send AT+CMUX, no?  And you most likely need to
>> integrate power management into the telephony stack anyway.  As I mentioned,
>> we had a driver like this that worked just fine.  oFono ended up using a
>> user space MUX since most of the quality of life improvements to n_gsm came
>> in much later.  If I was writing a new MUXed driver these days, I'd
>> seriously consider using GSMIOC_SETCONF and GSMIOC_ENABLE_NET.
> 
> No need to type AT+CMUX or anything, things start in ts 27.010
> mode from the start for the hardware. Then the serdev driver
> layer handles doing GSMIOC_SETCONF.

Gotcha.  That makes things a bit easier.

> 
> I have not played with GSMIOC_ENABLE_NET, I thought that needed
> support on the modem side as well, but maybe not?
>

It requires the modem to support Raw IP.  Many (most?) AT command based 
modems do these days, no idea about your hardware.

> Would GSMIOC_ENABLE_NET make things easier from ofono
> point of view?

Depends on your definition of easier.  The real reason for 
GSMIOC_ENABLE_NET is speed/efficiency.  In a typical 27.010 / 27.007 
compliant modem you'd setup N logical AT command channels where N = 1 
(minimum, but can be more if you want) + max number of active contexts. 
Typically modems support 3+ of these.  Once a context is activated, 
you'd switch the channel into data mode via AT+CGDATA (e.g. for PPP or 
raw IP) and start shoving your network packets on that channel in the 
format chosen.

How are you handling data connections?  PPP? Or is there some other 
protocol to transfer packets back and forth?

>> - GNSS/GPS is intended to be handled via oFono LocationReporting API.  I
>> would recommend integrating this as intended...
> 
> We have a standard kernel GNSS API now :) And we have /dev/gnss0
> already working for droid 4.

That's great.  But I think my recommendation still stands.  You want GPS 
state to be synchronized with the overall modem state, etc...

> 
>> There's no real functional CDMA support in oFono anyhow.  Given that most
>> CDMA networks are about to be switched off, I don't know why you would
>> bother?
> 
> Hmm right, good point. Anyways that's how the SMS gets sent and
> received in the US for droid 4 currently.. The file I was looking at
> is src/cdma-sms.c and the only thing to do there is the PDU coding
> and encoding.

I believe the utilities you mention should be good enough to decode the 
basics.  I think someone has even tested these on a real network at some 
point.  But the people working on CDMA have not contributed since ~2011, 
so I have no idea about the state of that code.  I was considering 
removing it given that CDMA is essentially defunct (or will be in a few 
years).

Regards,
-Denis
