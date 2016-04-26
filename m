From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix
 pcs_parse_bits_in_pinctrl_entry to use __ffs than ffs
Date: Tue, 26 Apr 2016 09:17:04 -0700
Message-ID: <20160426161704.GU5995@atomide.com>
References: <1460609956-26539-1-git-send-email-j-keerthy@ti.com>
 <CACRpkdZxY3FNti37HfuwS7KT9K+pA=REr_G=hEQRi-D3=CHUpQ@mail.gmail.com>
 <20160415152215.GR5995@atomide.com>
 <CACRpkdZa=v1iKZ=eiY11V3qZV9pPqtoi6vHm2Pu4ctWTFiy0TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZa=v1iKZ=eiY11V3qZV9pPqtoi6vHm2Pu4ctWTFiy0TA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [160423 02:46]:
> On Fri, Apr 15, 2016 at 5:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@linaro.org> [160415 02:29]:
> >> Patch applied for fixes with Tony's ACK.
> >>
> >> Should it also be tagged for stable?
> >
> > Probably a good idea, I can see somebody pulling hair out because
> > of this in various product trees.
> 
> Ooops sorry I totally missed to add that :(
> 
> Please ask Greg to take it as a selected stable patch.

Well it has the fixes tag, let's see if the stable people will
find it automatically now :) If not, Keerthy can send email
requesting adding it manually to stable trees.

Tony
