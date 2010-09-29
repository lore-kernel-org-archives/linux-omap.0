From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource
 structure
Date: Wed, 29 Sep 2010 09:02:07 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE166@dbde02.ent.ti.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com>
 <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8@mail.gmail.com>
 <alpine.DEB.2.00.1009281515590.5439@utopia.booyaka.com>
 <AANLkTi=UpeYtuQDuxEt2FNSajB-rtMpMZwseD=GUao2Y@mail.gmail.com>
 <alpine.DEB.2.00.1009281543290.5439@utopia.booyaka.com>
 <AANLkTi=77B2ntuJG7=J-g9GrcrJsWKUy6YbW0gm=MUQJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=77B2ntuJG7=J-g9GrcrJsWKUy6YbW0gm=MUQJ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

>-----Original Message-----
>From: vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org [mailto:vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On=20
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 29, 2010 3:18 AM
>To: Paul Walmsley
>Cc: Kalliguddi, Hema; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi, Felipe; Tony Lindgren; Kevin=20
>Hilman; Cousson, Benoit
>Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs=20
>in resource structure
>
>On Tue, Sep 28, 2010 at 17:44, Paul Walmsley wrote:
>> On Tue, 28 Sep 2010, Mike Frysinger wrote:
>>> On Tue, Sep 28, 2010 at 17:18, Paul Walmsley wrote:
>>> > On Tue, 28 Sep 2010, Mike Frysinger wrote:
>>> >> well, currently, your resource definition must always be=20
>in the order
>>> >> of dev int and then dma int. =A0if it isnt, then i dont=20
>think musb is
>>> >> going to work.
>>> >>
>>> >> not sure why you wouldnt simply change your platform resources t=
o
>>> >> match the what the driver expects ...
>>> >
>>> > The resource data is getting automatically populated from=20
>a set of data
>>> > generated from TI's hardware database for the OMAP=20
>platform, at least.
>>> > While we could hack in some exceptions to that tool to=20
>generate resources
>>> > in a specific order, it seems less fragile to use the=20
>resource name
>>> > instead. =A0That way, no matter what order the resources=20
>are generated, the
>>> > driver should still work.
>>>
>>> guessing you're not referring to a device tree setup, but something
>>> even more convoluted ?
>>
>> No need to disparage it before you've seen it :-)
>
>ah, but that's when i do my best work
>
>>> i'd highly suggest that this patch be resent with the info=20
>you've just
>>> provided in its changelog so people can get a better=20
>understanding of
>>> the "why" ... i'm not against the patch, it just seemed to=20
>be lacking
>>> any background info
>>
>> Hema, would you care to update the patch changelog accordingly?
>
>i'll pre-ack that for the Blackfin changes ... or, if you split those
>out, i can merge it separately for 2.6.37.

I will repost the patches today for blackfin and omap changes with the =
changelog
updated accordingly.

>-mike
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
