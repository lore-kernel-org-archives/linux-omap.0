From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/5] char: ti-usim: Add driver for USIM module on AM43xx
Date: Tue, 4 Feb 2014 15:19:40 +0200
Message-ID: <52F0E8EC.8030900@ti.com>
References: <1390192434-19386-1-git-send-email-satish.patel@ti.com> <1390192434-19386-4-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390192434-19386-4-git-send-email-satish.patel-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Satish,

On 01/20/2014 06:33 AM, Satish Patel wrote:
> TI-USIM driver is a platform driver that provides a character
> driver interface to user applications.
> 
> It allows user applications to call IOCTL's to
> perform smart card operations.
> 
> Driver currently supports
> - ATR
> - T=0 & T=1 protocol
> - clock stop mode
> - smart card clock configuration
> - Tx/Rx application data units (APDU) to smart card
> - Interface to PHY using DT & phy interface
> 
> Validation is done with ACOS3 smart cards
> 
> Signed-off-by: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/ti-usim/ti-usim.txt        |   31 +
>  drivers/char/Kconfig                               |    7 +
>  drivers/char/Makefile                              |    1 +
>  drivers/char/ti-usim-hw.h                          |  863 +++++++++
>  drivers/char/ti-usim.c                             | 1859 ++++++++++++++++++++

ti-usim.c is a very large driver that does everything but looks like limited to TI hardware.
How about splitting it into generic stuff and hw specific glue logic so that most of the generic stuff
could be used by different hardware types.

>  include/linux/ti-usim.h                            |   98 +
>  6 files changed, 2859 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ti-usim/ti-usim.txt
>  create mode 100644 drivers/char/ti-usim-hw.h
>  create mode 100644 drivers/char/ti-usim.c
>  create mode 100644 include/linux/ti-usim.h
> 

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
