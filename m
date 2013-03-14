From: kishon <kishon@ti.com>
Subject: Re: [PATCH 2/5] usb: musb: omap: always glue have the correct vbus/id
 status
Date: Thu, 14 Mar 2013 10:56:05 +0530
Message-ID: <51415F6D.1030503@ti.com>
References: <1363164430-19118-1-git-send-email-kishon@ti.com> <1363164430-19118-3-git-send-email-kishon@ti.com> <CANOLnOPG9Rbj=XNXtyeReoEzHpegSuZT0QKhEy7QdbVjO4OUPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnOPG9Rbj=XNXtyeReoEzHpegSuZT0QKhEy7QdbVjO4OUPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thursday 14 March 2013 03:29 AM, Grazvydas Ignotas wrote:
> On Wed, Mar 13, 2013 at 10:47 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> In the case where omap glue is loaded and musb core is not, glue->status
>> wont have a valid status if the phy drivers call omap_musb_mailbox. So
>> fixed the conditions here.
>
> There already seems to be another patch named "usb: musb: omap2430:
> fix omap_musb_mailbox glue check again" on it's way to mainline that
> does mostly the same as first part of this patch.

Oh yeah. Missed that.

Thanks
Kishon
