From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed
 binned / 720MHz grade bits
Date: Wed, 2 Oct 2019 11:00:32 +0200
Message-ID: <CAKohpo=44UkJ3RBjtB8F3=1D9HzicULh303jF2uowiboa2328g@mail.gmail.com>
References: <cover.1568224032.git.hns@goldelico.com> <20190916162816.GF52127@atomide.com>
 <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, linux-a
List-Id: linux-omap@vger.kernel.org

On Tue, 17 Sep 2019 at 16:35, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Tony,
>
> > Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
> >
> > * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> >> CHANGES V3:
> >> * make omap36xx control the abb-ldo and properly switch mode
> >>  (suggested by Adam Ford <aford173@gmail.com>)
> >> * add a note about enabling the turbo-mode OPPs
> >
> > Looks good to me, when applying, please provide a
> > minimal immutable branch maybe against v5.3 or v5.4-rc1,
> > that I can also merge in if needed for the dts changes.
>
> Should I resend a v4 with your Acked-By added?

I will pick them up in a few days. I was waiting for rc1 to get released and
am on vacation right now. Tony already provided his Acks.

--
viresh
