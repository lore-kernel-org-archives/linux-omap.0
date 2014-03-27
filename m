From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 09/11] bluetooth: hci_ldisc: fix deadlock condition
Date: Wed, 26 Mar 2014 22:20:15 -0400
Message-ID: <53338ADF.3060803@hurleysoftware.com>
References: <1395343807-21618-1-git-send-email-balbi@ti.com> <1395343807-21618-9-git-send-email-balbi@ti.com> <53337513.1010708@hurleysoftware.com> <20140327020909.GA11651@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140327020909.GA11651-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/26/2014 10:09 PM, Felipe Balbi wrote:
>> I just noticed this patch wasn't addressed to Marcel;
>> seems like this should go through the bluetooth tree (but not
>> through bluetooth-next because it fixes an oops).
>
> read the archives:
>
> http://marc.info/?l=linux-bluetooth&m=139534449409583&w=2

Sorry. I did actually get Marcel's reply but Thunderbird
didn't parent the reply properly in my inbox and I forgot about it.


>> Marcel,
>>
>> You may want to build on top of this patch split handling;
>> I noticed some of the protocol drivers are calling
>> hci_uart_tx_wakeup() from work functions already (so don't
>> need to schedule another work...)
>
> I don't think that should be part of $subject, though.

I don't understand what you mean here.

Regards,
Peter Hurley
