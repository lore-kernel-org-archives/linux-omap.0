From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: mmc0 detection timing at kernel startup, linux-omap-2.6.27-omap1
Date: Fri, 20 Mar 2009 10:03:48 -0400
Message-ID: <1f11a5490903200703u2b477c95qf3ad1a5d8ad2cb8d@mail.gmail.com>
References: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com>
	 <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
	 <C8CB7D0E-5690-4368-B2BB-60B09B37575D@student.utwente.nl>
	 <1f11a5490903200653y4c53d047j9f54f6eec0aef64d@mail.gmail.com>
	 <dbdb2ea60903200659m4222b449n8047002b677cc0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f208.google.com ([209.85.217.208]:46337 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZCTODw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 10:03:52 -0400
Received: by gxk4 with SMTP id 4so3104300gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 07:03:49 -0700 (PDT)
In-Reply-To: <dbdb2ea60903200659m4222b449n8047002b677cc0f8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Mar 20, 2009 at 9:59 AM, twebb <taliaferro62@gmail.com> wrote:
> On Fri, Mar 20, 2009 at 9:53 AM, Ashwin Bihari <abihari@gmail.com> wr=
ote:
>> On Fri, Mar 20, 2009 at 9:44 AM, Koen Kooi <k.kooi@student.utwente.n=
l> wrote:
>>>
>>> Op 20 mrt 2009, om 14:34 heeft Ashwin Bihari het volgende geschreve=
n:
>>>
>>>> You need to add the Kernel option "rootdelay=3D1" to basically del=
ay the
>>>> Kernel for a moment while attempting to using the SDcard as the RF=
S
>>>> mount point.
>>>
>>> Since kernel 2.6.24 you can use 'rootwait', which will wait till it=
 becomes
>>> available so you don't need to keep futzing the value for different=
 SD
>>> cards.
>>>
>>> regards,
>>>
>>> Koen
>>>
>>
>> Koen,
>>
>> I wasn't aware of that option, it definitely beats futzing with wait=
 delays!
>>
>> -- Ashwin
>>
>
> The 'rootwait' works too, thanks for your suggestions.
>
> By the way, is rootfstype=3Dext3 required? =A0I know I've had to use =
it in
> the past with JFFS2, but am wondering if ext3 might be handled by
> default.
>

I most recently used an EXT2 image as my RFS and I didn't have to
specifically specify the rootfstype for it to work. So my guess is
that the FS type is probably auto-detected during mount time.

-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
