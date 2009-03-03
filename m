From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Anyone built the kernel drivers for the PowerVR under
	linux-omap-2.6?
Date: Tue, 3 Mar 2009 15:43:53 +0200
Message-ID: <94a0d4530903030543m64db72c8ifdac66ff162f775a@mail.gmail.com>
References: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
	 <1D24AF54-A1B5-4BFD-BBB3-09E1BB1F0A7F@student.utwente.nl>
	 <1236083245.7924.26.camel@surfer>
	 <B3546260-AC1E-4601-BC8D-74AB9A16B144@student.utwente.nl>
	 <1236085678.7924.48.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:51711 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZCCNn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 08:43:56 -0500
Received: by fxm24 with SMTP id 24so2439859fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 05:43:53 -0800 (PST)
In-Reply-To: <1236085678.7924.48.camel@surfer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Mar 3, 2009 at 3:07 PM, David Hagood <david.hagood@gmail.com> wrote:
> On Tue, 2009-03-03 at 13:30 +0100, Koen Kooi wrote:
>
> OK, I apologize in advance, but that statement has pricked the festering
> boil of my feelings about this matter, and I feel that I must address
> it.

<amusing OE failure story/>

> Sorry, but I am NOT going to base MY project on something that I cannot
> get working after several WEEKS of effort to get working.

Me neither, and I *did* try hard, and I even fixed some issues in
bitbake AFAICR, but they weren't even interested.

IMHO if something works on OE and it doesn't work on upstream that
just means somebody hasn't done their job thoroughly; things should go
into upstream.

I had that issue with ALSA, so I took the matter in my own hands and
pushed a patch into linux-omap, even if I had no idea of what I was
doing at least it was a start for the ones that did know.

Cheers.

-- 
Felipe Contreras
