From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
Date: Tue, 17 Sep 2019 16:35:22 +0200
Message-ID: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com> <20190916162816.GF52127@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916162816.GF52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
>> CHANGES V3:
>> * make omap36xx control the abb-ldo and properly switch mode
>>  (suggested by Adam Ford <aford173@gmail.com>)
>> * add a note about enabling the turbo-mode OPPs
> 
> Looks good to me, when applying, please provide a
> minimal immutable branch maybe against v5.3 or v5.4-rc1,
> that I can also merge in if needed for the dts changes.

Should I resend a v4 with your Acked-By added?

BR and thanks,
Nikolaus
