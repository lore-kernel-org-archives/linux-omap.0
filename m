From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed
 binned / 720MHz grade bits
Date: Wed, 2 Oct 2019 07:47:07 +0200
Message-ID: <8C3DD775-07DF-45E0-8E04-2B050CEB5800@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <20190916162816.GF52127@atomide.com>
 <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-pm@vger.kernel.org, Enric Balletbo i Serra <eballetbo@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Teresa Remmet <t.remmet@phytec.de>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Am 17.09.2019 um 16:35 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Tony,
> 
>> Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
>> 
>> * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
>>> CHANGES V3:
>>> * make omap36xx control the abb-ldo and properly switch mode
>>> (suggested by Adam Ford <aford173@gmail.com>)
>>> * add a note about enabling the turbo-mode OPPs
>> 
>> Looks good to me, when applying, please provide a
>> minimal immutable branch maybe against v5.3 or v5.4-rc1,
>> that I can also merge in if needed for the dts changes.
> 
> Should I resend a v4 with your Acked-By added?
> 
> BR and thanks,
> Nikolaus
> 

what is the procedure to get this and Adam's thermal setup into linux-next?
BR and thanks,
Nikolaus
