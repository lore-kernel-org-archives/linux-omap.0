From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 18:43:49 +0200
Message-ID: <549D9045.402@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com> <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman> <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman> <20141224190401.GN23854@atomide.com> <549BE333.9060709@compulab.co.il> <20141226044246.GB7661@saruman> <549D4CEA.6090009@compulab.co.il> <20141226150900.GC17430@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:43978 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbaLZQoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 11:44:03 -0500
In-Reply-To: <20141226150900.GC17430@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/26/14 17:09, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Dec 26, 2014 at 01:56:26PM +0200, Igor Grinberg wrote:
>>>>>> Tony, your call.
>>>>>
>>>>> I think we should move omap2plus_defconfig to be mostly modular and
>>>>> usable for distros as a base. Most distros prefer to build almost
>>>>> everything as loadable modules. And my preference is that we should
>>>>> only keep the minimum rootfs for devices and serial support as
>>>>> built-in and rely on initramfs for most drivers. And slowly move
>>>>> also the remaining built-in drivers to be loadable modules.
>>>>>
>>>>> The reasons for having drivers as loadable modules are many. It
>>>>> allows distros to use the same kernel for all the devices without
>>>>> bloating the kernel. It makes developing drivers easier as just the
>>>>> module needs to be reloaded. And loadable modules protect us from
>>>>> cross-framework spaghetti calls in the kernel as the interfaces are 
>>>>> clearly defined.
>>>>>
>>>>> Are there people really using SATA as rootfs right now on omaps?
>>>>
>>>> Yes. That is exactly my point.
>>>
>>> read your email, you said it *CAN* have rootfs on SATA.
>>
>> yep, it also *CAN* have rootfs on MMC and NFS and ...
> 
> those we *know* people are using as rootfs. We know of several users who
> are actually using it :-)

I think we've had enough of the *can* or *cannot* stuff...
So, just accept that people are using SATA as rootfs and will be using
it in the future products too.

> 
>>>>> If it's only something that will be more widely used in the future,
>>>>> then I suggest we make it into a loadable module, and presume
>>>>> initramfs and loadable module also for any new devices. The same
>>>>> way x86 has been doing with distros for years.
>>>>
>>>> The difference from x86 is that we're in embedded here and
>>>
>>> bullshit, you would never ship a product with omap2plus_defconfig. You'd
>>> build your own at which point you would switch SATA to built-in.
>>
>> Yep, that is one of the options indeed, but I'm not asking you to
>> deal with my problems, right?
>> I'm feeling like you are trying to insult me.
>> Are you angry with me? Why?
>> Is it because I have a different opinion?
> 
> heh, cute :-)

so this is what it takes to calm you down? good!

> 
>>>> although initramfs is a kind of option, but it means, you need to
>>>> load even more data during the boot process... it is annoying and
>>>> I would not want to use it on embedded.
>>>
>>> make your own defconfig.
>>
>> This sounds like: mind your own business...
>> Is that what you want to say?
> 
> nope, not really.

good!

> Just saying that if you're really concerned about
> being embedded and that initramfs takes that much more time to load,
> you'd just make your own defconfig and maintain it out-of-tree.
> 
> RMK does that for quite a few boards, I do it for my boards and also for
> my x86 desktops/laptops.
> 
> It's not really rocket science.

Yes indeed. We do this *all* the time.
To understand what is this about, first you need to make yourself
familiar with the case.

> 
>>>> (BTW, x86_64_defconfig has it compiled in...)
>>>>
>>>> We can also, split the defconfig as it was some time ago... but I
>>>> would not want to go that direction...
>>>>
>>>> If we go the initramfs way, then why not also load MMC from it?
>>>> That will also reduce kernel size... (but add initramfs size)
>>>
>>> I'm fine with that. The difference is that people have been relying on
>>> MMC built-in for the past 10+ years, since the old OMAP1 MMC driver,
>>> changing that now is likely to cause some "my board won't boot anymore"
>>> bug reports.
>>
>> Yep. So there are exceptions, right?
> 
> never claimed the contrary.

So, those exactly kind of bug reports I'm expecting to get, once you
compile out SATA...

> 
>>>> I'm sure you will find making the MMC a loadable module inconvenient.
>>>> That how I find making the SATA a loadable module...
>>>>
>>>> Right now, we tell our customers that they can use mainline with
>>>> omap2plus_defconfig.
>>>
>>> that's the worst thing you can do.
>>
>> Hmmm... Interesting, so people should not use mainline.
> 
> now you're reading what you want to read ;-) Using my statements out of
> context.

I'm sorry, but you seemed to not care about the context, but just call
stuff a BS or worst thing to do... and that is w/o even understanding
the case.

> 
> It's clear (actually s/rootfs/defconfig below) that I meant defconfig.
> 

Well, no, I'm sorry it is not clear, but I accept the amendment.

>>> You should at a minimum provide your
>>> customers with a more minimal rootfs. Why would you have your customers
> 
> oh wait, not rootfs, defconfig.
> 
>>> build MUSB on an OMAP5 board ? Why would they build 5 different
>>> network device drivers ? Why would they build almost every single PMIC
>>> we ever used ? The list goes on and on.
>>
>> That is their decision to make. I'm just saying that they can use it.
> 
> right, and they can switch SATA to built-in if they want to ship an
> initramfs-less product, don't you think ?

no. It *very* depends on who your customer is and sometimes compiling
kernel with provided defaults is fine, but changing those is not.
You can say, "come on... if they build the kernel, they can also change
the configuration..."
That's what I thought several years ago, but it proved to be wrong...

Now, after all the out-of-tree defconfig proposals, why do you care
about the omap2plus_defconfig providing a smaller (by <200K according
to Grygorii) kernel?

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUnZBFAAoJEBDE8YO64Efa/RUP/2I4eB9BWP1ysxP/AiyZ8/mb
9ETGguxpGU5JJ65RE0umT3n6H+6g6fQ0Rq67ojeCWYg76jMhLKDpshhVSLO9JKW1
VWh6b6OLHdP46fsdDsNS6ug6FBoEka/30PckBGze913pN1rQwyb4GsRqY7itld/x
2fWcKfoMuwDuXK6c0Cq4trYfYbRr+36X1quPO1KdT1F7TTBLx+WqucxtU7lNyAvi
NVxNs5BU/PGT6j8Dd+qb0uT5C7XGSIQ6mAEeO30aXlysa0oYj8te3cCiU6BWcav7
y8MHyKSHsPdiaD5sFsGzLtF17tXnWC67znI7ajuGncA8wumHLpTPuhl43/YnBH04
NSOiEG2ly5PoqMfV1Ml/hI4blDteABOVYJhysN8bs1SQyaTc/VIh6uiSshRYQNCT
9jaO6utulxF6PM/2tnB9JR9ci19J1Y+VohB1rtmbG/jvpS2QHnQthD2esoVXN0aq
+p0/zlsu7osfXcXpdtcuOmZKUntlT9Bfh7A1ppd7fE0AfZmMu5b7KcXAYbeCsCH0
q3nzN/loAuGjjx/BRbWt44O0VY/9yQVUtm/KKGbglf6piuI0EdlWY9kM5chPMt0h
GAKUvSDgNZoZEECzb4ANZAJup1e+KTN3AaLBM03TgBxDdATJZuuwGydmQKcJliva
ME6omZmsXXph8Le1srIh
=GvGH
-----END PGP SIGNATURE-----
