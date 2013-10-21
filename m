From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
Date: Tue, 22 Oct 2013 01:26:05 +0200
Message-ID: <3264724.noW9GbyjJ9@avalon>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org> <1805938.y3dym69kEh@avalon> <52644C88.5060608@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52644C88.5060608-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Sunday 20 October 2013 22:35:04 Stephen Warren wrote:
> On 10/20/2013 01:41 PM, Laurent Pinchart wrote:
> > On Tuesday 17 September 2013 17:36:32 Grant Likely wrote:
> >> On Thu, 12 Sep 2013 17:57:00 +0200, Alexander Holler wrote:
> >>> Am 12.09.2013 17:19, schrieb Stephen Warren:
> >>>> IRQs, DMA channels, and GPIOs are all different things. Their bindings
> >>>> are defined independently. While it's good to define new types of
> >>>> bindings consistently with other bindings, this hasn't always happened,
> >>>> so you can make zero assumptions about the IRQ bindings by reading the
> >>>> documentation for any other kind of binding.
> >>>> 
> >>>> Multiple interrupts are defined as follows:
> >>>> 	// Optional; otherwise inherited from parent/grand-parent/...
> >>>> 	interrupt-parent = <&gpio6>;
> >>>> 	// Must be in a fixed order, unless binding defines that the
> >>>> 	// optional interrupt-names property is to be used.
> >>>> 	interrupts = <1 IRQF_TRIGGER_HIGH> <2 IRQF_TRIGGER_LOW>;
> >>>> 	// Optional; binding for device defines whether it must
> >>>> 	// be present
> >>>> 	interrupt-names = "foo", "bar";
> >>>> 
> >>>> If you need multiple interrupts, each with a different parent, you need
> >>>> to use an interrupt-map property...
> 
> ...
> 
> >> Actually, I think it is solveable but doing so requires a new binding
> >> for interrupts. I took a shot at implementing it earlier this week and
> >> I've got working patches that I'll be posting soon. I created a new
> >> "interrupts-extended" property that uses a phandle+args type of
> 
> >> binding like this:
> ...
> 
> >> device@3000 {
> >> 	interrupts-extended = <&intc1 5> <&intc2 3 4> <&intc1 6>;
> >> };
> 
> ...
> 
> > Any progress on this ? I'll need to use multiple interrupts with different
> > parents in the near future, I can take this over if needed.
> > 
> > I've also been thinking that we could possibly reuse the "interrupts"
> > property without defining a new "interrupts-extended". When parsing the
> > property the code would use the current DT bindings if an
> > interrupt-parent is present, and the new DT bindings if it isn't.
> 
> interrupt-parents doesn't have to be present in individual nodes; it can
> be inherited from the parent. That means you'd have to convert whole
> sub-trees at once.

Very good point. I agree with you, a new property is then better.

> It seems much more flexible to use a new property and hence make it explicit
> what format the data is in.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
