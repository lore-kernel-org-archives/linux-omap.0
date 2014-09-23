From: Frans Klaver <fransklaver-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Tue, 23 Sep 2014 20:11:32 +0200
Message-ID: <88924386-79bc-44c7-9a07-249900cbd359@email.android.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com> <1410789610-23059-4-git-send-email-frans.klaver@xsens.com> <54170823.7040801@hurleysoftware.com> <5417228C.5070503@hurleysoftware.com> <20140916085037.GI28458@ci00147.xsens-tech.local> <54197804.3020302@hurleysoftware.com> <20140917121303.GB20438@ci00147.xsens-tech.local> <20140923082445.GA16218@ci00147.xsens-tech.local> <5421AB20.8040606@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5421AB20.8040606-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alexey Pelykh <alexey.pelykh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 23 September 2014 19:17:20 CEST, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>On 09/23/2014 04:24 AM, Frans Klaver wrote:
>> On Wed, Sep 17, 2014 at 02:13:03PM +0200, Frans Klaver wrote:
>>> On Wed, Sep 17, 2014 at 08:01:08AM -0400, Peter Hurley wrote:
>>>> On 09/16/2014 04:50 AM, Frans Klaver wrote:
>>>>> On Mon, Sep 15, 2014 at 01:31:56PM -0400, Peter Hurley wrote:
>>>>>> On 09/15/2014 11:39 AM, Peter Hurley wrote:
>>>>>>> On 09/15/2014 10:00 AM, Frans Klaver wrote:
>>>>>>>> At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see
>1600 uart
>>>>>>>> rx buffer overflows within 30 seconds. Threading the interrupt
>handling reduces
>>>>>>>> this to about 170 overflows in 10 minutes.
>>>>>>>
>>>>>>> Why is the threadirqs kernel boot option not sufficient?
>>>>>>> Or conversely, shouldn't this be selectable?
>>>>>>
>>>>>
>>>>> I wasn't aware of the threadirqs boot option. I also wouldn't know
>if
>>>>> this should be selectable. What would be a reason to favor the
>>>>> non-threaded irq over the threaded irq?
>>>>
>>>> Not everyone cares enough about serial to dedicate kthreads to it
>:)
>>>
>>> Fair enough. In that light, we might not care enough about other
>>> subsystems to dedicate kthreads to it :). Selectable seems
>reasonable in
>>> that case.
>>>
>>>
>>>>>> Also, do you see the same performance differential when you
>implement this
>>>>>> in the 8250 driver (that is, on top of Sebastian's omap->8250
>conversion)?
>>>>>>
>>>>>
>>>>> I haven't gotten Sebastian's driver to work properly yet on the
>console.
>>>>> There was no reason for me yet to throw my omap changes on top of
>>>>> Sebastian's queue.
>> 
>> Doing the threaded interrupt change on the 8250 driver doesn't seem
>as
>> trivial. Unless I'm mistaken, that version of this patch would mess
>with
>> all other 8250 based serial drivers, if it's done properly.
>Incidentally
>> I did try using threadirqs, but that didn't give my any significant
>> results. I mostly noticed a difference in the console.
>> 
>> 
>>>>>
>>>>>>> PS - To overflow the 64 byte RX FIFO at those data rates means
>interrupt
>>>>>>> latency in excess of 250us?
>>>>>
>>>>> At 3686400 baud it should take about 174 us to fill a 64 byte
>buffer. I
>>>>> haven't done any measurements on the interrupt latency though. If
>you
>>>>> consider that we're sending about 1kB of data, 240 times a second,
>we're
>>>>> spending a lot of time reading data from the uart. I can imagine
>the
>>>>> system has other work to do as well.
>>>>
>>>> System work should not keep irqs from being serviced. Even 174us is
>a long
>>>> time not to service an interrupt. Maybe console writes are keeping
>the isr
>>>> from running?
>>>
>>> That's quite possible. I'll have to redo the test setup I had for
>this to
>>> give you a decent answer. I'll have to do that anyway as Sebastian's
>>> 8250 conversion improves.
>> 
>> I haven't had time yet to look into this any further. I'll accept
>that
>> this patch may fix a case most people aren't the least interested in.
>> I'll also happily accept that I probably need a better argumentation
>> than "this works better for us".Would it make sense to drop this
>patch
>> and resubmit the other three? As I mentioned in the previous run, I
>> think these are useful in any case.
>
>I would've thought the first 2 patches had already been picked up
>because
>they fix div-by-zero faults.

I've had no confirmation of that happening so far. I also don't know if I should expect one. Who'd take these patches? Tony? 


>I don't really have a problem with the patch (except for it should be
>selectable, even if that's just a CONFIG_ setting). At the same time,
>the performance results don't really make sense; so if there's actually
>an underlying problem, I'd rather that get addressed (and the long
>interrupt latency may be the underlying problem).

Your questions got me thinking a bit more. I concluded that it's hard to define why this difference in performance is so big. I only got to it by just trying and seeing what would happen. 


>As far as the 8250 driver and threaded irqs go, I just was hoping for
>another data point with a simple hard-coded test jig, not a full-blown
>patch series for all of them. Sorry for the misunderstanding.

Ah yes. I'll see what I can do about it. It does make sense to get that data point somehow. 

Thanks, 
Frans 

>
>Regards,
>Peter Hurley
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
