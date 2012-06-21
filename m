From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
Date: Thu, 21 Jun 2012 15:55:21 +0400
Message-ID: <4FE30BA9.1070108@mvista.com>
References: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com> <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340275473-16374-1-git-send-email-Russ.Dill-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Volodymyr Mieshkov <x0182794-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, yan-liu-l0cyMroinI0@public.gmane.org, aparnab-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 21-06-2012 14:44, Russ Dill wrote:

> A recent commit, [PATCH] Fix OMAP EHCI suspend/resume failure
> (i693) '354ab856'

    Usually commit ID follows the word "commit", and then the commit summary.

> causes ehci probe to fail on omap3xxx. This
> exposed bugs in the ehci_hcd_omap_probe error path causing
> an oops.

> On the error path, call usb_remove_hcd if usb_add_hcd has been
> called, and call usb_put_hcd if usb_alloc_hcd has been called.

> Tested on BB-xM.

> Signed-off-by: Russ.Dill-l0cyMroinI0@public.gmane.org

    It should be:

Signed-off-by: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
