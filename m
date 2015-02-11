From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 11 Feb 2015 12:29:37 +0200
Message-ID: <CAK=WgbaHEbqVVBAUL1aaO3i+pPbTZM2DRB=1kSE6A6+pPmS4yQ@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com> <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej> <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej> <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
 <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
 <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
 <54CFE71E.20905@ti.com> <CAJAp7OiHfaMrVqaZ1r6ZN0aMMpE4OUnvLhODHQJeb6EJMa+o8A@mail.gmail.com>
 <54D406BA.6060403@ti.com> <CAJAp7Ojud6UM97eDYdUhZxzzjNRw_47e5kqh4UxwDBMwFZpuoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJAp7Ojud6UM97eDYdUhZxzzjNRw_47e5kqh4UxwDBMwFZpuoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>
Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 6, 2015 at 2:34 AM, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org> wrote:
>> Yep, will do as soon as I hear from Ohad on what to do with the patch
>> "hwspinlock/core: maintain a list of registered hwspinlock banks" that I
>> dropped from v7. Without that and dropping hwlock-base-id, I can't get
>> the translations done.
>>
>
> My suggestion is to replace the global id-tree with a list of hwlocks
> and iterate over these if we ever get more than one driver registered.
> As long as #hwlock-drivers < log(#total-hwlocks) this should be
> faster.
>
> I would however argue that clients that would notice any kind of
> difference are using the API incorrectly.
>
> Unfortunately this is a somewhat larger change than just slapping DT
> support on the framework :/

I suspect we want to wait with framework changes until there's a real
hardware use case justifying them.

With regard to DT, however, we obviously do want to be prepared for
multiple hwlock blocks even if they do not exist today.

So how about adopting an approach where:
- DT fully supports multi hwlock blocks (i.e. no global id field)
- Framework left mostly unchanged at the moment. This means issuing an
explicit error in case a secondary hwlock block shows up, and then
hwlock id could trivially be the lock index.

If multi hwlock hardware use case, or some new hwlock id translation
requirements, do show up in the future, it's always easy to add
framework support for it. At that point we'll know better what the
requirements are, and framework changes would be justifiable.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
