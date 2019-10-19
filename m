From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: ARM: add __always_inline to functions called from __get_user_check()
Date: Sat, 19 Oct 2019 10:59:46 +0900
Message-ID: <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
References: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 18, 2019 at 7:06 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi,
> I wonder what happened to your patch. We were "hit" by it in v5.4-rc1 and
> after finding, it made our OMAP based device bootable again (using our
> own defconfig which optimizes for SIZE).
>
> But it does not seem to have arrived in linux-next

It is in linux-next.


> and should IMHO
> be fixed during the v5.4 release candidate cycle.

I agree.


Masahiro

>
> BR and thanks,
> Nikolaus Schaller
>


-- 
Best Regards
Masahiro Yamada
