From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 1/5] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 12 Nov 2014 11:08:51 -0600
Message-ID: <54639423.3030607@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-2-git-send-email-s-anna@ti.com> <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Kumar, Mark, Rob,

On 11/12/2014 09:14 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>> This patch adds the generic common bindings used to represent
>> a hwlock device and use/request locks in a device-tree build.
>>
> ...
>>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/hwlock/hwlock.txt          | 55 ++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
> 
> Please ask a DT maintainer to ACK this - otherwise I can't send this to Linus.
> 

Can one of you ack this patch and the next patch [1] so that Ohad can
pick up the series for 3.19? This series has been in works for quite
some time now and was reviewed by each of you at some point of time
(thanks!!), the cover letter [2] has the history of the changes.

regards
Suman

[1] https://patchwork.kernel.org/patch/4898001/
[2] http://marc.info/?l=linux-omap&m=141055365213895&w=2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
