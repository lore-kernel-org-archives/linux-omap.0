From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Tue, 1 Oct 2013 15:54:20 -0500
Message-ID: <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
	<524A8289.3050107@baylibre.com>
	<524ACB76.1010001@gmail.com>
	<524AE4FB.4080906@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524AE4FB.4080906-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 1, 2013 at 10:06 AM, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Hi Rob,
>
>
> On 01/10/2013 15:17, Rob Herring wrote:
>>
>> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
>>>
>>> + more DT maintainers folks
>>>
>>> Hi all,
>>>
>>> I know this is mostly boring user space code, but I was expecting a
>>> little bit of comments about at least the bindings syntax:-(
>>>
>>> I'd like to know if this is the right direction and if it worth pursuing
>>> in that direction.
>>>
>>> The idea was to have at least some base for further discussion during
>>> ARM KS 2013.
>>>
>>> I feel alone :-(
>>>
>>> If you have any comment, go ahead!
>>
>>
>> Thanks for taking this on!
>>
>> This is interesting approach using the dts syntax,
>
>
> Well, this was discussed a little bit on the list, and it has the big
> advantage of re-using the parser already included in DTC for free.
> In term or readability, it avoids to re-defining a brand new syntax for
> people who are already familiar with the DTS one.
>
>
>> but I worry that the
>> validation will only be as good as the schema written and the review of
>> the schema.
>
>
> Well, sure, but unfortunately, that will always be the case :-(
> The bindings definition being quite open, there is no easy way to ensure
> proper schema / bindings without careful review of the schema. There is no
> such thing as a free beer... Unfortunately :-)
>
>
>> I think the schema needs to define the binding rather than
>> define the checks. Then the schema can feed the validation checks.
>
>
>> This format does not seem to me as easily being able to generate
>> documentation from the schema which I believe is one of the goals.
>
>
> Indeed, but I think is it easy to generate any kind of readable format for
> the documentation purpose if needed from the actual format.
> Otherwise, we should consider a schema format based on kerneldoc type of
> syntax to improve readability. I'm just afraid it will become harder then to
> define complex schema.
>
> BTW, what kind of documentation are you expecting here? Is is a text that
> can be added on top of each schema?

I would expect the schema to replace
Documentation/devicetree/bindings/* over time. I think the thing that
needs to be worked out here is how to add free form multi-line text.

>> I for
>> one don't care to review the documentation and the schema for every
>> binding.
>>
>> I would like to ensure we can start with the basics and have some
>> generic rules. Some examples:
>>
>> - flag compatible strings in dts files that are not documented
>
>
> This is almost done with the last patch of the series. Nodes are already
> checked, properties are missing.
>
>> - check required properties
>
>
> Done as well.
>
>
>> - check properties against cell sizes
>
>
> Yeah, that one is still to be done.
>
>
>> - a node with reg property must have a unit address
>
>
> Easy to add.
>
>
>> - flag properties with "_"
>
>
> Easy to add as well.
>
>
>> - check properties are the correct data type
>
>
> Already done for a couple of data type.

Good to know. It wasn't really clear what common items are checked. An
example schema for clocks or gpio (or any other common) binding would
be nice.

Do you have a run with all the warnings found?

> Thanks for your comments. Being the very first one, you might get a free
> beer... meaning there might be such thing as a free beer :-)

In that case, it all looks perfect. :)

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
