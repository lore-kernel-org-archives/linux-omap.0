From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Fri, 18 Jan 2019 07:35:42 -0800
Message-ID: <20190118153541.GU5544@atomide.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
 <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de>
 <CAPDyKFoqfyvQRnSBRvPVxrL-nmf1YoSzxRkPfGwr==L3LOwgaw@mail.gmail.com>
 <5bf8514a-eb15-b098-1857-835b36d4a67c@web.de>
 <CAPDyKFo=m50jiQ639xzP9tzn+=Bn0CXXwO6p0_jPH0EnSc0UQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo=m50jiQ639xzP9tzn+=Bn0CXXwO6p0_jPH0EnSc0UQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [190118 15:09]:
> On Fri, 18 Jan 2019 at 13:09, Jan Kiszka <jan.kiszka@web.de> wrote:
> > Yeah, I'm not claiming at all I know what I'm doing there, just that it happens
> > to work.
> 
> I see. Good to know, thanks!

This seems like some separate issue. I wonder if adding
another reset just before pm_runtime_put() clears this
one instead of using the msleep? Just guessing..

Regards,

Tony
