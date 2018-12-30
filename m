From: Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 16:06:24 -0600
Message-ID: <5950f965-effa-25ca-3533-de1b95923aa5@gmail.com>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com> <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
 <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
 <20181230212253.GG6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181230212253.GG6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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

>> How are you handling data connections?  PPP? Or is there some other protocol
>> to transfer packets back and forth?
> 
> All the data connections in this case are done using QMI over USB.
> 
> And that probably explains why I have not seen any data related
> stuff on ts 27.010.

Ew.  So is everything related to packet services is running over QMI?

When Pavel explained that he wanted to use the weird squiggly AT 
commands, I assumed you wanted to run the packet services over AT as well.

> 
>>>> - GNSS/GPS is intended to be handled via oFono LocationReporting API.  I
>>>> would recommend integrating this as intended...
>>>
>>> We have a standard kernel GNSS API now :) And we have /dev/gnss0
>>> already working for droid 4.
>>
>> That's great.  But I think my recommendation still stands.  You want GPS
>> state to be synchronized with the overall modem state, etc...
> 
> Hmm sounds like ofono would benefit from using /dev/gnss0 in the
> long run though. I guess the situation is similar to having
> multiple computer mouse drivers earlier with their own interfaces
> vs standard /dev/input :)

Yep, agreed.  I already tried to nudge Pavel to propose something.

> 
>> I believe the utilities you mention should be good enough to decode the
>> basics.  I think someone has even tested these on a real network at some
>> point.  But the people working on CDMA have not contributed since ~2011, so
>> I have no idea about the state of that code.  I was considering removing it
>> given that CDMA is essentially defunct (or will be in a few years).
> 
> OK, sounds like we might need the CDMA PDU features for few more
> years though.

That's fine, as long as someone is actually using these.  Right now it 
is unmaintained code.

> 
> Oh, I think I forgot to answer your question regarding PM,
> there's nothing that the user space needs to except to avoid
> polling the /dev/motmdm* devices unnecessarily. And to type
> AT+SCRN=0 on /dev/motmdm1 when no notifications for signal
> strength and network status are needed.
> 

Right, but since /dev/motmdm1 would in theory belong exclusively to 
oFono, you probably still need some way of sending the screen 'off' 
command.  So in effect you're integrating power management with the 
telephony stack.

Regards,
-Denis
