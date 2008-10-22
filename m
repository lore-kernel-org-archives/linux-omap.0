From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Wed, 22 Oct 2008 14:52:07 -0700
Message-ID: <a46a26fd0810221452x1edfead1l524270ddaf250e2a@mail.gmail.com>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
	 <200810221446.11415.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.246]:56099 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYJVVwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 17:52:09 -0400
Received: by ag-out-0708.google.com with SMTP id 31so5028398agc.10
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 14:52:08 -0700 (PDT)
In-Reply-To: <200810221446.11415.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 22, 2008 at 2:46 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 22 October 2008, Juha Kuikka wrote:
>> -       __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
>> +       __raw_readsl(nand->IO_ADDR_R, buf, len / 4);
>>  }
>
> Shouldn't that have been __raw_readsw() though?
>
Hmh, good point.

>From the original code it looks like that was the intention but
readsl() works just as well.

I tested this on OMAP2430 and it works ok.

I don't see any mentions in the TRM about the width of the
GPMC_NAND_DATA registers but apparently the NAND engine happily
accepts 32bit accesses on bus.


 - Juha


-- 
Madness takes it's toll. Please have exact change.
