From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 8/8] musb: set 'extvbus = 0' for Blackfin boards
Date: Tue, 17 Nov 2009 19:13:09 +0300
Message-ID: <4B02CB95.4080306@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-5-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-6-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-7-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-8-git-send-email-ajay.gupta@ti.com> <1258470596-24321-9-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258470596-24321-9-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:

> Default value of 'extvbus' is being set as '0' to maintain the
> current programming state of all Blackfin musb boards.

    Again, you could keep the structures unitialized so that they default to 
all zeros (which they do anyway for the 'power' and 'potpgt' fields with 
your patch).

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
