From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Date: Tue, 22 Oct 2019 18:14:38 +0200
Message-ID: <8FCDC0F6-7734-4629-9646-7BEED89FEF25@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com> <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com> <CAL_Jsq+obsTSU3iP1wm_3-FsAJ4Mxiz0NbMY1_h5NeFn67Sj+A@mail.gmail.com> <CEA29A3B-4116-4FE3-8E18-0C97353688DC@goldelico.com> <20191021172557.GB5610@atomide.com> <C6CD5A50-7F0A-4F56-ABB9-CAEDF7E47A5D@goldelico.com> <20191022150202.GJ5610@atomide.com> <CC62CE92-28DF-406E-B61C-22F8F341AAFB@goldelico.com> <20191022153650.GL5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022153650.GL5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 22.10.2019 um 17:36 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [191022 15:12]:
>> Hm. How should that work? Some SoC have the sgx544 as single
>> core and others as dual core. This imho does not fit into
>> the "img,sgx544-$revision" scheme which could be matched to.
> 
> Well don't you have then just two separate child nodes,
> one for each core with their own register range?

Doesn't look so. AFAIK the architecture of SGX is that there
is a single scheduler which is accessed by the register range
and it internally has control over multiple cores.

> 
> That is assuming they're really separate instances..

No. There is some internal magic in the driver. It just
needs to know that there is one or two nodes. Currently
this is handled by some #define option when calling the
inner Makefile.

My idea was to replace the #ifdef by checking for the
img,cores property.

> 
>> But maybe we do it the same as with the timer for the moment,
>> i.e. keep it in some unpublished patch set.
> 
> Yeah makes sense to me until things get sorted out.
> 
>> At the moment I have more problems understanding how the yaml
>> thing works. I understand and fully support the overall goal,
>> but it is quite difficult to get a start here. And there do not
>> seem to be tools or scripts to help converting from old style
>> text format (even if not perfect, this would be helpful) and
>> I have no yaml editor that helps keeping the indentation
>> correct. So this slows down a v2 a little bit.
> 
> Sounds handy to me :)
> 
> Regards,
> 
> Tony
