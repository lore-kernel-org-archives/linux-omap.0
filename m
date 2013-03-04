From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH resend] hsi: fix kernel-doc warnings
Date: Sun, 03 Mar 2013 18:58:08 -0800
Message-ID: <51340DC0.8070708@infradead.org>
References: <5130FD73.9030601@infradead.org> <CACRpkdb83GYi7FNjz-ZgbatTQzgZsB=PdkiCuVFt4TK1s2kM+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb83GYi7FNjz-ZgbatTQzgZsB=PdkiCuVFt4TK1s2kM+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nishanth Menon <nm@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/03/13 18:56, Linus Walleij wrote:
> On Fri, Mar 1, 2013 at 8:11 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix kernel-doc warnings in hsi files:
>>
>> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'e_handler' description in 'hsi_client'
>> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'pclaimed' description in 'hsi_client'
>> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'nb' description in 'hsi_client'
>> Warning(drivers/hsi/hsi.c:434): No description found for parameter 'handler'
>> Warning(drivers/hsi/hsi.c:434): Excess function parameter 'cb' description in 'hsi_register_port_event'
>>
>> Don't document "private:" fields with kernel-doc notation.
>> If you want to leave them fully documented, that's OK, but
>> then don't mark them as "private:".
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Carlos Chinea <carlos.chinea@nokia.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> HSI is basically orphaned FTM.
> 
> Andrew can you pick this into your orphanage?

Linus (Torvalds) already merged it.  Thanks.


-- 
~Randy
