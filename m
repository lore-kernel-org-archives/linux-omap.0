From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
Date: Wed, 18 Nov 2009 06:37:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA689ED8@dbde02.ent.ti.com>
References: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
 <20091118010011.22360590@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43946 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546AbZKRBIB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:08:01 -0500
In-Reply-To: <20091118010011.22360590@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Tuesday, November 17, 2009 7:00 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org; Pandita, Vikram
>Subject: Re: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
>
>On Tue, 17 Nov 2009 17:39:11 -0600
>Vikram Pandita <vikram.pandita@ti.com> wrote:
>
>> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
>> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
>>
>> Overrigt the default 8250 read handler: mem_serial_in()
>> by a custom handler: serial_in_8250()
>>
>> serial_in_8250() makes sure that RX fifo is not read when empty,
>> on omap4 and 3630 silicons only
>>
>> tested on zoom3(3630) board
>
>Acked-by: Alan Cox <alan@linux.intel.com>
>
>(Please push it via the OMAP tree as its now OMAP specific)

Thanks for the suggestion that made it 8250 independent.
I am scared to touch this driver :)

Yes I would get this patch upstream via Tony now.
I am getting some minor review comments on linux-omap, will fix and repost.


>
>
>Alan

