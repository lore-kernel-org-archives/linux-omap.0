From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 0/8] musb: Add structure 'musb_hdrc_board_data'
Date: Wed, 18 Nov 2009 17:20:03 +0300
Message-ID: <4B040293.1020501@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> This patch set adds a new structure 'musb_hdrc_board_data' to get all
> board specific data from board files.

> It is actually done to accomodate ULPI_VBUSCONTROL programming required
> for OMAP3EVM Rev >=E which uses external Vbus supply to support 500mA.

    It's not clear why it was necessary to create yet another structure. You 
could your new field to 'struct musb_hdrc_platfrom_data'...

> Regards,
> Ajay

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
