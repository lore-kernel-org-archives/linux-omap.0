From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: OMAP35x GP TIMER as a wakeup trigger
Date: Tue, 28 Apr 2009 09:58:03 -0400
Message-ID: <1f11a5490904280658j4e3c3abbyb4d9069055f6ae71@mail.gmail.com>
References: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
	 <87bpqhspvo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:9751 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbZD1N6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 09:58:04 -0400
Received: by wa-out-1112.google.com with SMTP id j5so283463wah.21
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 06:58:04 -0700 (PDT)
In-Reply-To: <87bpqhspvo.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Mon, Apr 27, 2009 at 6:17 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ashwin Bihari <abihari@gmail.com> writes:
>
>> I need to implement a timer as a wake up trigger while my custom boa=
rd
>> is in the suspended state. I read in the TRM that all of the GPTIMER=
s
>> have the capability of generating a wake up interrupt. I'm using the
>> 2.6.28-rc8 PM Kernel which contains the patch to enable all the
>> GPTIMERS as wake up sources.
>
> Try the patch below on the current PM branch. =A0I use this for
> debugging PM code when no other wakeup sources (keypad, UART, etc. ar=
e
> working.)
>
> Kevin
>

Kevin.

The patch worked like a charm, thank you very much.

-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
