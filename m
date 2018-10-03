From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Wed, 3 Oct 2018 07:00:46 -0500
Message-ID: <6f96a5bd-27df-7906-73bf-67bdf848308a@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
 <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com> <20181002220754.GA20413@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002220754.GA20413@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hello

On 10/02/2018 05:07 PM, Pavel Machek wrote:
> Hi!
> 
>>> We have debated this over and over and now we have 3 different implementations
>>> available we need to collude on which one we want to support.
>>>
>>> Jacek I defer to you and Pavel since you are both LED maintainers.
>>>
>>> I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.
>>
>> I uphold my previous opinion - please go ahead with moving the support
>> for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
>> along with the bindings. This is semantically correct, and yet we don't
>> have mainline users.
>>
>> Pavel - you will have to engage more people for your crusade to prevail.
>> For now, to speed up the things, I am forced to ignore your NAK.
>> So NAK to your NAK. Sorry.
> 
> No need to be sorry :-).
> 
> Lets ignore the code for now, as code can be changed easily.
> 
> Bindings are not something you or I maintain, so we don't have final
> word there, and I have feeling this is not going to go past device
> tree maintainers. [AFAICT: you can move binding in Documentation/ to
> different place, that's not a problem; but creating a new binding when
> old one exists is.]
> 
> If you and Dan feel that is okay, you are welcome to try to get the
> patches past Rob, just please retain the NAK so that he remembers the
> discussion, and so that it is clear that I don't like the changes.
> 
> I believe smart thing to do is to try to do that before working
> further on the code, but of course, its all up to you :-).

I was looking for the review for the ti-lmu.txt binding on patchworks to see what
the comments were on the review or any explanation from reviewers to
why this implementation was done in the MFD.

Maybe there is some historical context that needs to be learned from here from
1.5 years ago.

I cannot seem to find any review posted in the patchworks archive.
I see reviews posted for the ti-lmu-backlight binding but none from
the ti-lmu.txt base binding.

Does anyone have a reference to the review?

If there is no review then I am wondering how this binding was accepted.
If there is no review and no current users then I would think that binding
 modification should be allowed.  But thats just my opinion.

Dan


> 
> Friends,
> 									Pavel
> 


-- 
------------------
Dan Murphy
