From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
Date: Sat, 12 Nov 2016 09:58:46 -0800
Message-ID: <20161112175845.GP7138@atomide.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
 <20161112112009.34gwcedl57v77ng5@earth>
 <CAKP5S=27ZHZyKj9LWVDaeSXzCyrsrJmNbc3r-YRXXXKsk74yag@mail.gmail.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCQPVKWLVAIRBW5QTXAQKGQE3IIOT7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKP5S=27ZHZyKj9LWVDaeSXzCyrsrJmNbc3r-YRXXXKsk74yag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Nicolae Rosia <nicolae.rosia.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nicolae Rosia <nicolae.rosia.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [161112 03:37]:
> Hi,
> 
> 
> On Sat, Nov 12, 2016 at 1:20 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > This patch is missing long description. I would have patched it the
> > other way around. There is no reason to use irq_of_parse_and_map if
> > generic platform_get_irq can be used.
> Since this patch series removes platform support and makes the driver DT only,
> I thought it would be a good idea to make it explicit that it depends on OF_IRQ.

You can still use platform_get_irq(), eventually that will be just some
generic call. Don't we already have the "generic" names defined somewhere
in kernel?

Regards,

Tony

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
