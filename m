From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: Modifying the kernel keymap
Date: Sun, 15 Nov 2009 14:42:52 -0800
Message-ID: <6cb013310911151442x2ecf9d2dnbfa6fbb7f6ca3b89@mail.gmail.com>
References: <6cb013310911151206s2496a6edxb3101d2d96c8dea0@mail.gmail.com>
	<1258324265.10351.1.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:51049 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZKOWuE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 17:50:04 -0500
Received: by pxi10 with SMTP id 10so747455pxi.33
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 14:50:10 -0800 (PST)
In-Reply-To: <1258324265.10351.1.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

On Sun, Nov 15, 2009 at 2:31 PM, Felipe Balbi <me@felipebalbi.com> wrot=
e:
> Hi,
>
> On Sun, 2009-11-15 at 12:06 -0800, Cory Maccarrone wrote:
>> All,
>>
>> I'm working with the Wing Linux and Linwizard projects in porting
>> various omap850-based devices to Linux, and was wondering about
>> keymaps.
>>
>> In particular, I'm working with the HTC Herald, which uses an Alt ke=
y
>> to access things like numbers and symbols on a physical keyboard. =C2=
=A0In
>> Linux, the keymappings are wrong for this -- Alt does something
>> different and doesn't allow access to those extra characters.
>>
>> In Linwizard, we've modified the defkeymap and added makefile rules =
to
>> compile our modified defkeymap when a specific board was selected, b=
ut
>> this isn't portable when building a kernel for many boards at once,
>> each having a different mapping.
>>
>> So, my question is, what is the best way to go about changing the
>> defkeymap, or supplying a keymap that allows all the keys to functio=
n
>> correctly, but doesn't require non-portable makefile hacks?
>
> how about letting xmodmap handle that ? If you use alt key, then kern=
el
> passes alt key. Userland can later remap that key to some other
> function.
>
> --
> balbi
>
>
>

=46or X-based interfaces that would work, and there's an equivalent for
Android too.  My question is more geared towards the console (i.e. no
X or Android, just plain linux console).

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
