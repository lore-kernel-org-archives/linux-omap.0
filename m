From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5] usb: musb: move work_struct(otg_notifier_work) from
 core to omap glue
Date: Tue, 05 Jun 2012 16:00:08 +0400
Message-ID: <4FCDF4C8.2090403@mvista.com>
References: <1338889118-10032-1-git-send-email-kishon@ti.com> <1338889118-10032-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338889118-10032-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 05-06-2012 13:38, Kishon Vijay Abraham I wrote:

> Commit 712d8e

    Please also specify that commit's summary in parens.

> fixed pm_runtime calls while atomic by using a work queue.
> While the issue and the work queue implementation is specific to omap
> (omap2430.c), the work_struct is defined as a member of struct musb
> (musb_core.h). Hence moved the work_struct from musb_core to omap
> glue.

> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
