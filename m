From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
Date: Mon, 2 Apr 2018 17:03:13 +0300
Message-ID: <CAHp75VdLNQ8VMWUZMOtP75vSEvxHtOihV-qA1LqB-S6QThmiFA@mail.gmail.com>
References: <20180402122037.2710-1-vigneshr@ti.com> <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 2, 2018 at 5:01 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 2, 2018 at 3:20 PM, Vignesh R <vigneshr@ti.com> wrote:

>> +       if (!device_may_wakeup(dev))
>> +               priv->wer = 0;
>
> Can it be
>
> priv->wer = device_may_wakeup(dev);
>
> ?

Answering to myself, missed that this value is used as actual one for the HW.

-- 
With Best Regards,
Andy Shevchenko
