From: "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] net: bluetooth: Fix build error from rfcomm/tty.c
Date: Sun, 8 Aug 2010 15:24:15 -0300
Message-ID: <20100808182414.GB9339@vigoh>
References: <1281258478-17335-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1281258478-17335-1-git-send-email-santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

* Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org> [2010-08-08 14:37:58 +0530]:

> The build error is as follows:
> `rfcomm_cleanup_ttys' referenced in section `.init.text' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> make: *** [.tmp_vmlinux1] Error 1
> 
> This patch fixes by removing __exit from fucntion 'rfcomm_cleanup_ttys'
> to avoid section mismatch
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
> ---
>  net/bluetooth/rfcomm/tty.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

We have fixed that already, thanks anyway. ;)

-- 
Gustavo F. Padovan
http://padovan.org
