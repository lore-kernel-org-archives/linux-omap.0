From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap 0sk and mistral touchscreen..
Date: Wed, 28 May 2008 00:31:32 +0530
Message-ID: <a1d91fa0805271201w4c3f7f0bw98ac9a4ac1bdc4f9@mail.gmail.com>
References: <a1d91fa0805252349w266c2f8x11377f2dce066b93@mail.gmail.com>
	 <a1d91fa0805262126v65745282k4ac45d3e71c1894f@mail.gmail.com>
	 <001101c8bfb7$01e58ac0$310da8c0@mistral.in>
	 <a1d91fa0805262232g4a441f5fwdb62a7015b1f0e84@mail.gmail.com>
	 <cb8016980805262237q54980f33y6a58d7fdf25328f5@mail.gmail.com>
	 <a1d91fa0805262239m10ae2836p776c94207852e19f@mail.gmail.com>
	 <a1d91fa0805262330h5e3990b9u1ce4577d3fc269fa@mail.gmail.com>
	 <a1d91fa0805270642i66744055oe2f3f72863065995@mail.gmail.com>
	 <a1d91fa0805270702g41f95fdfi21cbd4a5a806951e@mail.gmail.com>
	 <20080527184109.GB18735@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:60890 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbYE0TBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2008 15:01:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1915434tic.23
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 12:01:36 -0700 (PDT)
In-Reply-To: <20080527184109.GB18735@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "S. Rajeev" <srajeev@mistralsolutions.com>, omap <linux-omap@vger.kernel.org>

Hi,

no i didnt specify the arch flag?

what is the arch flag for omap 5912 osk?

could you please tell me the full ./configure line?

thank you.

regards,
Shareef

On Wed, May 28, 2008 at 12:11 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Tue, May 27, 2008 at 07:32:12PM +0530, mohammed shareef wrote:
>> Hi,
>> everything looks fine from the kernel side. I think the problem might
>> be in the file system. i have used the following options to get the
>> touchscreen files compiled from tslib:
>>
>> ./autogen.sh
>>
>> ./configure --prefix=/tslib --host=arm-linux-gnu
>>
>> make
>>
>> make install
>>
>> is it right?
>
> Are you compiling inside the arm system??
> doesn't tslib has a --target=<arch> flag??
>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>
