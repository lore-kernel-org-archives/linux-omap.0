From: twebb <taliaferro62@gmail.com>
Subject: Re: mmc0 detection timing at kernel startup, linux-omap-2.6.27-omap1
Date: Fri, 20 Mar 2009 09:59:13 -0400
Message-ID: <dbdb2ea60903200659m4222b449n8047002b677cc0f8@mail.gmail.com>
References: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com>
	 <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
	 <C8CB7D0E-5690-4368-B2BB-60B09B37575D@student.utwente.nl>
	 <1f11a5490903200653y4c53d047j9f54f6eec0aef64d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:44723 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZCTN7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:59:19 -0400
Received: by qyk16 with SMTP id 16so1258377qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 06:59:17 -0700 (PDT)
In-Reply-To: <1f11a5490903200653y4c53d047j9f54f6eec0aef64d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Mar 20, 2009 at 9:53 AM, Ashwin Bihari <abihari@gmail.com> wrote:
> On Fri, Mar 20, 2009 at 9:44 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>>
>> Op 20 mrt 2009, om 14:34 heeft Ashwin Bihari het volgende geschreven:
>>
>>> You need to add the Kernel option "rootdelay=1" to basically delay the
>>> Kernel for a moment while attempting to using the SDcard as the RFS
>>> mount point.
>>
>> Since kernel 2.6.24 you can use 'rootwait', which will wait till it becomes
>> available so you don't need to keep futzing the value for different SD
>> cards.
>>
>> regards,
>>
>> Koen
>>
>
> Koen,
>
> I wasn't aware of that option, it definitely beats futzing with wait delays!
>
> -- Ashwin
>

The 'rootwait' works too, thanks for your suggestions.

By the way, is rootfstype=ext3 required?  I know I've had to use it in
the past with JFFS2, but am wondering if ext3 might be handled by
default.
